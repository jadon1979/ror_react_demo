class AddCompanyIdToJobRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :job_routes, :company_id, :integer
    add_index :job_routes, :company_id
  end
end
