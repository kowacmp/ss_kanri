# -*- coding:utf-8 -*-
class CreateMAuditChecks < ActiveRecord::Migration
  def change
    create_table :m_audit_checks do |t|
      t.column :check_code, :smallint,  :limit => 2,  :null => false
      t.integer :m_class_check_id,      :limit => 9,  :null => false
      t.string :content,                :limit => 50, :null => false
      t.column :deleted_flg, :smallint, :limit => 1,  :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_audit_checks.check_code IS 'チェックコード';
             COMMENT ON COLUMN m_audit_checks.m_class_check_id IS '分類id';
             COMMENT ON COLUMN m_audit_checks.content IS '内容';
             COMMENT ON COLUMN m_audit_checks.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_audit_checks.deleted_at IS '削除日時';
    "
    
  end
end
