class Message < ApplicationRecord
  belongs_to :chat_room, polymorphic: true
  belongs_to :user
end
