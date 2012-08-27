# -*- coding:utf-8 -*-
class CreateMApprovals < ActiveRecord::Migration
  def change
    create_table :m_approvals do |t|
      t.integer :menu_id,:null => false 
      t.integer :approval_id1
      t.string  :approval_name1,:limit => 10
      t.integer :approval_id2
      t.string  :approval_name2,:limit => 10
      t.integer :approval_id3
      t.string  :approval_name3,:limit => 10
      t.integer :approval_id4
      t.string  :approval_name4,:limit => 10
      t.integer :approval_id5
      t.string  :approval_name5,:limit => 10

      t.timestamps
    end
    execute "COMMENT ON COLUMN m_approvals.menu_id IS 'メニューid';
             COMMENT ON COLUMN m_approvals.approval_id1 IS '承認者id1';
             COMMENT ON COLUMN m_approvals.approval_name1 IS '承認者名1';
             COMMENT ON COLUMN m_approvals.approval_id2 IS '承認者id2';
             COMMENT ON COLUMN m_approvals.approval_name2 IS '承認者名2';
             COMMENT ON COLUMN m_approvals.approval_id3 IS '承認者id3';
             COMMENT ON COLUMN m_approvals.approval_name3 IS '承認者名3';
             COMMENT ON COLUMN m_approvals.approval_id4 IS '承認者id4';
             COMMENT ON COLUMN m_approvals.approval_name4 IS '承認者名4';
             COMMENT ON COLUMN m_approvals.approval_id5 IS '承認者id5';
             COMMENT ON COLUMN m_approvals.approval_name5 IS '承認者名5';
    "  
  end
end
