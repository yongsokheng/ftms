class Message < ApplicationRecord
  belongs_to :chat_room, polymorphic: true
  belongs_to :user

  validates :content, presence: true

  scope :load_messages, -> {includes(:user).limit Settings.chats.message_per_page}
  scope :unseen, ->{where seen: false}

  delegate :name, to: :user, prefix: true, allow_nil: true

  def owner? user_id
    self.user_id == user_id
  end

  class << self
    def unseen_number
      count = unseen.size
      count > 0 ? count : nil
    end
  end
end
