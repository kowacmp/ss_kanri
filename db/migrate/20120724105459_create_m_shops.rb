# -*- coding:utf-8 -*-
class CreateMShops < ActiveRecord::Migration
  def change
    create_table :m_shops do |t|
      t.integer :shop_cd,               :limit => 6,  :null => false
      t.string :shop_name,              :limit => 50, :null => false
      t.string :shop_kana,              :limit => 50, :null => false
      t.string :shop_ryaku,             :limit => 20, :null => false
      t.string :shop_zip_cd,            :limit => 8
      t.string :shop_adress,            :limit => 255
      t.string :shop_tel,               :limit => 12
      t.string :shop_fax,               :limit => 12
      t.string :shop_mail_adress,       :limit => 255
      t.column  :shop_kbn,  :smallint,  :limit => 1, :default => 0
      t.integer :m_shop_group_id,       :limit => 9, :default => 0
      t.integer :m_oil_id1,             :limit => 9, :default => 0
      t.integer :tank1_all,             :limit => 6, :default => 0
      t.integer :m_oil_id2,             :limit => 9, :default => 0
      t.integer :tank2_all,             :limit => 6, :default => 0
      t.integer :m_oil_id3,             :limit => 9, :default => 0
      t.integer :tank3_all,             :limit => 6, :default => 0
      t.integer :m_oil_id4,             :limit => 9, :default => 0
      t.integer :tank4_all,             :limit => 6, :default => 0
      t.column :deleted_flg, :smallint, :limit => 1, :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_shops.shop_cd IS '店舗コード';
             COMMENT ON COLUMN m_shops.shop_name IS '店舗名';
             COMMENT ON COLUMN m_shops.shop_kana IS '店舗カナ';
             COMMENT ON COLUMN m_shops.shop_ryaku IS '店舗略称';
             COMMENT ON COLUMN m_shops.shop_zip_cd IS '郵便番号';
             COMMENT ON COLUMN m_shops.shop_adress IS '住所';
             COMMENT ON COLUMN m_shops.shop_tel IS 'TEL';
             COMMENT ON COLUMN m_shops.shop_fax IS 'FAX';
             COMMENT ON COLUMN m_shops.shop_mail_adress IS 'E-mail';
             COMMENT ON COLUMN m_shops.shop_kbn IS '店舗種別';
             COMMENT ON COLUMN m_shops.m_shop_group_id IS '所属id';
             COMMENT ON COLUMN m_shops.m_oil_id1 IS 'タンク油種1';
             COMMENT ON COLUMN m_shops.tank1_all IS 'タンク総容量1';
             COMMENT ON COLUMN m_shops.m_oil_id2 IS 'タンク油種2';
             COMMENT ON COLUMN m_shops.tank2_all IS 'タンク総容量2';
             COMMENT ON COLUMN m_shops.m_oil_id3 IS 'タンク油種3';
             COMMENT ON COLUMN m_shops.tank3_all IS 'タンク総容量3';
             COMMENT ON COLUMN m_shops.m_oil_id4 IS 'タンク油種4';
             COMMENT ON COLUMN m_shops.tank4_all IS 'タンク総容量4';
             COMMENT ON COLUMN m_shops.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_shops.deleted_at IS '削除日時';
    "
    
  end
end
