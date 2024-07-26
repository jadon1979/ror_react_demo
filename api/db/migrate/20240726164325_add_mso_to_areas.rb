class AddMsoToAreas < ActiveRecord::Migration[7.1]
  def change
    add_column :areas, :mso_id, :integer
    add_index :areas, :mso_id
  end
end
