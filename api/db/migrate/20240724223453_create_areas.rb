class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.references :state, null: false, foreign_key: true
      t.string :zip

      t.timestamps
    end
  end
end
