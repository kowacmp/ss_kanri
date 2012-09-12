# -*- coding:utf-8 -*-
class CreateDDuties < ActiveRecord::Migration
  def change
    create_table :d_duties do |t|
      t.string :duty_nengetu
      t.integer :user_id
      t.integer :m_shop_id
      t.integer :day
      t.decimal :day_work_time, :precision=>2, :scale=>1, :default => 0
      t.decimal :night_work_time, :precision=>3, :scale=>1, :default => 0
      t.decimal :all_work_time, :precision=>3, :scale=>1, :default => 0
      t.integer :day_work_money,:dufault => 0
      t.integer :night_work_money, :default => 0
      t.integer :all_money, :default => 0
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_duties.duty_nengetu IS '勤怠年月 YYYYMM'"
    execute "COMMENT ON COLUMN d_duties.user_id IS 'ユーザID'"
    execute "COMMENT ON COLUMN d_duties.m_shop_id IS '店舗id'"
    execute "COMMENT ON COLUMN d_duties.day IS '日'"
    execute "COMMENT ON COLUMN d_duties.day_work_time IS '日勤'"
    execute "COMMENT ON COLUMN d_duties.night_work_time IS '夜勤'"
    execute "COMMENT ON COLUMN d_duties.all_work_time IS '勤務合計'"
    execute "COMMENT ON COLUMN d_duties.day_work_money IS '日勤金額'"
    execute "COMMENT ON COLUMN d_duties.night_work_money IS '夜勤金額'"
    execute "COMMENT ON COLUMN d_duties.all_money IS '金額合計'"
    execute "COMMENT ON COLUMN d_duties.created_user_id IS '作成者id'"
    execute "COMMENT ON COLUMN d_duties.updated_user_id IS '更新者id'"

  end
end
