# -*- coding:utf-8 -*-
class ChangeColumnDDuties < ActiveRecord::Migration
  def up
    change_column :d_duties, :work_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :all_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :day_work_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :day_over_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :night_work_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :night_over_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time1_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time2_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time3_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time4_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time5_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :time6_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :day1_money, :decimal, :precision => 9, :scale => 1, :default => 0
    change_column :d_duties, :day2_money, :decimal, :precision => 9, :scale => 1, :default => 0
  end

  def down
    change_column :d_duties, :work_money, :integer
    change_column :d_duties, :all_money, :integer
    change_column :d_duties, :day_work_money, :integer
    change_column :d_duties, :day_over_money, :integer
    change_column :d_duties, :night_work_money, :integer
    change_column :d_duties, :night_over_money, :integer
    change_column :d_duties, :time1_money, :integer
    change_column :d_duties, :time2_money, :integer
    change_column :d_duties, :time3_money, :integer
    change_column :d_duties, :time4_money, :integer
    change_column :d_duties, :time5_money, :integer
    change_column :d_duties, :time6_money, :integer
    change_column :d_duties, :day1_money, :integer
    change_column :d_duties, :day2_money, :integer
  end
end
