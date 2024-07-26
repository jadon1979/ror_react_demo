class CreateStates < ActiveRecord::Migration[7.1]
  def change
    create_table :states do |t|
      t.string :name
      t.string :abbreviation
    end
  end
end
