# -*- coding:utf-8 -*-
class CreateMEtcShops < ActiveRecord::Migration
  def change
    create_table :m_etc_shops do |t|
      t.integer :m_shop_id                ,:null => false
      t.string  :brand       ,:limit => 10
      t.string  :company     ,:limit => 20
      t.string  :shape       ,:limit => 10
      t.integer :tank        ,:limit => 5,:default => 0
      t.integer :area        ,:limit => 5,:default => 0
      t.integer :access_group,:limit => 2,:default => 0
      t.string  :access      ,:limit => 50
      t.string  :place       ,:limit => 50
      t.string  :item1       ,:limit => 20
      t.string  :item2       ,:limit => 20
      t.string  :item3       ,:limit => 20
      t.string  :item4       ,:limit => 20
      t.string  :item5       ,:limit => 20
      t.string  :item6       ,:limit => 20
      t.integer :created_user_id          ,:default => 0
      t.integer :updated_user_id          ,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN m_etc_shops.m_shop_id IS '店舗id';
             COMMENT ON COLUMN m_etc_shops.brand IS 'ブランド';
             COMMENT ON COLUMN m_etc_shops.company IS '会社名';
             COMMENT ON COLUMN m_etc_shops.shape IS '種別';
             COMMENT ON COLUMN m_etc_shops.tank IS 'タンク容量';
             COMMENT ON COLUMN m_etc_shops.area IS '面積';
             COMMENT ON COLUMN m_etc_shops.access_group IS 'アクセスグループ';
             COMMENT ON COLUMN m_etc_shops.access IS 'アクセス';
             COMMENT ON COLUMN m_etc_shops.place IS '位置';
             COMMENT ON COLUMN m_etc_shops.item1 IS '項目1';
             COMMENT ON COLUMN m_etc_shops.item2 IS '項目2';
             COMMENT ON COLUMN m_etc_shops.item3 IS '項目3';
             COMMENT ON COLUMN m_etc_shops.item4 IS '項目4';
             COMMENT ON COLUMN m_etc_shops.item5 IS '項目5';
             COMMENT ON COLUMN m_etc_shops.item6 IS '項目6';
             COMMENT ON COLUMN m_etc_shops.created_user_id IS '作成者id';
             COMMENT ON COLUMN m_etc_shops.updated_user_id IS '更新者id';
    "
  end
end
