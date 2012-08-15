# -*- coding:utf-8 -*-
class CreateDResultMeters < ActiveRecord::Migration
  def change
    execute "DROP TABLE d_result_meters;"    
    
    create_table :d_result_meters do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_oil_id,        :null => false
      t.integer  :m_tank_id,       :null => false
      t.integer  :m_code_id,       :null => false      
      t.column   :number,          :smallint,  :null => false
      t.column   :meter_no,        :smallint
      t.integer  :meter            
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_meters.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_meters.m_oil_id IS 'タンク油種id';
             COMMENT ON COLUMN d_result_meters.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN d_result_meters.m_code_id IS 'コードid　　POS種別';
             COMMENT ON COLUMN d_result_meters.number IS '番号';
             COMMENT ON COLUMN d_result_meters.meter_no IS 'メーターNo';
             COMMENT ON COLUMN d_result_meters.meter IS 'メーター';             
             COMMENT ON COLUMN d_result_meters.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_meters.update_user_id IS '更新者id';
    "        
  end
end
