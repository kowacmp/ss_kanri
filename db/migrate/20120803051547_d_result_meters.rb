# -*- coding:utf-8 -*-
class DResultMeters < ActiveRecord::Migration
  def change
    create_table :d_result_meters do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_oil_id,        :null => false
      t.integer  :m_tank_id,       :null => false
      t.integer  :pos1_meter1
      t.integer  :pos1_meter2
      t.integer  :pos1_meter3      
      t.integer  :pos1_meter4
      t.integer  :pos1_meter5
      t.integer  :pos1_meter6
      t.integer  :pos1_meter7
      t.integer  :pos1_meter8
      t.integer  :pos1_meter9
      t.integer  :pos1_meter10
      t.integer  :pos1_meter11
      t.integer  :pos1_meter12                                                
      t.integer  :pos2_meter1
      t.integer  :pos2_meter2
      t.integer  :pos2_meter3      
      t.integer  :pos2_meter4
      t.integer  :pos2_meter5
      t.integer  :pos2_meter6
      t.integer  :pos2_meter7
      t.integer  :pos2_meter8
      t.integer  :pos2_meter9
      t.integer  :pos2_meter10
      t.integer  :pos2_meter11
      t.integer  :pos2_meter12
      t.integer  :pos3_meter1
      t.integer  :pos3_meter2
      t.integer  :pos3_meter3      
      t.integer  :pos3_meter4
      t.integer  :pos3_meter5
      t.integer  :pos3_meter6
      t.integer  :pos3_meter7
      t.integer  :pos3_meter8
      t.integer  :pos3_meter9
      t.integer  :pos3_meter10
      t.integer  :pos3_meter11
      t.integer  :pos3_meter12
      t.integer  :arrive_data
      t.integer  :stock_data                             
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps             
    end
    
    execute "COMMENT ON COLUMN d_result_meters.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_meters.m_oil_id IS '油種id';
             COMMENT ON COLUMN d_result_meters.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN d_result_meters.pos1_meter1 IS 'POS1メーター1';
             COMMENT ON COLUMN d_result_meters.pos1_meter2 IS 'POS1メーター2';
             COMMENT ON COLUMN d_result_meters.pos1_meter3 IS 'POS1メーター3';
             COMMENT ON COLUMN d_result_meters.pos1_meter4 IS 'POS1メーター4';
             COMMENT ON COLUMN d_result_meters.pos1_meter5 IS 'POS1メーター5';
             COMMENT ON COLUMN d_result_meters.pos1_meter6 IS 'POS1メーター6';
             COMMENT ON COLUMN d_result_meters.pos1_meter7 IS 'POS1メーター7';
             COMMENT ON COLUMN d_result_meters.pos1_meter8 IS 'POS1メーター8';
             COMMENT ON COLUMN d_result_meters.pos1_meter9 IS 'POS1メーター9';
             COMMENT ON COLUMN d_result_meters.pos1_meter10 IS 'POS1メーター10';
             COMMENT ON COLUMN d_result_meters.pos1_meter11 IS 'POS1メーター11';
             COMMENT ON COLUMN d_result_meters.pos1_meter12 IS 'POS1メーター12';
             COMMENT ON COLUMN d_result_meters.pos2_meter1 IS 'POS2メーター1';
             COMMENT ON COLUMN d_result_meters.pos2_meter2 IS 'POS2メーター2';
             COMMENT ON COLUMN d_result_meters.pos2_meter3 IS 'POS2メーター3';
             COMMENT ON COLUMN d_result_meters.pos2_meter4 IS 'POS2メーター4';
             COMMENT ON COLUMN d_result_meters.pos2_meter5 IS 'POS2メーター5';
             COMMENT ON COLUMN d_result_meters.pos2_meter6 IS 'POS2メーター6';
             COMMENT ON COLUMN d_result_meters.pos2_meter7 IS 'POS2メーター7';
             COMMENT ON COLUMN d_result_meters.pos2_meter8 IS 'POS2メーター8';
             COMMENT ON COLUMN d_result_meters.pos2_meter9 IS 'POS2メーター9';
             COMMENT ON COLUMN d_result_meters.pos2_meter10 IS 'POS2メーター10';
             COMMENT ON COLUMN d_result_meters.pos2_meter11 IS 'POS2メーター11';
             COMMENT ON COLUMN d_result_meters.pos2_meter12 IS 'POS2メーター12';      
             COMMENT ON COLUMN d_result_meters.pos3_meter1 IS 'POS3メーター1';
             COMMENT ON COLUMN d_result_meters.pos3_meter2 IS 'POS3メーター2';
             COMMENT ON COLUMN d_result_meters.pos3_meter3 IS 'POS3メーター3';
             COMMENT ON COLUMN d_result_meters.pos3_meter4 IS 'POS3メーター4';
             COMMENT ON COLUMN d_result_meters.pos3_meter5 IS 'POS3メーター5';
             COMMENT ON COLUMN d_result_meters.pos3_meter6 IS 'POS3メーター6';
             COMMENT ON COLUMN d_result_meters.pos3_meter7 IS 'POS3メーター7';
             COMMENT ON COLUMN d_result_meters.pos3_meter8 IS 'POS3メーター8';
             COMMENT ON COLUMN d_result_meters.pos3_meter9 IS 'POS3メーター9';
             COMMENT ON COLUMN d_result_meters.pos3_meter10 IS 'POS3メーター10';
             COMMENT ON COLUMN d_result_meters.pos3_meter11 IS 'POS3メーター11';
             COMMENT ON COLUMN d_result_meters.pos3_meter12 IS 'POS3メーター12';   
             COMMENT ON COLUMN d_result_meters.arrive_data IS '仕入量';
             COMMENT ON COLUMN d_result_meters.stock_data IS '在庫量';                                                                                                                                                                              
             COMMENT ON COLUMN d_result_meters.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_meters.update_user_id IS '更新者id';
    "          
  end
end
