class AddUserEndDateToUserSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :user_subjects, :user_end_date, :date
  end
end
