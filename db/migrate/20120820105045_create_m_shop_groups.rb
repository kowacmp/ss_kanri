# -*- coding:utf-8 -*-
class CreateMShopGroups < ActiveRecord::Migration
  def change
    create_table :m_shop_groups do |t|
      t.column :group_cd,          :smallint,:null => false,:limit => 2
      t.string :group_name,        :null => false,:limit => 50
      t.column  :deleted_flg,      :smallint, :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_shop_groups.group_cd IS '所属コード';
             COMMENT ON COLUMN m_shop_groups.group_name IS '所属会社名';
             COMMENT ON COLUMN m_shop_groups.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_shop_groups.deleted_at IS '削除日時';
    "
    
  end
end
