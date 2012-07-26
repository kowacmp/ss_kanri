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

ActiveRecord::Schema.define(:version => 20120717073243) do

  create_table "authority_menus", :force => true do |t|
    t.integer  "m_authority_id", :limit => 2, :null => false
    t.integer  "menu_id",        :limit => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_authorities", :force => true do |t|
    t.integer  "authority_cd",   :limit => 2,   :default => 0, :null => false
    t.string   "authority_name", :limit => 100,                :null => false
    t.integer  "deleted_flg",    :limit => 2,   :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.integer  "parent_menu_id", :limit => 2,   :null => false
    t.integer  "display_order",  :limit => 2,   :null => false
    t.string   "display_name",   :limit => 100
    t.string   "uri",            :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "account",                :limit => 10
    t.string   "user_name",              :limit => 50
    t.string   "user_name_kana",         :limit => 50
    t.integer  "m_shops_id"
    t.integer  "user_class",             :limit => 2
    t.datetime "nyusya_date"
    t.integer  "deleted_flg",            :limit => 2,  :default => 0,  :null => false
    t.datetime "deleted_at"
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
