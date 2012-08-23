# -*- coding:utf-8 -*-
class CreateMTanks < ActiveRecord::Migration
  def change
    create_table :m_tanks do |t|
      t.integer :m_shop_id,       :null => false, :limit => 9,    :default => 0
      t.integer :m_oil_id,        :null => false, :limit => 9,    :default => 0
      t.column  :tank_no,         :smallint,      :null  => false,:limit   => 2,:default => 0
      t.string  :tank_name,       :null => false, :limit => 20
      t.integer :volume,          :null => false, :limit => 3,    :default => 0
      t.column  :deleted_flg,     :smallint,      :null  => false,:limit   => 1,:default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_tanks.m_shop_id IS '店舗id';
             COMMENT ON COLUMN m_tanks.m_oil_id IS '油種id';
             COMMENT ON COLUMN m_tanks.tank_no IS 'タンクNo';
             COMMENT ON COLUMN m_tanks.tank_name IS 'タンク名';
             COMMENT ON COLUMN m_tanks.volume IS 'タンク容量';
             COMMENT ON COLUMN m_tanks.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_tanks.deleted_at IS '削除日時';
    "
    
  end
end
