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

ActiveRecord::Schema.define(:version => 20120803051849) do

  create_table "authority_menus", :force => true do |t|
    t.integer  "m_authority_id", :limit => 2, :null => false
    t.integer  "menu_id",        :limit => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_comments", :force => true do |t|
    t.datetime "send_day",                      :null => false
    t.integer  "menu_id",                       :null => false
    t.string   "contents",        :limit => 40, :null => false
    t.integer  "send_id",                       :null => false
    t.integer  "receive_id",                    :null => false
    t.integer  "created_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_events", :force => true do |t|
    t.string   "start_day",       :limit => 8,  :null => false
    t.string   "end_day",         :limit => 8,  :null => false
    t.string   "action_day",      :limit => 8,  :null => false
    t.integer  "menu_id"
    t.string   "contents",        :limit => 40, :null => false
    t.integer  "receive_group1",                :null => false
    t.integer  "receive_group2"
    t.integer  "created_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_messages", :force => true do |t|
    t.datetime "send_day",                      :null => false
    t.integer  "menu_id",                       :null => false
    t.string   "contents",        :limit => 40, :null => false
    t.integer  "receive_id1"
    t.integer  "receive_id2"
    t.integer  "receive_id3"
    t.integer  "receive_id4"
    t.integer  "receive_id5"
    t.integer  "receive_group1"
    t.integer  "receive_group2"
    t.integer  "created_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_collects", :force => true do |t|
    t.integer  "d_result_id",    :null => false
    t.integer  "m_collect_id",   :null => false
    t.integer  "get_num",        :null => false
    t.integer  "create_user_id", :null => false
    t.integer  "update_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_etcs", :force => true do |t|
    t.integer  "d_result_id",    :null => false
    t.integer  "m_etc_id",       :null => false
    t.integer  "pos1_data"
    t.integer  "pos2_data"
    t.integer  "pos3_data"
    t.integer  "create_user_id", :null => false
    t.integer  "update_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_meters", :force => true do |t|
    t.integer  "d_result_id",    :null => false
    t.integer  "m_oil_id",       :null => false
    t.integer  "m_tank_id",      :null => false
    t.integer  "pos1_meter1"
    t.integer  "pos1_meter2"
    t.integer  "pos1_meter3"
    t.integer  "pos1_meter4"
    t.integer  "pos1_meter5"
    t.integer  "pos1_meter6"
    t.integer  "pos1_meter7"
    t.integer  "pos1_meter8"
    t.integer  "pos1_meter9"
    t.integer  "pos1_meter10"
    t.integer  "pos1_meter11"
    t.integer  "pos1_meter12"
    t.integer  "pos2_meter1"
    t.integer  "pos2_meter2"
    t.integer  "pos2_meter3"
    t.integer  "pos2_meter4"
    t.integer  "pos2_meter5"
    t.integer  "pos2_meter6"
    t.integer  "pos2_meter7"
    t.integer  "pos2_meter8"
    t.integer  "pos2_meter9"
    t.integer  "pos2_meter10"
    t.integer  "pos2_meter11"
    t.integer  "pos2_meter12"
    t.integer  "pos3_meter1"
    t.integer  "pos3_meter2"
    t.integer  "pos3_meter3"
    t.integer  "pos3_meter4"
    t.integer  "pos3_meter5"
    t.integer  "pos3_meter6"
    t.integer  "pos3_meter7"
    t.integer  "pos3_meter8"
    t.integer  "pos3_meter9"
    t.integer  "pos3_meter10"
    t.integer  "pos3_meter11"
    t.integer  "pos3_meter12"
    t.integer  "arrive_data"
    t.integer  "stock_data"
    t.integer  "create_user_id", :null => false
    t.integer  "update_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_oiletcs", :force => true do |t|
    t.integer  "d_result_id",    :null => false
    t.integer  "m_oiletc_id",    :null => false
    t.integer  "pos1_data"
    t.integer  "pos2_data"
    t.integer  "pos3_data"
    t.integer  "create_user_id", :null => false
    t.integer  "update_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_oils", :force => true do |t|
    t.integer  "d_result_id",    :null => false
    t.integer  "m_oil_id",       :null => false
    t.integer  "pos1_data"
    t.integer  "pos2_data"
    t.integer  "pos3_data"
    t.integer  "create_user_id", :null => false
    t.integer  "update_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_results", :force => true do |t|
    t.string   "result_date",    :limit => 8, :null => false
    t.integer  "m_shop_id",                   :null => false
    t.integer  "kakutei_flg",    :limit => 2, :null => false
    t.integer  "create_user_id",              :null => false
    t.integer  "update_user_id",              :null => false
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

  create_table "m_codes", :force => true do |t|
    t.string   "kbn"
    t.string   "code"
    t.string   "code_name"
    t.string   "code_name1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_etcs", :force => true do |t|
    t.integer  "etc_cd"
    t.string   "etc_name"
    t.string   "etc_ryaku"
    t.string   "etc_tani"
    t.integer  "etc_group"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_etcsales", :force => true do |t|
    t.integer  "etc_cd"
    t.string   "etc_name"
    t.string   "etc_ryaku"
    t.string   "etc_tani"
    t.integer  "etc_group"
    t.integer  "max_num"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_info_costs", :force => true do |t|
    t.integer  "users_id"
    t.integer  "base_pay"
    t.integer  "night_pay"
    t.integer  "welfare_pay"
    t.integer  "etc_pay1"
    t.integer  "etc_pay2"
    t.integer  "etc_pay3"
    t.integer  "etc_pay4"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_oiletcs", :force => true do |t|
    t.integer  "oiletc_cd"
    t.string   "oiletc_name"
    t.string   "oiletc_ryaku"
    t.string   "oiletc_tani"
    t.integer  "oiletc_group"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_oils", :force => true do |t|
    t.integer  "oil_cd"
    t.string   "oil_name"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_shops", :force => true do |t|
    t.integer  "shop_cd"
    t.string   "shop_name"
    t.string   "shop_kana"
    t.string   "shop_ryaku"
    t.string   "shop_zip_cd"
    t.string   "shop_adress"
    t.string   "shop_tel"
    t.string   "shop_fax"
    t.string   "shop_mail_adress"
    t.integer  "shop_kbn"
    t.integer  "m_shop_group_id"
    t.integer  "m_oil_id1"
    t.integer  "tank1_all"
    t.integer  "m_oil_id2"
    t.integer  "tank2_all"
    t.integer  "m_oil_id3"
    t.integer  "tank3_all"
    t.integer  "m_oil_id4"
    t.integer  "tank4_all"
    t.integer  "etc_oil_flg"
    t.integer  "etc_flg"
    t.integer  "wash_flg"
    t.integer  "wash_sale_flg"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_tanks", :force => true do |t|
    t.integer  "m_shop_id"
    t.integer  "m_oil_id"
    t.integer  "tank_all"
    t.integer  "measure1"
    t.integer  "measure2"
    t.integer  "measure3"
    t.integer  "measure4"
    t.integer  "measure5"
    t.integer  "measure6"
    t.integer  "measure7"
    t.integer  "measure8"
    t.integer  "measure9"
    t.integer  "measure10"
    t.integer  "measure11"
    t.integer  "measure12"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_washes", :force => true do |t|
    t.integer  "wash_cd"
    t.string   "wash_name"
    t.string   "wash_ryaku"
    t.integer  "wash_group"
    t.integer  "max_num"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_washsale_plans", :force => true do |t|
    t.integer  "m_shop_id"
    t.integer  "m_wash_id"
    t.integer  "sunday"
    t.integer  "monday"
    t.integer  "tuesday"
    t.integer  "wednesday"
    t.integer  "thursday"
    t.integer  "friday"
    t.integer  "saturday"
    t.integer  "created_user_id"
    t.integer  "updated_user_id"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", :force => true do |t|
    t.integer  "menu_cd1",     :limit => 2,   :null => false
    t.integer  "menu_cd2",     :limit => 2,   :null => false
    t.string   "display_name", :limit => 100
    t.string   "uri",          :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "messege_send", :limit => 2
    t.integer  "menu_cd3",     :limit => 2
  end

  create_table "userdata", :force => true do |t|
    t.string   "pseudo"
    t.string   "email"
    t.string   "firstname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "account",                :limit => 10
    t.string   "user_name",              :limit => 50
    t.string   "user_name_kana",         :limit => 50
    t.integer  "m_shops_id"
    t.integer  "m_authority_id"
    t.integer  "user_class",             :limit => 2
    t.datetime "nyusya_date"
    t.datetime "birthday"
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
