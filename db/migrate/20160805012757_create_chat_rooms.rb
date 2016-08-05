class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :receiver_type
      t.timestamps
    end
  end
end
