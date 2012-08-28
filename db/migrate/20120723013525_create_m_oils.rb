# -*- coding:utf-8 -*-
class CreateMOils < ActiveRecord::Migration
  def change
    create_table :m_oils do |t|
      t.column    :oil_cd,      :smallint,  :limit => 2,  :null => false
      t.string    :oil_name,                :limit => 40, :null => false
      t.column    :deleted_flg, :smallint,  :limit => 1,  :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_oils.oil_cd IS '油種コード';
             COMMENT ON COLUMN m_oils.oil_name IS '油種名';
             COMMENT ON COLUMN m_oils.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_oils.deleted_at IS '削除日時';
    "
    
  end
end