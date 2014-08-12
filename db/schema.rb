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

ActiveRecord::Schema.define(version: 20140812163214) do

  create_table "equipment", force: true do |t|
    t.integer  "num_id"
    t.string   "name"
    t.string   "manufacturer"
    t.string   "model"
    t.string   "serial"
    t.string   "assigned_to"
    t.string   "location"
    t.string   "function"
    t.date     "manuf_date"
    t.date     "buy_date"
    t.text     "obs"
    t.integer  "maintenance_period"
    t.string   "maintenance_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interventions", force: true do |t|
    t.date     "day"
    t.integer  "equipment_id"
    t.integer  "eq_hours"
    t.boolean  "repair"
    t.boolean  "preventive"
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
  end

  add_index "interventions", ["equipment_id"], name: "index_interventions_on_equipment_id"

  create_table "maintasks", force: true do |t|
    t.integer  "equipment_id"
    t.string   "task"
    t.integer  "period"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maintasks", ["equipment_id"], name: "index_maintasks_on_equipment_id"

end
