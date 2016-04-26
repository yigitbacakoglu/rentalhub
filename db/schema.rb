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

ActiveRecord::Schema.define(version: 20160426174006) do

  create_table "assets", force: :cascade do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "type"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "leases", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.date     "from_date"
    t.date     "to_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "price"
  end

  add_index "leases", ["property_id"], name: "index_leases_on_property_id"
  add_index "leases", ["user_id"], name: "index_leases_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.text     "description"
    t.string   "business_name"
    t.string   "abn"
    t.text     "service_provided"
    t.string   "postcode"
    t.text     "reason"
    t.boolean  "terms"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "business_postcode"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "properties", force: :cascade do |t|
    t.string   "city"
    t.string   "country"
    t.string   "street1"
    t.string   "street2"
    t.float    "lat"
    t.float    "long"
    t.string   "zipcode"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "listing_type"
    t.boolean  "connection",         default: false
    t.datetime "deleted_at"
    t.string   "owner_email"
    t.string   "owner_phone"
    t.string   "owner_name"
    t.string   "verification_token"
  end

  add_index "properties", ["user_id"], name: "index_properties_on_user_id"

  create_table "user_properties", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_properties", ["property_id"], name: "index_user_properties_on_property_id"
  add_index "user_properties", ["user_id"], name: "index_user_properties_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
    t.string   "firstname"
    t.string   "lastname"
    t.text     "description"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wish_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "wish_lists", ["property_id"], name: "index_wish_lists_on_property_id"
  add_index "wish_lists", ["user_id"], name: "index_wish_lists_on_user_id"

end
