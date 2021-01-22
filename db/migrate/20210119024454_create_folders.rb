class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.string :path
      t.bigint :parent_id
      t.timestamps
    end
  end
end
