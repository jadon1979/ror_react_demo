class CreateJobRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :job_routes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tech_id
      t.string :account_number
      t.integer :job_type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :home_phone
      t.string :other_phonne
      t.datetime :job_date
      t.string :job_number
      t.integer :status
      t.string :time_frame
      t.datetime :time_started
      t.datetime :time_completed
      t.boolean :hhc_completed

      t.timestamps
    end
  end
end
