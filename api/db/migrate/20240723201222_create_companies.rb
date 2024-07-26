class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.references :mso, null: false, foreign_key: true

      t.timestamps
    end
  end
end
