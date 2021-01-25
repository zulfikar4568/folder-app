class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :description
      t.string :content
      t.string :version
      t.belongs_to :folder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
