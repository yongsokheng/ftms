class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.boolean :read
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
