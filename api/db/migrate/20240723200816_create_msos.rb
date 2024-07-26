class CreateMsos < ActiveRecord::Migration[7.1]
  def change
    create_table :msos do |t|
      t.string :name
      t.string :domain

      t.timestamps
    end
  end
end
