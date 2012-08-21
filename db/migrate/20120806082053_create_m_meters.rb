# -*- coding:utf-8 -*-
class CreateMMeters < ActiveRecord::Migration
  def change
    create_table :m_meters do |t|
      t.integer :m_shop_id
      t.integer :m_oil_id
      t.integer :m_tank_id
      t.integer :pos_class
      t.column  :number,          :smallint,      :null => false
      t.column  :meter_no,        :smallint
      t.column  :deleted_flg,     :smallint,      :null => false, :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_meters.m_shop_id IS '店舗id';
             COMMENT ON COLUMN m_meters.m_oil_id IS '油種id';
             COMMENT ON COLUMN m_meters.m_tank_id IS 'タンクid';
             COMMENT ON COLUMN m_meters.pos_class IS 'POS種別';
             COMMENT ON COLUMN m_meters.number IS '番号';
             COMMENT ON COLUMN m_meters.meter_no IS 'メーターNo';
             COMMENT ON COLUMN m_meters.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_meters.deleted_at IS '削除日時';
    "
    
  end
end
