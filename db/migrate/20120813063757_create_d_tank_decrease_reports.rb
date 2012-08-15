# -*- coding:utf-8 -*-
class CreateDTankDecreaseReports < ActiveRecord::Migration
  def change
    create_table :d_tank_decrease_reports do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_shop_group_id, :null => false
      t.integer  :oil1_id
      t.integer  :oil1_num,        :limit => 4    
      t.integer  :oil2_id
      t.integer  :oil2_num,        :limit => 4         
      t.integer  :oil3_id
      t.integer  :oil3_num,        :limit => 4   
      t.integer  :oil4_id
      t.integer  :oil4_num,        :limit => 4
      t.decimal  :oil_percent,     :precision => 3, :scale => 2            

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_tank_decrease_reports.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_tank_decrease_reports.m_shop_group_id IS 'タンク油種id';
             COMMENT ON COLUMN d_tank_decrease_reports.oil1_id IS '油種１id';
             COMMENT ON COLUMN d_tank_decrease_reports.oil1_num IS '油種１';
             COMMENT ON COLUMN d_tank_decrease_reports.oil2_id IS '油種２id';
             COMMENT ON COLUMN d_tank_decrease_reports.oil2_num IS '油種２';
             COMMENT ON COLUMN d_tank_decrease_reports.oil3_id IS '油種３id';
             COMMENT ON COLUMN d_tank_decrease_reports.oil3_num IS '油種３';
             COMMENT ON COLUMN d_tank_decrease_reports.oil4_id IS '油種４id';
             COMMENT ON COLUMN d_tank_decrease_reports.oil4_num IS '油種４';     
             COMMENT ON COLUMN d_tank_decrease_reports.oil_percent IS '欠減率';                                         
    "      
  end
end
