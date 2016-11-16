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

ActiveRecord::Schema.define(version: 20161116113327) do

  create_table "ads", force: :cascade do |t|
    t.date     "date",       null: false
    t.integer  "price",      null: false
    t.integer  "year",       null: false
    t.string   "make",       null: false
    t.string   "model",      null: false
    t.integer  "site_id",    null: false
    t.string   "link",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "region_id",  null: false
  end

  add_index "ads", ["region_id"], name: "index_ads_on_region_id"
  add_index "ads", ["site_id"], name: "index_ads_on_site_id", unique: true

  create_table "makes", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "synonym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "models", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "synonym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "make_id"
  end

  add_index "models", ["make_id"], name: "index_models_on_make_id"

  create_table "regions", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "max_price",  null: false
    t.integer  "min_year",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "model_id",   null: false
    t.integer  "user_id",    null: false
  end

  add_index "subscriptions", ["model_id"], name: "index_subscriptions_on_model_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "towns", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "region_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                               null: false
    t.string   "t_username",                             null: false
    t.string   "encrypted_password",                     null: false
    t.boolean  "verified",               default: false, null: false
    t.integer  "chat_id",                default: 0,     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "region_id",                              null: false
  end

  add_index "users", ["region_id"], name: "index_users_on_region_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["t_username"], name: "index_users_on_t_username", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
