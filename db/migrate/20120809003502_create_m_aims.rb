# -*- coding:utf-8 -*-
class CreateMAims < ActiveRecord::Migration
  def change
    create_table :m_aims do |t|
      t.column  :aim_code,          :smallint,      :null => false
      t.string :aim_name,           :limit => 30
      t.column  :shop_kbn,          :smallint

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_aims.aim_code IS '目標値コード';
             COMMENT ON COLUMN m_aims.aim_name IS '目標値名';
             COMMENT ON COLUMN m_aims.shop_kbn IS '店舗種別';
    "
    
  end
end
