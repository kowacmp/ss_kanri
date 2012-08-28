# -*- coding:utf-8 -*-
class AddMItems < ActiveRecord::Migration
  def up
    add_column :m_items, :deleted_flg,    :smallint, :limit => 1, :default => 0
    add_column :m_items, :deleted_at,     :timestamp
    
    rename_column :m_items, :m_item_account, :m_item_account_id 
    
    execute "COMMENT ON COLUMN m_items.deleted_flg IS '削除フラグ'"
    execute "COMMENT ON COLUMN m_items.deleted_at IS '削除日時'" 
    
  end

  def down
    remove_column :m_items, :deleted_flg
    remove_column :m_items, :deleted_at 
  end
end
