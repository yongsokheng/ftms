class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.timestamps null: false

      t.references :user, index: true, foreign_key: true
    end
  end
end
