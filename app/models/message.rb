class Message < ApplicationRecord
  belongs_to :chat_room, polymorphic: true
  belongs_to :user

  acts_as_readable on: :created_at
  
  validates :content, presence: true

  scope :load_messages, ->{includes(:user).order id: :desc}
  scope :unseen, ->{where seen: false}

  delegate :name, to: :user, prefix: true, allow_nil: true

  def is_owner? user_id
    self.user_id == user_id
  end
end
