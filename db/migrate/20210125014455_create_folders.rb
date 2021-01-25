class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :path
      t.bigint :parent_id
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
