# -*- coding:utf-8 -*-
class AddColumnDTankDecreaseReports < ActiveRecord::Migration
  def up
    add_column :d_tank_decrease_reports, :oil1_num_total, :integer
    add_column :d_tank_decrease_reports, :oil2_num_total, :integer
    add_column :d_tank_decrease_reports, :oil3_num_total, :integer
    add_column :d_tank_decrease_reports, :oil4_num_total, :integer
    
    change_column :d_tank_decrease_reports, :oil_percent, :decimal, :precision => 5, :scale => 2
    remove_column :d_tank_decrease_reports, :m_shop_group_id
    
    execute "COMMENT ON COLUMN d_tank_decrease_reports.oil1_num_total IS '油種1累計'"
    execute "COMMENT ON COLUMN d_tank_decrease_reports.oil2_num_total IS '油種2累計'" 
    execute "COMMENT ON COLUMN d_tank_decrease_reports.oil3_num_total IS '油種3累計'" 
    execute "COMMENT ON COLUMN d_tank_decrease_reports.oil4_num_total IS '油種4累計'"                  
  end

  def down
    remove_column :d_tank_decrease_reports, :oil1_num_total
    remove_column :d_tank_decrease_reports, :oil2_num_total 
    remove_column :d_tank_decrease_reports, :oil3_num_total 
    remove_column :d_tank_decrease_reports, :oil4_num_total                  
  end
end
