class AddDescriptionToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :description, :text
  end
end
