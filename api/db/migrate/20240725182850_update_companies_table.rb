class UpdateCompaniesTable < ActiveRecord::Migration[7.1]
  def change
    change_table :companies do |t|
      t.string :phone_number
      t.string :address_1
      t.string :address_2
      t.string :city
      t.integer :state_id, null: false, default: 0
      t.string :zip
    end
  end
end
