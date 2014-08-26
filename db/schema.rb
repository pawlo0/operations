# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140826083507) do

  create_table "equipment", force: true do |t|
    t.integer  "num_id"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "serial"
    t.string   "location"
    t.string   "function"
    t.date     "manuf_date"
    t.date     "buy_date"
    t.text     "obs"
    t.string   "maintenance_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plant_id"
  end

  add_index "equipment", ["plant_id"], name: "index_equipment_on_plant_id"

  create_table "intervention_types", force: true do |t|
    t.string   "name"
    t.string   "obs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventions", force: true do |t|
    t.date     "day"
    t.integer  "equipment_id"
    t.integer  "eq_hours"
    t.text     "description"
    t.text     "changed_parts"
    t.string   "maintainer"
    t.string   "task_num"
    t.string   "estimate_num"
    t.string   "purchase_num"
    t.decimal  "parts_cost"
    t.decimal  "labor_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "intervention_type_id"
  end

  add_index "interventions", ["equipment_id"], name: "index_interventions_on_equipment_id"
  add_index "interventions", ["intervention_type_id"], name: "index_interventions_on_intervention_type_id"

  create_table "maintasks", force: true do |t|
    t.integer  "equipment_id"
    t.string   "task"
    t.integer  "period"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parts"
    t.string   "obs"
  end

  add_index "maintasks", ["equipment_id"], name: "index_maintasks_on_equipment_id"

  create_table "plants", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "name"
    t.integer  "plant_id"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["plant_id"], name: "index_users_on_plant_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
