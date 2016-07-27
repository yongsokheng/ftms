class CreateUserTasks < ActiveRecord::Migration
  def change
    create_table :user_tasks do |t|
      t.references :task, index: true, foreign_key: {on_delete: :cascade}
      t.references :user_subject, index: true, foreign_key: {on_delete: :cascade}
      t.references :user, index: true, foreign_key: true
      t.integer :progress, default: 0
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
