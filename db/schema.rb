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

ActiveRecord::Schema.define(version: 20161005193820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "urls"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "ips", force: :cascade do |t|
    t.string  "a"
    t.integer "d", default: 0
    t.integer "p", default: 0
  end

  add_index "ips", ["a"], name: "index_ips_on_a", using: :btree
  add_index "ips", ["p"], name: "index_ips_on_p", using: :btree

  create_table "onlineforms", force: :cascade do |t|
    t.text    "title",    default: ""
    t.text    "body",     default: ""
    t.integer "disclose", default: 0
    t.integer "whatkind", default: 0
    t.integer "user_id"
  end

  add_index "onlineforms", ["user_id"], name: "index_onlineforms_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "count",   default: 0
    t.integer "count_w", default: 0
  end

  add_index "preferences", ["count"], name: "index_preferences_on_count", using: :btree
  add_index "preferences", ["count_w"], name: "index_preferences_on_count_w", using: :btree

  create_table "userips", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ip_id"
  end

  add_index "userips", ["ip_id"], name: "index_userips_on_ip_id", using: :btree
  add_index "userips", ["user_id"], name: "index_userips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "user_name",               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",         default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "stripe_1",                default: 0
    t.integer  "badge_1",                 default: 0
    t.integer  "badge_2",                 default: 0
    t.integer  "price",                   default: 0
    t.integer  "paid",                    default: 0
    t.string   "urls"
    t.integer  "array_b",                 default: [],              array: true
    t.string   "cus_id"
    t.string   "image_u_id"
    t.integer  "image_u_size"
    t.string   "slug"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.string   "auth_token"
    t.integer  "tor",                     default: 1
    t.integer  "blacklist",               default: 1
    t.integer  "custom",                  default: 1
    t.integer  "history",                 default: [],              array: true
    t.integer  "full_history",            default: [],              array: true
    t.string   "image_user_file_name"
    t.string   "image_user_content_type"
    t.integer  "image_user_file_size"
    t.datetime "image_user_updated_at"
    t.string   "cover_u_file_name"
    t.string   "cover_u_content_type"
    t.integer  "cover_u_file_size"
    t.datetime "cover_u_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "onlineforms", "users"
  add_foreign_key "userips", "ips"
  add_foreign_key "userips", "users"
end
