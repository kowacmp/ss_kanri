# -*- coding:utf-8 -*-
class CreateDResultMeters < ActiveRecord::Migration
  def change
    execute "DROP TABLE d_result_meters;"    
    
    create_table :d_result_meters do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_meter_id,      :null => false
      t.integer  :meter            
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_meters.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_meters.m_meter_id IS '計量機id';
             COMMENT ON COLUMN d_result_meters.meter IS 'メーター';             
             COMMENT ON COLUMN d_result_meters.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_meters.update_user_id IS '更新者id';
    "        
  end
end
