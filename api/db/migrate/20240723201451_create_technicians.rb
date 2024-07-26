class CreateTechnicians < ActiveRecord::Migration[7.1]
  def change
    create_table :technicians do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :tech_id

      t.timestamps
    end
  end
end

