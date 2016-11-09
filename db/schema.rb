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

ActiveRecord::Schema.define(version: 20161108222740) do

  create_table "ads", force: :cascade do |t|
    t.date     "date"
    t.integer  "price"
    t.integer  "year"
    t.boolean  "broken"
    t.string   "make"
    t.string   "model"
    t.string   "region"
    t.integer  "site_id"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "synonym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "max_price"
    t.integer  "min_year"
    t.boolean  "broken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "type_id"
    t.integer  "user_id"
  end

  add_index "subscriptions", ["type_id"], name: "index_subscriptions_on_type_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "towns", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name"
    t.string   "synonym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "brand_id"
  end

  add_index "types", ["brand_id"], name: "index_types_on_brand_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",                           null: false
    t.string   "t_username",                         null: false
    t.string   "encrypted_password",                 null: false
    t.boolean  "verified"
    t.integer  "chat_id",                default: 0, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "region_id"
  end

  add_index "users", ["region_id"], name: "index_users_on_region_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["t_username"], name: "index_users_on_t_username", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
