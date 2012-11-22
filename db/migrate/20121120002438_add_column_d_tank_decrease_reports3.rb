# -*- coding:utf-8 -*-
class AddColumnDTankDecreaseReports3 < ActiveRecord::Migration
  def up
    add_column :d_tank_decrease_reports, :oil1_adj1,       :integer
    add_column :d_tank_decrease_reports, :oil1_adj1_total, :integer
    add_column :d_tank_decrease_reports, :oil1_adj2,       :integer
    add_column :d_tank_decrease_reports, :oil1_adj2_total, :integer
    
    add_column :d_tank_decrease_reports, :oil2_adj1,       :integer
    add_column :d_tank_decrease_reports, :oil2_adj1_total, :integer
    add_column :d_tank_decrease_reports, :oil2_adj2,       :integer
    add_column :d_tank_decrease_reports, :oil2_adj2_total, :integer
    
    add_column :d_tank_decrease_reports, :oil3_adj1,       :integer
    add_column :d_tank_decrease_reports, :oil3_adj1_total, :integer
    add_column :d_tank_decrease_reports, :oil3_adj2,       :integer
    add_column :d_tank_decrease_reports, :oil3_adj2_total, :integer
    
    add_column :d_tank_decrease_reports, :oil4_adj1,       :integer
    add_column :d_tank_decrease_reports, :oil4_adj1_total, :integer
    add_column :d_tank_decrease_reports, :oil4_adj2,       :integer
    add_column :d_tank_decrease_reports, :oil4_adj2_total, :integer
    
    execute "COMMENT ON COLUMN  d_tank_decrease_reports.oil1_adj1       IS '油種1メーター異常';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil1_adj1_total IS '油種1メーター異常累計';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil1_adj2       IS '油種1タンク戻し';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil1_adj2_total IS '油種1タンク戻し累計';
             
             COMMENT ON COLUMN  d_tank_decrease_reports.oil2_adj1       IS '油種2メーター異常';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil2_adj1_total IS '油種2メーター異常累計';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil2_adj2       IS '油種2タンク戻し';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil2_adj2_total IS '油種2タンク戻し累計';
             
             COMMENT ON COLUMN  d_tank_decrease_reports.oil3_adj1       IS '油種3メーター異常';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil3_adj1_total IS '油種3メーター異常累計';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil3_adj2       IS '油種3タンク戻し';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil3_adj2_total IS '油種3タンク戻し累計';
             
             COMMENT ON COLUMN  d_tank_decrease_reports.oil4_adj1       IS '油種3メーター異常';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil4_adj1_total IS '油種3メーター異常累計';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil4_adj2       IS '油種3タンク戻し';
             COMMENT ON COLUMN  d_tank_decrease_reports.oil4_adj2_total IS '油種3タンク戻し累計';
            "
            
    execute "update d_tank_decrease_reports set 
                 oil1_adj1       = 0 
                ,oil1_adj1_total = 0
                ,oil1_adj2       = 0
                ,oil1_adj2_total = 0
               
                ,oil2_adj1       = 0 
                ,oil2_adj1_total = 0
                ,oil2_adj2       = 0
                ,oil2_adj2_total = 0
                
                ,oil3_adj1       = 0 
                ,oil3_adj1_total = 0
                ,oil3_adj2       = 0
                ,oil3_adj2_total = 0
                
                ,oil4_adj1       = 0 
                ,oil4_adj1_total = 0
                ,oil4_adj2       = 0
                ,oil4_adj2_total = 0
            "
  end

  def down
    remove_column :d_tank_decrease_reports, :oil1_adj1
    remove_column :d_tank_decrease_reports, :oil1_adj1_total
    remove_column :d_tank_decrease_reports, :oil1_adj2
    remove_column :d_tank_decrease_reports, :oil1_adj2_total
    
    remove_column :d_tank_decrease_reports, :oil2_adj1
    remove_column :d_tank_decrease_reports, :oil2_adj1_total
    remove_column :d_tank_decrease_reports, :oil2_adj2
    remove_column :d_tank_decrease_reports, :oil2_adj2_total
    
    remove_column :d_tank_decrease_reports, :oil3_adj1
    remove_column :d_tank_decrease_reports, :oil3_adj1_total
    remove_column :d_tank_decrease_reports, :oil3_adj2
    remove_column :d_tank_decrease_reports, :oil3_adj2_total
    
    remove_column :d_tank_decrease_reports, :oil4_adj1
    remove_column :d_tank_decrease_reports, :oil4_adj1_total
    remove_column :d_tank_decrease_reports, :oil4_adj2
    remove_column :d_tank_decrease_reports, :oil4_adj2_total
    
  end
end
