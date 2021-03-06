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

ActiveRecord::Schema.define(version: 20150505191004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: :cascade do |t|
    t.datetime "date"
    t.string   "casenumber"
    t.text     "description"
    t.integer  "tribunal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cases", ["tribunal_id"], name: "index_cases_on_tribunal_id", using: :btree

  create_table "incidents", force: :cascade do |t|
    t.text     "description"
    t.integer  "state_id"
    t.boolean  "public"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "incidents", ["state_id"], name: "index_incidents_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.boolean  "online",           default: true
    t.datetime "last_time_online"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "tribunals", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tribunals", ["state_id"], name: "index_tribunals_on_state_id", using: :btree

  add_foreign_key "cases", "tribunals"
  add_foreign_key "incidents", "states"
  add_foreign_key "tribunals", "states"
end
