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

ActiveRecord::Schema.define(version: 20171017002548) do

  create_table "agent_searches", force: :cascade do |t|
    t.string "txn_side", null: false
    t.string "prop_type", null: false
    t.string "price_range", null: false
    t.string "agent_ids", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agent_stats", force: :cascade do |t|
    t.integer "agent_id", null: false
    t.integer "total", default: 0, null: false
    t.integer "buyers", default: 0, null: false
    t.integer "sellers", default: 0, null: false
    t.integer "sfh", default: 0, null: false
    t.integer "condo", default: 0, null: false
    t.integer "townhome", default: 0, null: false
    t.integer "mobile", default: 0, null: false
    t.integer "land", default: 0, null: false
    t.integer "0_to_150k", default: 0, null: false
    t.integer "150k_to_300k", default: 0, null: false
    t.integer "300k_to_500k", default: 0, null: false
    t.integer "500k_to_750k", default: 0, null: false
    t.integer "750k_to_1m", default: 0, null: false
    t.integer "1m_plus", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_agent_stats_on_agent_id"
  end

  create_table "agents", force: :cascade do |t|
    t.string "name", null: false
    t.string "brokerage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
