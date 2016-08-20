class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :chat_room_id
      t.string :chat_room_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
