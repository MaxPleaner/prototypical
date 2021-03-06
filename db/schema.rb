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

ActiveRecord::Schema.define(version: 20160404084432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "from_user_id"
    t.text     "content"
    t.boolean  "viewed",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "payment_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "from_user_id"
    t.integer  "length"
    t.boolean  "accepted",     default: false
    t.boolean  "paid",         default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "payment_request_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "payments", ["payment_request_id"], name: "index_payments_on_payment_request_id", using: :btree

  create_table "tickers", force: :cascade do |t|
    t.string   "process_name"
    t.string   "name"
    t.text     "content"
    t.integer  "interval"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "password"
    t.text     "session_token"
    t.integer  "five_minute_cost"
    t.integer  "fifteen_minute_cost"
    t.integer  "thirty_minute_cost"
    t.integer  "sixty_minute_cost"
    t.string   "skills"
    t.integer  "last_ping_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_foreign_key "payments", "payment_requests"
end
