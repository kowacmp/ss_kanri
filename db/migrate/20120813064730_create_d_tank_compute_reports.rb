# -*- coding:utf-8 -*-
class CreateDTankComputeReports < ActiveRecord::Migration
  def change
    create_table :d_tank_compute_reports do |t|
      t.integer  :d_result_id,       :null => false
      t.integer  :m_tank_id,         :null => false
      t.integer  :m_oil_id,          :null => false
      t.column   :inspect_flg,       :smallint,  :null => false
      t.integer  :before_stock,      :limit => 5      
      t.integer  :receive,           :limit => 5 
      t.integer  :sale,              :limit => 8             
      t.integer  :compute_stock,     :limit => 8
      t.integer  :after_stock,       :limit => 8    
      t.integer  :sale_total,        :limit => 5
      t.integer  :decrease_total,    :limit => 8
      t.decimal  :total_percentage,  :precision => 3, :scale => 3          

      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_tank_compute_reports.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_tank_compute_reports.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN d_tank_compute_reports.m_oil_id IS '油種id';
             COMMENT ON COLUMN d_tank_compute_reports.inspect_flg IS '点検フラグ　0:未 1:済';
             COMMENT ON COLUMN d_tank_compute_reports.before_stock IS '前日実在庫量';
             COMMENT ON COLUMN d_tank_compute_reports.receive IS '受入数量';
             COMMENT ON COLUMN d_tank_compute_reports.sale IS '販売数量';
             COMMENT ON COLUMN d_tank_compute_reports.compute_stock IS '計算在庫量';
             COMMENT ON COLUMN d_tank_compute_reports.after_stock IS '当日実在庫量';
             COMMENT ON COLUMN d_tank_compute_reports.sale_total IS '販売量累計';     
             COMMENT ON COLUMN d_tank_compute_reports.decrease_total IS '増減累計';  
             COMMENT ON COLUMN d_tank_compute_reports.total_percentage IS '累計増減率';                                        
    "  
  end
end
