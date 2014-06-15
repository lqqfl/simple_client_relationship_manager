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

ActiveRecord::Schema.define(version: 20140615105356) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "time"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: true do |t|
    t.string   "name"
    t.decimal  "exp_amount",  precision: 10, scale: 2, default: 0.0
    t.text     "note"
    t.date     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_time"
    t.decimal  "real_amount", precision: 10, scale: 2, default: 0.0
  end

  create_table "opportunities", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "company_id",     default: 0
    t.integer  "contact_id",     default: 0
    t.integer  "user_id",        default: 0
    t.integer  "opportunity_id", default: 0
    t.integer  "activity_id",    default: 0
    t.integer  "contract_id",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["activity_id"], name: "index_relationships_on_activity_id"
  add_index "relationships", ["company_id"], name: "index_relationships_on_company_id"
  add_index "relationships", ["contact_id"], name: "index_relationships_on_contact_id"
  add_index "relationships", ["contract_id"], name: "index_relationships_on_contract_id"
  add_index "relationships", ["opportunity_id"], name: "index_relationships_on_opportunity_id"
  add_index "relationships", ["user_id"], name: "index_relationships_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
