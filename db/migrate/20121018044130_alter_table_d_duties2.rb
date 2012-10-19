# -*- coding:utf-8 -*-
class AlterTableDDuties2 < ActiveRecord::Migration
  def up
    add_column :d_duties, :kakutei_flg, :integer, :limit=>1, :default => 0
    add_column :d_duties, :day_over_time, :decimal, :precision=>3, :scale=>1, :default => 0
    add_column :d_duties, :work_money, :integer, :default => 0
    add_column :d_duties, :get_money1, :integer, :default => 0
    add_column :d_duties, :get_money2, :integer, :default => 0
    add_column :d_duties, :get_money3, :integer, :default => 0
    add_column :d_duties, :get_money4, :integer, :default => 0
    
    execute "COMMENT ON COLUMN d_duties.kakutei_flg IS '確定フラグ（０：未確定　１：確定）';"
    execute "COMMENT ON COLUMN d_duties.day_over_time IS '残業';"
    execute "COMMENT ON COLUMN d_duties.work_money IS '勤務金額';"
    execute "COMMENT ON COLUMN d_duties.all_money IS '金額合計（勤務金額＋手当１～４＋（人件費情報マスタの時間単価１～６×勤務時間）＋日数単価１～２）';"
    execute "COMMENT ON COLUMN d_duties.get_money1 IS '手当１（項目名称は、m_cost_names.input_name1から取得する）';"
    execute "COMMENT ON COLUMN d_duties.get_money2 IS '手当２（項目名称は、m_cost_names.input_name2から取得する）';"
    execute "COMMENT ON COLUMN d_duties.get_money3 IS '手当３（項目名称は、m_cost_names.input_name3から取得する）';"
    execute "COMMENT ON COLUMN d_duties.get_money4 IS '手当４（項目名称は、m_cost_names.input_name4から取得する）';"
    
    execute "ALTER TABLE d_duties DROP day_work_money, DROP night_work_money, DROP night_over_money;"
    
  end

  def down
  end
end
