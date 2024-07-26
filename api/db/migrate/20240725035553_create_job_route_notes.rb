class CreateJobRouteNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :job_route_notes do |t|
      t.references :job_route, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :note

      t.timestamps
    end
  end
end
