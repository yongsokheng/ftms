class Conversation < ApplicationRecord
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id

  has_many :messages, as: :chat_room, dependent: :destroy

  scope :existing_conversation, -> sender_id, receiver_id{
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
    sender_id, receiver_id, receiver_id, sender_id)
  }
end
