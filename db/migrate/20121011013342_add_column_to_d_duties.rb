# -*- coding:utf-8 -*-
class AddColumnToDDuties < ActiveRecord::Migration
  def change
    add_column :d_duties, :night_over_time, :decimal, :precision=>3, :scale=>1, :default => 0
    add_column :d_duties, :night_over_money, :integer, :default => 0   
    
    execute "COMMENT ON COLUMN d_duties.night_over_time IS '深夜残業';"
    execute "COMMENT ON COLUMN d_duties.night_over_money IS '深夜残業金額';"
  end
end
