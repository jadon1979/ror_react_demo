class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.integer :status, null: false, default: 0
      t.integer :role, null: false, default: 0
      t.string :phone_number
      t.string :address_1
      t.string :address_2
      t.string :city
      t.integer :state_id, null: false, default: 0
      t.string :zip

      t.timestamps
    end

    add_index :users, :state_id
  end
end
