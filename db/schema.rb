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

ActiveRecord::Schema.define(version: 20150307062042) do

  create_table "auth_tokens", force: true do |t|
    t.string   "auth_token_id",      limit: 36, null: false
    t.string   "user_id",            limit: 36, null: false
    t.datetime "auth_token_expires",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "user_id",       limit: 36,  null: false
    t.string   "email_id",      limit: 36,  null: false
    t.string   "email_address", limit: 256, null: false
    t.string   "reset_key",     limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invite_requests", force: true do |t|
    t.string   "invite_request_id",            limit: 36,                  null: false
    t.string   "invite_request_email_address", limit: 128,                 null: false
    t.boolean  "invite_request_granted",                   default: false
    t.boolean  "invite_request_consumed",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labs", force: true do |t|
    t.string   "user_id",         limit: 36,   null: false
    t.string   "lab_id",          limit: 36,   null: false
    t.string   "lab_title",       limit: 96,   null: false
    t.string   "lab_description", limit: 1048, null: false
    t.string   "lab_video_url",   limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passwords", force: true do |t|
    t.string   "user_id",         limit: 36,  null: false
    t.string   "password_id",     limit: 36,  null: false
    t.string   "password_digest", limit: 256, null: false
    t.string   "reset_key",       limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_id",                 limit: 36,                 null: false
    t.string   "user_username",           limit: 64,                 null: false
    t.string   "user_firstname",          limit: 64
    t.string   "user_lastname",           limit: 64
    t.string   "user_middlename",         limit: 64
    t.datetime "user_dateofbirth"
    t.boolean  "user_verified",                      default: false
    t.string   "verification_key",        limit: 36
    t.datetime "verification_expiration"
    t.string   "user_account_type",       limit: 32,                 null: false
    t.boolean  "currently_logged_in",                default: false
    t.datetime "last_logged_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
