class AddMsoIdToInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :mso_id, :integer
    add_index :inventories, :mso_id
  end
end
