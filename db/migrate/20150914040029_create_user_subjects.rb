class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.integer :status, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.references :user_course, index: true, foreign_key: true
      t.references :course_subject, index: true, foreign_key: {on_delete: :cascade}
      t.date :start_date
      t.date :end_date
      t.integer :during_time, default: 0
      t.integer :progress, default: 0

      t.timestamps null: false
    end
  end
end
