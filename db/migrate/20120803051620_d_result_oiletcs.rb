# -*- coding:utf-8 -*-
class DResultOiletcs < ActiveRecord::Migration
  def change
    create_table :d_result_oiletcs do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_oiletc_id,     :null => false
      t.integer  :pos1_data
      t.integer  :pos2_data
      t.integer  :pos3_data            
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps             
    end
    
    execute "COMMENT ON COLUMN d_result_oiletcs.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_oiletcs.m_oiletc_id IS '油外種別id';
             COMMENT ON COLUMN d_result_oiletcs.pos1_data IS 'POS1データ';
             COMMENT ON COLUMN d_result_oiletcs.pos2_data IS 'POS2データ';
             COMMENT ON COLUMN d_result_oiletcs.pos3_data IS 'POS3データ';
             COMMENT ON COLUMN d_result_oiletcs.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_oiletcs.update_user_id IS '更新者id';
    "          
  end
end
