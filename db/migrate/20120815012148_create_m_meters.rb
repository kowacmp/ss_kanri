# -*- coding:utf-8 -*-
class CreateMMeters < ActiveRecord::Migration
  def change
    create_table :m_meters do |t|
      t.integer  :m_tank_id,   :null => false
      t.integer  :m_code_id,   :null => false
      t.column   :number,      :smallint, :null => false
      t.column   :meter_no,    :smallint
      t.column   :deleted_flg, :smallint, :default => 0          
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_meters.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN m_meters.m_code_id IS 'POS種別　m_code_id';
             COMMENT ON COLUMN m_meters.number IS '番号';
             COMMENT ON COLUMN m_meters.meter_no IS 'メーターNo';
             COMMENT ON COLUMN m_meters.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_meters.deleted_at IS '削除日時';                                      
    "      
  end
end
