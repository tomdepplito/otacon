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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130130054204) do

  create_table "attachments", :force => true do |t|
    t.integer  "conversation_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "admin_id"
    t.boolean  "vendor",     :default => false
  end

  create_table "conversations", :force => true do |t|
    t.text     "body",                    :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "parent_id"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "match_percentage"
    t.integer  "sender_id",               :null => false
    t.integer  "receiver_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment"
    t.string   "subject"
  end

  create_table "employees", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "office_id"
    t.string   "title"
    t.integer  "company_id"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "offices", :force => true do |t|
    t.string   "phone_num"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "company_id",     :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_address"
  end

  create_table "specialty_lists", :force => true do |t|
    t.boolean  "accumulators", :default => false
    t.boolean  "actuators",    :default => false
    t.boolean  "fittings",     :default => false
    t.boolean  "pumps",        :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "enclosures",   :default => false
    t.integer  "owner_id"
    t.text     "electronics"
    t.text     "mechanical"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "company_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "email"
    t.string   "stripe_card_token"
    t.string   "plan"
    t.boolean  "active",                :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
