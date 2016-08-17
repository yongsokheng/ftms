class Message < ApplicationRecord
  belongs_to :chat_room, polymorphic: true
  belongs_to :user

  validates :content, presence: true

  scope :load_messages, -> {includes(:user).limit Settings.chats.message_per_page}
  scope :unseen, ->{where seen: false}

  delegate :name, to: :user, prefix: true, allow_nil: true

  after_create_commit :broadcast_message

  def owner? user_id
    self.user_id == user_id
  end

  class << self
    def unseen_number
      count = unseen.size
      count > 0 ? count : nil
    end
  end

  private
  def broadcast_message
    channel = "channel_#{chat_room_type.downcase}_#{chat_room_id}"
    MessageBroadcastJob.perform_later channel, self
  end
end
