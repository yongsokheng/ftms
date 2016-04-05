class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :avatar
      t.text :description
      t.text :content
      t.integer :task_master_id
      t.boolean :admin_task
      t.references :assigned_trainee, references: :users
      t.references :course_subject, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
