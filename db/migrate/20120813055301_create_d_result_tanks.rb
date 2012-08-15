# -*- coding:utf-8 -*-
class CreateDResultTanks < ActiveRecord::Migration
  def change
    create_table :d_result_tanks do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_oil_id,        :null => false
      t.integer  :m_tank_id,       :null => false
      t.integer  :receive
      t.integer  :stock     
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_tanks.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_tanks.m_oil_id IS 'タンク油種id';
             COMMENT ON COLUMN d_result_tanks.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN d_result_tanks.receive IS '仕入量';
             COMMENT ON COLUMN d_result_tanks.stock IS '在庫量';           
             COMMENT ON COLUMN d_result_tanks.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_tanks.update_user_id IS '更新者id';
    "         
  end
end
