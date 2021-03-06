# -*- coding:utf-8 -*-
class AddMAims < ActiveRecord::Migration
  def up
    add_column :m_aims, :deleted_flg,    :smallint, :limit => 1, :default => 0
    add_column :m_aims, :deleted_at,     :timestamp
    
    execute "COMMENT ON COLUMN m_aims.deleted_flg IS '削除フラグ'"
    execute "COMMENT ON COLUMN m_aims.deleted_at IS '削除日時'" 
  end

  def down
    remove_column :m_aims, :deleted_flg
    remove_column :m_aims, :deleted_at 
  end
end
