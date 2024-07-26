class CreateInventoryTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :inventory_types do |t|
      t.string :name
      t.references :mso, null: false, foreign_key: true
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
