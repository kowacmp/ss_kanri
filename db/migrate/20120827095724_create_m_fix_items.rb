# -*- coding:utf-8 -*-
class CreateMFixItems < ActiveRecord::Migration
  def change
    create_table :m_fix_items do |t|
      t.column    :fix_item_cd,     :smallint,  :limit => 2,  :null => false
      t.string    :fix_item_name,   :limit => 20,             :null => false
      t.column    :fix_item_class,  :smallint,  :limit => 1,  :null => false
      t.column    :deleted_flg,     :smallint,  :limit => 1,  :null => false, :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_fix_items.fix_item_cd IS '固定額内訳コード';
             COMMENT ON COLUMN m_fix_items.fix_item_name IS '固定額内訳名';
             COMMENT ON COLUMN m_fix_items.fix_item_class IS '固定額内訳種別';
             COMMENT ON COLUMN m_fix_items.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_fix_items.deleted_at IS '削除日時';
    "
    
  end
end
