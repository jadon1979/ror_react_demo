class AddAreaToJobRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :job_routes, :area_id, :integer
    add_index :job_routes, :area_id
  end
end
