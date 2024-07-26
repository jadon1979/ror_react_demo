# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_26_193033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.bigint "state_id", null: false
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mso_id"
    t.index ["mso_id"], name: "index_areas_on_mso_id"
    t.index ["state_id"], name: "index_areas_on_state_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.bigint "mso_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.integer "state_id", default: 0, null: false
    t.string "zip"
    t.index ["mso_id"], name: "index_companies_on_mso_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "action_status_id"
    t.bigint "inventory_type_id", null: false
    t.string "serial_number"
    t.datetime "date_received"
    t.datetime "date_refreshed"
    t.datetime "date_issued"
    t.datetime "date_signed"
    t.datetime "date_installed"
    t.datetime "date_returned"
    t.integer "area_id"
    t.string "tech_id"
    t.boolean "hhc_completed"
    t.string "account_number"
    t.bigint "job_route_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mso_id"
    t.index ["inventory_type_id"], name: "index_inventories_on_inventory_type_id"
    t.index ["job_route_id"], name: "index_inventories_on_job_route_id"
    t.index ["mso_id"], name: "index_inventories_on_mso_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string "name"
    t.bigint "mso_id", null: false
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mso_id"], name: "index_inventory_types_on_mso_id"
  end

  create_table "job_route_notes", force: :cascade do |t|
    t.bigint "job_route_id", null: false
    t.bigint "user_id", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_route_id"], name: "index_job_route_notes_on_job_route_id"
    t.index ["user_id"], name: "index_job_route_notes_on_user_id"
  end

  create_table "job_routes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "tech_id"
    t.string "account_number"
    t.integer "job_type"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "home_phone"
    t.string "other_phonne"
    t.datetime "job_date"
    t.string "job_number"
    t.integer "status"
    t.string "time_frame"
    t.datetime "time_started"
    t.datetime "time_completed"
    t.boolean "hhc_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.integer "company_id"
    t.index ["area_id"], name: "index_job_routes_on_area_id"
    t.index ["company_id"], name: "index_job_routes_on_company_id"
    t.index ["user_id"], name: "index_job_routes_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "msos", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbreviation"
  end

  create_table "technicians", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "tech_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_technicians_on_company_id"
    t.index ["user_id"], name: "index_technicians_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.integer "status", default: 0, null: false
    t.integer "role", default: 0, null: false
    t.string "phone_number"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.integer "state_id", default: 0, null: false
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["state_id"], name: "index_users_on_state_id"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "areas", "states"
  add_foreign_key "companies", "msos"
  add_foreign_key "inventories", "inventory_types"
  add_foreign_key "inventories", "job_routes"
  add_foreign_key "inventories", "users"
  add_foreign_key "inventory_types", "msos"
  add_foreign_key "job_route_notes", "job_routes"
  add_foreign_key "job_route_notes", "users"
  add_foreign_key "job_routes", "users"
  add_foreign_key "technicians", "companies"
  add_foreign_key "technicians", "users"
end
