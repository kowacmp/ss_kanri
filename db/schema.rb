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

ActiveRecord::Schema.define(:version => 20120911115517) do

  create_table "authority_menus", :force => true do |t|
    t.integer  "m_authority_id", :limit => 2, :null => false
    t.integer  "menu_id",        :limit => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_aims", :force => true do |t|
    t.string   "date",            :limit => 6, :null => false
    t.integer  "m_shop_id",                    :null => false
    t.integer  "m_aim_id",                     :null => false
    t.integer  "aim_total"
    t.integer  "aim_value1"
    t.integer  "aim_value2"
    t.integer  "aim_value3"
    t.integer  "aim_value4"
    t.integer  "aim_value5"
    t.integer  "aim_value6"
    t.integer  "aim_value7"
    t.integer  "aim_value8"
    t.integer  "aim_value9"
    t.integer  "aim_value10"
    t.integer  "aim_value11"
    t.integer  "aim_value12"
    t.integer  "aim_value13"
    t.integer  "aim_value14"
    t.integer  "aim_value15"
    t.integer  "aim_value16"
    t.integer  "aim_value17"
    t.integer  "aim_value18"
    t.integer  "aim_value19"
    t.integer  "aim_value20"
    t.integer  "aim_value21"
    t.integer  "aim_value22"
    t.integer  "aim_value23"
    t.integer  "aim_value24"
    t.integer  "aim_value25"
    t.integer  "aim_value26"
    t.integer  "aim_value27"
    t.integer  "aim_value28"
    t.integer  "aim_value29"
    t.integer  "aim_value30"
    t.integer  "aim_value31"
    t.integer  "created_user_id"
    t.integer  "updated_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_audit_changemachines", :force => true do |t|
    t.string   "audit_date",            :limit => 8,   :null => false
    t.integer  "audit_class",                          :null => false
    t.integer  "m_shop_id",                            :null => false
    t.integer  "kakutei_flg",                          :null => false
    t.integer  "pos1_before_money1"
    t.integer  "pos1_before_money2"
    t.integer  "pos1_before_money3"
    t.integer  "pos1_before_money4"
    t.integer  "pos1_before_money5"
    t.integer  "pos1_before_money6"
    t.integer  "pos1_before_money7"
    t.integer  "pos1_after_money1"
    t.integer  "pos1_after_money2"
    t.integer  "pos1_after_money3"
    t.integer  "pos1_after_money4"
    t.integer  "pos1_after_money5"
    t.integer  "pos1_after_money6"
    t.integer  "pos1_after_money7"
    t.integer  "pos1_supplement_money"
    t.integer  "pos1_collectt_money"
    t.integer  "pos2_before_money1"
    t.integer  "pos2_before_money2"
    t.integer  "pos2_before_money3"
    t.integer  "pos2_before_money4"
    t.integer  "pos2_before_money5"
    t.integer  "pos2_before_money6"
    t.integer  "pos2_before_money7"
    t.integer  "pos2_after_money1"
    t.integer  "pos2_after_money2"
    t.integer  "pos2_after_money3"
    t.integer  "pos2_after_money4"
    t.integer  "pos2_after_money5"
    t.integer  "pos2_after_money6"
    t.integer  "pos2_after_money7"
    t.integer  "pos2_supplement_money"
    t.integer  "pos2_collectt_money"
    t.integer  "pos3_before_money1"
    t.integer  "pos3_before_money2"
    t.integer  "pos3_before_money3"
    t.integer  "pos3_before_money4"
    t.integer  "pos3_before_money5"
    t.integer  "pos3_before_money6"
    t.integer  "pos3_before_money7"
    t.integer  "pos3_after_money1"
    t.integer  "pos3_after_money2"
    t.integer  "pos3_after_money3"
    t.integer  "pos3_after_money4"
    t.integer  "pos3_after_money5"
    t.integer  "pos3_after_money6"
    t.integer  "pos3_after_money7"
    t.integer  "pos3_supplement_money"
    t.integer  "pos3_collectt_money"
    t.integer  "before_cashbox"
    t.integer  "before_changemachine"
    t.integer  "ass"
    t.integer  "sale_pos1"
    t.integer  "sale_pos2"
    t.integer  "sale_pos3"
    t.integer  "sale_waiwai"
    t.integer  "sale_receive"
    t.integer  "sale_pay"
    t.integer  "cashbox_money"
    t.integer  "changemachine_pos1"
    t.integer  "changemachine_pos2"
    t.integer  "changemachine_pos3"
    t.integer  "changemachine_after"
    t.integer  "receive_money"
    t.integer  "confirm_shop_id",                      :null => false
    t.integer  "confirm_user_id",                      :null => false
    t.string   "comment",               :limit => 300
    t.integer  "kakunin_flg",                          :null => false
    t.integer  "kakunin_user_id"
    t.datetime "kakunin_date"
    t.integer  "approve_id1"
    t.datetime "approve_date1"
    t.integer  "approve_id2"
    t.datetime "approve_date2"
    t.integer  "approve_id3"
    t.datetime "approve_date3"
    t.integer  "approve_id4"
    t.datetime "approve_date4"
    t.integer  "approve_id5"
    t.datetime "approve_date5"
    t.integer  "created_user_id",                      :null => false
    t.datetime "created_at",                           :null => false
    t.integer  "updated_user_id",                      :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "d_audit_checks", :force => true do |t|
    t.integer  "m_shop_id",                       :null => false
    t.string   "audit_date",       :limit => 8,   :null => false
    t.integer  "m_audit_check_id",                :null => false
    t.integer  "check_flg"
    t.string   "comment",          :limit => 100
    t.integer  "created_user_id",                 :null => false
    t.datetime "created_at",                      :null => false
    t.integer  "updated_user_id",                 :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "d_audit_etc_details", :force => true do |t|
    t.integer  "d_audit_etc_id",  :null => false
    t.integer  "m_etc_id",        :null => false
    t.integer  "etc_no",          :null => false
    t.integer  "meter"
    t.integer  "error_money"
    t.integer  "created_user_id", :null => false
    t.datetime "created_at",      :null => false
    t.integer  "updated_user_id", :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "d_audit_etcs", :force => true do |t|
    t.string   "audit_date_from", :limit => 8,   :null => false
    t.string   "audit_date_to",   :limit => 8,   :null => false
    t.integer  "audit_class",                    :null => false
    t.integer  "m_shop_id",                      :null => false
    t.integer  "kakutei_flg",                    :null => false
    t.integer  "kakunin_flg",                    :null => false
    t.integer  "kakunin_user_id"
    t.datetime "kakunin_date"
    t.integer  "approve_id1"
    t.datetime "approve_date1"
    t.integer  "approve_id2"
    t.datetime "approve_date2"
    t.integer  "approve_id3"
    t.datetime "approve_date3"
    t.integer  "approve_id4"
    t.datetime "approve_date4"
    t.integer  "approve_id5"
    t.datetime "approve_date5"
    t.integer  "confirm_shop_id",                :null => false
    t.integer  "confirm_user_id",                :null => false
    t.string   "comment",         :limit => 300
    t.integer  "created_user_id",                :null => false
    t.datetime "created_at",                     :null => false
    t.integer  "updated_user_id",                :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "d_audit_wash_details", :force => true do |t|
    t.integer  "d_audit_wash_id",                :null => false
    t.integer  "m_wash_id",                      :null => false
    t.integer  "wash_no",                        :null => false
    t.integer  "meter"
    t.integer  "error_money"
    t.integer  "created_user_id",                :null => false
    t.datetime "created_at",                     :null => false
    t.integer  "updated_user_id",                :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "uriage",          :default => 0
  end

  create_table "d_audit_washes", :force => true do |t|
    t.string   "audit_date_from", :limit => 8,   :null => false
    t.string   "audit_date_to",   :limit => 8,   :null => false
    t.integer  "audit_class",                    :null => false
    t.integer  "m_shop_id",                      :null => false
    t.integer  "kakutei_flg",                    :null => false
    t.integer  "kakunin_flg",                    :null => false
    t.integer  "kakunin_user_id"
    t.datetime "kakunin_date"
    t.integer  "approve_id1"
    t.datetime "approve_date1"
    t.integer  "approve_id2"
    t.datetime "approve_date2"
    t.integer  "approve_id3"
    t.datetime "approve_date3"
    t.integer  "approve_id4"
    t.datetime "approve_date4"
    t.integer  "approve_id5"
    t.datetime "approve_date5"
    t.integer  "confirm_shop_id",                :null => false
    t.integer  "confirm_user_id",                :null => false
    t.string   "comment",         :limit => 300
    t.integer  "created_user_id",                :null => false
    t.datetime "created_at",                     :null => false
    t.integer  "updated_user_id",                :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "d_comments", :force => true do |t|
    t.datetime "send_day",                      :null => false
    t.string   "title",           :limit => 20, :null => false
    t.string   "contents",        :limit => 40, :null => false
    t.integer  "receive_id",                    :null => false
    t.integer  "created_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_events", :force => true do |t|
    t.string   "start_day",       :limit => 8,  :null => false
    t.string   "end_day",         :limit => 8,  :null => false
    t.string   "action_day",      :limit => 8,  :null => false
    t.string   "title",           :limit => 20
    t.string   "contents",        :limit => 40, :null => false
    t.integer  "created_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_fixtures", :force => true do |t|
    t.string   "application_date", :limit => 8,                  :null => false
    t.integer  "m_shop_id",                       :default => 0, :null => false
    t.string   "buy_shop",         :limit => 50,                 :null => false
    t.string   "buy_item",         :limit => 100,                :null => false
    t.integer  "buy_num",                         :default => 0, :null => false
    t.integer  "buy_price",                       :default => 0, :null => false
    t.string   "buy_object",       :limit => 100
    t.integer  "now_num",                         :default => 0
    t.string   "buy_day",          :limit => 8
    t.string   "comment",          :limit => 100
    t.integer  "approve_flg",      :limit => 2,   :default => 0
    t.integer  "approve_id1",                     :default => 0
    t.string   "approve_date1",    :limit => 8
    t.integer  "created_user_id",                 :default => 0, :null => false
    t.integer  "updated_user_id",                 :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_collects", :force => true do |t|
    t.integer  "d_result_id",     :null => false
    t.integer  "m_oiletc_id",     :null => false
    t.integer  "get_num",         :null => false
    t.integer  "created_user_id", :null => false
    t.integer  "updated_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_etcs", :force => true do |t|
    t.integer  "d_result_id",                  :null => false
    t.integer  "m_etc_id",                     :null => false
    t.integer  "pos1_data"
    t.integer  "pos2_data"
    t.integer  "pos3_data"
    t.integer  "created_user_id",              :null => false
    t.integer  "updated_user_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "no",              :limit => 2
  end

  create_table "d_result_meters", :force => true do |t|
    t.integer  "d_result_id",     :null => false
    t.integer  "m_meter_id",      :null => false
    t.integer  "meter"
    t.integer  "created_user_id", :null => false
    t.integer  "updated_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_oiletcs", :force => true do |t|
    t.integer  "d_result_id",                                    :null => false
    t.integer  "m_oiletc_id",                                    :null => false
    t.decimal  "pos1_data",       :precision => 11, :scale => 2
    t.decimal  "pos2_data",       :precision => 11, :scale => 2
    t.decimal  "pos3_data",       :precision => 11, :scale => 2
    t.integer  "created_user_id",                                :null => false
    t.integer  "updated_user_id",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_oils", :force => true do |t|
    t.integer  "d_result_id",                                   :null => false
    t.integer  "m_oil_id",                                      :null => false
    t.decimal  "pos1_data",       :precision => 9, :scale => 2
    t.decimal  "pos2_data",       :precision => 9, :scale => 2
    t.decimal  "pos3_data",       :precision => 9, :scale => 2
    t.integer  "created_user_id",                               :null => false
    t.integer  "updated_user_id",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_reports", :force => true do |t|
    t.integer  "d_result_id",                                  :null => false
    t.decimal  "mo_gas",        :precision => 10, :scale => 1
    t.decimal  "keiyu",         :precision => 10, :scale => 1
    t.decimal  "touyu",         :precision => 10, :scale => 1
    t.decimal  "koua",          :precision => 11, :scale => 2
    t.integer  "buyou"
    t.integer  "tokusei"
    t.integer  "sensya"
    t.integer  "koutin"
    t.integer  "taiya"
    t.decimal  "arari",         :precision => 10, :scale => 1
    t.integer  "chousei"
    t.integer  "syaken"
    t.integer  "kyuyu_purika"
    t.integer  "sensya_purika"
    t.integer  "sp"
    t.integer  "sc"
    t.integer  "taiyaw"
    t.integer  "sp_plus"
    t.decimal  "atf",           :precision => 11, :scale => 2
    t.integer  "kousen"
    t.integer  "bt"
    t.integer  "bankin"
    t.integer  "waiper"
    t.decimal  "mobil1",        :precision => 11, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "oiletc_pace"
    t.integer  "arari_total"
  end

  create_table "d_result_reserves", :force => true do |t|
    t.integer  "d_result_id",                   :null => false
    t.string   "get_date",        :limit => 8,  :null => false
    t.string   "reserve_name",    :limit => 50
    t.integer  "created_user_id",               :null => false
    t.integer  "updated_user_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_result_self_reports", :force => true do |t|
    t.integer  "d_result_id",                                       :null => false
    t.decimal  "mo_gas",             :precision => 10, :scale => 1
    t.decimal  "keiyu",              :precision => 10, :scale => 1
    t.decimal  "touyu",              :precision => 10, :scale => 1
    t.integer  "kyuyu_purika"
    t.integer  "sensya"
    t.integer  "sensya_purika"
    t.integer  "muton"
    t.integer  "sp_plus"
    t.integer  "taiyaw"
    t.integer  "sp"
    t.integer  "sc"
    t.integer  "wash_item"
    t.integer  "game"
    t.integer  "health"
    t.integer  "net"
    t.integer  "charge"
    t.integer  "spare"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sensya_purika_sale"
  end

  create_table "d_result_tanks", :force => true do |t|
    t.integer  "d_result_id",     :null => false
    t.integer  "m_tank_id",       :null => false
    t.integer  "receive"
    t.integer  "stock"
    t.integer  "created_user_id", :null => false
    t.integer  "updated_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_results", :force => true do |t|
    t.string   "result_date",     :limit => 8, :null => false
    t.integer  "m_shop_id",                    :null => false
    t.integer  "kakutei_flg",     :limit => 2, :null => false
    t.integer  "created_user_id",              :null => false
    t.integer  "updated_user_id",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_sale_etc_details", :force => true do |t|
    t.integer  "d_sale_etc_id",                                 :null => false
    t.integer  "m_etc_id",                                      :null => false
    t.integer  "etc_no",          :limit => 2,                  :null => false
    t.integer  "meter",                          :default => 0
    t.integer  "error_money",                    :default => 0
    t.string   "error_note",      :limit => 200
    t.integer  "created_user_id",                               :null => false
    t.integer  "updated_user_id",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uriage"
  end

  create_table "d_sale_etcs", :force => true do |t|
    t.string   "sale_date",       :limit => 8, :default => "00000000", :null => false
    t.integer  "m_shop_id",                    :default => 0,          :null => false
    t.integer  "kakutei_flg",     :limit => 2, :default => 0,          :null => false
    t.integer  "created_user_id",              :default => 0,          :null => false
    t.integer  "updated_user_id",              :default => 0,          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_sale_items", :force => true do |t|
    t.integer  "d_sale_id",                                    :null => false
    t.integer  "item_class",      :limit => 2,                 :null => false
    t.integer  "m_item_id"
    t.string   "item_name",       :limit => 30
    t.integer  "item_money",                    :default => 0
    t.integer  "m_shop_id"
    t.integer  "created_user_id"
    t.integer  "updated_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_sale_reports", :force => true do |t|
    t.string   "sale_date",     :limit => 6, :null => false
    t.integer  "m_shop_id",                  :null => false
    t.integer  "kakutei_flg",   :limit => 2, :null => false
    t.integer  "confirm_id"
    t.date     "confirm_date"
    t.integer  "approve_id1"
    t.date     "approve_date1"
    t.integer  "approve_id2"
    t.date     "approve_date2"
    t.integer  "approve_id3"
    t.date     "approve_date3"
    t.integer  "approve_id4"
    t.date     "approve_date4"
    t.integer  "approve_id5"
    t.date     "approve_date5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_sales", :force => true do |t|
    t.string   "sale_date",       :limit => 8,                :null => false
    t.integer  "m_shop_id",                                   :null => false
    t.integer  "kakutei_flg",     :limit => 2,                :null => false
    t.integer  "sale_money1",                  :default => 0
    t.integer  "sale_money2",                  :default => 0
    t.integer  "sale_money3",                  :default => 0
    t.integer  "sale_purika",                  :default => 0
    t.integer  "sale_today_out",               :default => 0
    t.integer  "sale_change1",                 :default => 0
    t.integer  "sale_change2",                 :default => 0
    t.integer  "sale_change3",                 :default => 0
    t.integer  "sale_ass",                     :default => 0
    t.integer  "recive_money",                 :default => 0
    t.integer  "pay_money",                    :default => 0
    t.integer  "sale_cashbox",                 :default => 0
    t.integer  "sale_changebox",               :default => 0
    t.integer  "created_user_id"
    t.integer  "updated_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sale_am_out",                  :default => 0
    t.integer  "sale_pm_out",                  :default => 0
    t.integer  "exist_money",                  :default => 0
    t.integer  "over_short",                   :default => 0
  end

  create_table "d_tank_compute_reports", :force => true do |t|
    t.integer  "d_result_id",                                                 :null => false
    t.integer  "m_tank_id",                                                   :null => false
    t.integer  "inspect_flg",      :limit => 2,                               :null => false
    t.integer  "before_stock",     :limit => 8
    t.integer  "receive",          :limit => 8
    t.integer  "sale",             :limit => 8
    t.integer  "compute_stock",    :limit => 8
    t.integer  "after_stock",      :limit => 8
    t.integer  "sale_total",       :limit => 8
    t.integer  "decrease_total",   :limit => 8
    t.decimal  "total_percentage",              :precision => 6, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "decrease"
  end

  create_table "d_tank_decrease_reports", :force => true do |t|
    t.integer  "d_result_id",                                     :null => false
    t.integer  "oil1_id"
    t.integer  "oil1_num"
    t.integer  "oil2_id"
    t.integer  "oil2_num"
    t.integer  "oil3_id"
    t.integer  "oil3_num"
    t.integer  "oil4_id"
    t.integer  "oil4_num"
    t.decimal  "oil_percent",       :precision => 5, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "oil1_num_total"
    t.integer  "oil2_num_total"
    t.integer  "oil3_num_total"
    t.integer  "oil4_num_total"
    t.decimal  "oil_percent_total", :precision => 5, :scale => 2
  end

  create_table "d_wash_sales", :force => true do |t|
    t.string   "sale_date",       :limit => 8, :default => "00000000", :null => false
    t.integer  "m_shop_id",                    :default => 0,          :null => false
    t.integer  "kakutei_flg",     :limit => 2, :default => 0,          :null => false
    t.integer  "created_user_id",              :default => 0,          :null => false
    t.integer  "updated_user_id",              :default => 0,          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_washpurika_reports", :force => true do |t|
    t.string   "date",            :limit => 6,                :null => false
    t.integer  "m_shop_id",                                   :null => false
    t.integer  "total_rank",                                  :null => false
    t.integer  "league",                                      :null => false
    t.integer  "before_rank",                                 :null => false
    t.integer  "total_point",                  :default => 0
    t.integer  "result1",                      :default => 0
    t.integer  "result2",                      :default => 0
    t.integer  "result3",                      :default => 0
    t.integer  "result4",                      :default => 0
    t.integer  "result5",                      :default => 0
    t.integer  "result6",                      :default => 0
    t.integer  "result7",                      :default => 0
    t.integer  "result8",                      :default => 0
    t.integer  "result9",                      :default => 0
    t.integer  "result10",                     :default => 0
    t.integer  "result11",                     :default => 0
    t.integer  "result12",                     :default => 0
    t.integer  "result13",                     :default => 0
    t.integer  "result14",                     :default => 0
    t.integer  "result15",                     :default => 0
    t.integer  "result16",                     :default => 0
    t.integer  "result17",                     :default => 0
    t.integer  "result18",                     :default => 0
    t.integer  "result19",                     :default => 0
    t.integer  "result20",                     :default => 0
    t.integer  "result21",                     :default => 0
    t.integer  "result22",                     :default => 0
    t.integer  "result23",                     :default => 0
    t.integer  "result24",                     :default => 0
    t.integer  "result25",                     :default => 0
    t.integer  "result26",                     :default => 0
    t.integer  "result27",                     :default => 0
    t.integer  "result28",                     :default => 0
    t.integer  "result29",                     :default => 0
    t.integer  "result30",                     :default => 0
    t.integer  "result31",                     :default => 0
    t.integer  "pace",                         :default => 0
    t.integer  "wash_sale",                    :default => 0
    t.integer  "same_day_pace",                :default => 0
    t.integer  "same_day_result",              :default => 0
    t.integer  "created_user_id"
    t.integer  "updated_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_washsale_detail_reports", :force => true do |t|
    t.integer  "d_washsale_report_id",              :default => 0, :null => false
    t.integer  "m_wash_id",                         :default => 0, :null => false
    t.integer  "wash_no",              :limit => 2, :default => 0, :null => false
    t.integer  "meter",                             :default => 0
    t.integer  "sale_meter",                        :default => 0
    t.integer  "created_user_id",                   :default => 0, :null => false
    t.integer  "updated_user_id",                   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d_washsale_items", :force => true do |t|
    t.integer  "d_wash_sale_id",                                :null => false
    t.integer  "m_wash_id",                                     :null => false
    t.integer  "wash_no",         :limit => 2,                  :null => false
    t.integer  "meter",                          :default => 0
    t.integer  "error_money",                    :default => 0
    t.string   "error_note",      :limit => 200
    t.integer  "created_user_id",                               :null => false
    t.integer  "updated_user_id",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  create_table "d_washsale_reports", :force => true do |t|
    t.string   "sale_date",       :limit => 6, :default => "000000", :null => false
    t.integer  "m_shop_id",                    :default => 0,        :null => false
    t.integer  "kakutei_flg",     :limit => 2, :default => 0,        :null => false
    t.integer  "created_user_id",              :default => 0,        :null => false
    t.integer  "updated_user_id",              :default => 0,        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "establishes", :force => true do |t|
    t.string   "name"
    t.string   "zip_cd",      :limit => 8
    t.string   "address"
    t.string   "system_name"
    t.decimal  "tax_rate",                 :precision => 5, :scale => 2, :default => 0.0, :null => false
    t.decimal  "limit",                    :precision => 5, :scale => 2, :default => 0.0, :null => false
    t.integer  "deleted_flg", :limit => 2,                               :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "light_oil",                :precision => 5, :scale => 2
  end

  create_table "m_aims", :force => true do |t|
    t.integer  "aim_code",    :limit => 2,                 :null => false
    t.string   "aim_name",    :limit => 30
    t.integer  "shop_kbn",    :limit => 2
    t.integer  "input_kbn",   :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deleted_flg", :limit => 2,  :default => 0
    t.datetime "deleted_at"
  end

  create_table "m_approvals", :force => true do |t|
    t.integer  "menu_id",      :null => false
    t.integer  "approval_id1"
    t.integer  "approval_id2"
    t.integer  "approval_id3"
    t.integer  "approval_id4"
    t.integer  "approval_id5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_audit_checks", :force => true do |t|
    t.integer  "check_code",       :limit => 2,                 :null => false
    t.integer  "m_class_check_id",                              :null => false
    t.string   "content",          :limit => 50,                :null => false
    t.integer  "deleted_flg",      :limit => 2,  :default => 0
    t.datetime "deleted_at"
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

  create_table "m_class_checks", :force => true do |t|
    t.integer  "class_code",  :limit => 2,                 :null => false
    t.string   "item",        :limit => 20,                :null => false
    t.integer  "deleted_flg", :limit => 2,  :default => 0
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
    t.integer  "etc_cd",      :limit => 2,                 :null => false
    t.string   "etc_name",    :limit => 20,                :null => false
    t.string   "etc_ryaku",   :limit => 10,                :null => false
    t.integer  "etc_group",   :limit => 2,                 :null => false
    t.integer  "deleted_flg", :limit => 2,  :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_num",     :limit => 2
    t.integer  "kansa_flg",   :limit => 2
    t.integer  "tax_flg",     :limit => 2
    t.integer  "etc_tani",    :limit => 2
    t.integer  "etc_class",   :limit => 2
    t.integer  "price"
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

  create_table "m_fix_items", :force => true do |t|
    t.integer  "fix_item_cd",    :limit => 2,                 :null => false
    t.string   "fix_item_name",  :limit => 20,                :null => false
    t.integer  "fix_item_class", :limit => 2,                 :null => false
    t.integer  "deleted_flg",    :limit => 2,  :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fix_item_ryaku", :limit => 10
  end

  create_table "m_fix_moneys", :force => true do |t|
    t.integer  "m_shop_id",                                      :null => false
    t.integer  "start_month",                                    :null => false
    t.integer  "end_month",                                      :null => false
    t.integer  "m_fix_item_id1"
    t.integer  "fix_money1"
    t.integer  "m_fix_item_id2"
    t.integer  "fix_money2"
    t.integer  "m_fix_item_id3"
    t.integer  "fix_money3"
    t.integer  "m_fix_item_id4"
    t.integer  "fix_money4"
    t.integer  "m_fix_item_id5"
    t.integer  "fix_money5"
    t.integer  "m_fix_item_id6"
    t.integer  "fix_money6"
    t.integer  "m_fix_item_id7"
    t.integer  "fix_money7"
    t.integer  "m_fix_item_id8"
    t.integer  "fix_money8"
    t.integer  "m_fix_item_id9"
    t.integer  "fix_money9"
    t.integer  "m_fix_item_id10"
    t.integer  "fix_money10"
    t.integer  "m_fix_item_id11"
    t.integer  "fix_money11"
    t.integer  "m_fix_item_id12"
    t.integer  "fix_money12"
    t.integer  "m_fix_item_id13"
    t.integer  "fix_money13"
    t.integer  "total_cash_box"
    t.integer  "total_change_money"
    t.integer  "total_money"
    t.integer  "deleted_flg",        :limit => 2, :default => 0
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_info_costs", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "base_pay"
    t.integer  "night_pay"
    t.integer  "welfare_pay"
    t.integer  "etc_pay1"
    t.integer  "etc_pay2"
    t.integer  "etc_pay3"
    t.integer  "etc_pay4"
    t.integer  "deleted_flg", :limit => 2, :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "etc_pay5"
    t.integer  "etc_pay6"
  end

  create_table "m_item_accounts", :force => true do |t|
    t.integer  "item_account_code",                               :null => false
    t.string   "item_account_name", :limit => 20,                 :null => false
    t.string   "outline",           :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deleted_flg",       :limit => 2,   :default => 0
    t.datetime "deleted_at"
  end

  create_table "m_items", :force => true do |t|
    t.integer  "item_class",        :limit => 2,                 :null => false
    t.string   "item_name",         :limit => 30
    t.string   "item_ryaku",        :limit => 10
    t.integer  "m_item_account_id",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deleted_flg",       :limit => 2,  :default => 0
    t.datetime "deleted_at"
  end

  create_table "m_meters", :force => true do |t|
    t.integer  "m_shop_id"
    t.integer  "m_oil_id"
    t.integer  "m_tank_id"
    t.integer  "pos_class"
    t.integer  "number",      :limit => 2,                :null => false
    t.integer  "meter_no",    :limit => 2
    t.integer  "deleted_flg", :limit => 2, :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_oiletcs", :force => true do |t|
    t.integer  "oiletc_cd",    :limit => 2,                 :null => false
    t.string   "oiletc_name",  :limit => 20,                :null => false
    t.string   "oiletc_ryaku", :limit => 10,                :null => false
    t.integer  "oiletc_group", :limit => 2,                 :null => false
    t.integer  "deleted_flg",  :limit => 2,  :default => 0, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "oiletc_trade", :limit => 2
    t.integer  "tax_flg",      :limit => 2
    t.integer  "oiletc_tani",  :limit => 2
  end

  create_table "m_oils", :force => true do |t|
    t.integer  "oil_cd"
    t.string   "oil_name"
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "m_shop_groups", :force => true do |t|
    t.integer  "group_cd",    :limit => 2,                 :null => false
    t.string   "group_name",  :limit => 50,                :null => false
    t.integer  "deleted_flg", :limit => 2,  :default => 0
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
    t.integer  "deleted_flg"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tank_no",       :limit => 2
    t.integer  "volume"
    t.string   "tank_name",     :limit => 20
    t.integer  "tank_union_no", :limit => 2,  :default => 0
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
    t.integer  "price",       :default => 0
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

  create_table "users", :force => true do |t|
    t.string   "account",                :limit => 10
    t.string   "user_name",              :limit => 50
    t.string   "user_name_kana",         :limit => 50
    t.integer  "m_shop_id"
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

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
