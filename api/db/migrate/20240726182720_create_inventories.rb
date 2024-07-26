class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.integer :action_status_id
      t.references :inventory_type, null: false, foreign_key: true
      t.string :serial_number
      t.datetime :date_received
      t.datetime :date_refreshed
      t.datetime :date_issued
      t.datetime :date_signed
      t.datetime :date_installed
      t.datetime :date_returned
      t.integer :area_id
      t.string :tech_id
      t.boolean :hhc_completed
      t.string :account_number
      t.references :job_route, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
