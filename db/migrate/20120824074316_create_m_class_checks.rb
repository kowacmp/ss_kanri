# -*- coding:utf-8 -*-
class CreateMClassChecks < ActiveRecord::Migration
  def change
    create_table :m_class_checks do |t|
      t.column :class_code, :smallint,  :limit => 2,  :null => false
      t.string :item,                   :limit => 20, :null => false
      t.column :deleted_flg, :smallint, :limit => 1,  :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_class_checks.class_code IS '分類コード';
             COMMENT ON COLUMN m_class_checks.item IS '分類名';
             COMMENT ON COLUMN m_class_checks.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_class_checks.deleted_at IS '削除日時';
    "
    
  end
end
