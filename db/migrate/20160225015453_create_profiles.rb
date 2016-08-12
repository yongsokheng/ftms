class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.date :start_training_date
      t.date :leave_date
      t.date :finish_training_date
      t.boolean :ready_for_project
      t.date :contract_date
      t.string :naitei_company
      t.date :graduation
      t.integer :user_type_id
      t.integer :university_id
      t.integer :programming_language_id
      t.integer :user_progress_id
      t.integer :status_id
      t.timestamps null: false

      t.references :location, index: true, foreign_key: true
    end
  end
end
