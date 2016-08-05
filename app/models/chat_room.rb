class ChatRoom < ApplicationRecord
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :receiver, polymorphic: true

  has_many :messages, dependent: :destroy
end
