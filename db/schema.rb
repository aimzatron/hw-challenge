# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20201008052917) do

  create_table "addresses", force: :cascade do |t|
    t.string "address1", null: false
    t.string "address2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carriers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "address_id", null: false
    t.bigint "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_carriers_on_address_id"
    t.index ["external_id"], name: "index_carriers_on_external_id"
    t.index ["name"], name: "index_carriers_on_name"
  end

  create_table "client_divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_client_divisions_on_name"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.integer "address_id", null: false
    t.bigint "major_group", null: false
    t.bigint "industry_group", null: false
    t.bigint "sic", null: false
    t.text "description", null: false
    t.integer "client_division_id", null: false
    t.bigint "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_clients_on_address_id"
    t.index ["client_division_id"], name: "index_clients_on_client_division_id"
    t.index ["external_id"], name: "index_clients_on_external_id"
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "policies", force: :cascade do |t|
    t.integer "client_id"
    t.integer "carrier_id"
    t.datetime "effective_date", null: false
    t.datetime "expiration_date", null: false
    t.float "written_premium", null: false
    t.bigint "carrier_policy_number", null: false
    t.bigint "external_id"
    t.integer "policy_division_id", null: false
    t.integer "policy_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_policies_on_carrier_id"
    t.index ["client_id"], name: "index_policies_on_client_id"
    t.index ["external_id"], name: "index_policies_on_external_id"
    t.index ["policy_division_id"], name: "index_policies_on_policy_division_id"
    t.index ["policy_type_id"], name: "index_policies_on_policy_type_id"
  end

  create_table "policy_divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_policy_divisions_on_name"
  end

  create_table "policy_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_policy_types_on_name"
  end

end
