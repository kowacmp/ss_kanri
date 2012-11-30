# -*- coding:utf-8 -*-
class AddColumnDDuties2 < ActiveRecord::Migration
  def up
    add_column :d_duties, :day_work_money, :integer, :default => 0
    add_column :d_duties, :day_over_money, :integer, :default => 0
    add_column :d_duties, :night_work_money, :integer, :default => 0
    add_column :d_duties, :night_over_money, :integer, :default => 0
    add_column :d_duties, :time1_money, :integer, :default => 0
    add_column :d_duties, :time2_money, :integer, :default => 0
    add_column :d_duties, :time3_money, :integer, :default => 0
    add_column :d_duties, :time4_money, :integer, :default => 0
    add_column :d_duties, :time5_money, :integer, :default => 0
    add_column :d_duties, :time6_money, :integer, :default => 0
    add_column :d_duties, :day1_money, :integer, :default => 0
    add_column :d_duties, :day2_money, :integer, :default => 0

    execute "COMMENT ON COLUMN d_duties.day_work_money IS '日勤金額';"
    execute "COMMENT ON COLUMN d_duties.day_over_money IS '残業金額';"
    execute "COMMENT ON COLUMN d_duties.night_work_money IS '深夜金額';"
    execute "COMMENT ON COLUMN d_duties.night_over_money IS '深夜残業金額';"
    execute "COMMENT ON COLUMN d_duties.time1_money IS '時間１金額';"
    execute "COMMENT ON COLUMN d_duties.time2_money IS '時間２金額';"
    execute "COMMENT ON COLUMN d_duties.time3_money IS '時間３金額';"
    execute "COMMENT ON COLUMN d_duties.time4_money IS '時間４金額';"
    execute "COMMENT ON COLUMN d_duties.time5_money IS '時間５金額';"
    execute "COMMENT ON COLUMN d_duties.time6_money IS '時間６金額';"
    execute "COMMENT ON COLUMN d_duties.day1_money IS '日数１金額';"
    execute "COMMENT ON COLUMN d_duties.day2_money IS '日数２金額';"
    
 
  end

  def down
  end
end
