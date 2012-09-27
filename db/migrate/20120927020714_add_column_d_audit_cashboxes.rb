# -*- coding:utf-8 -*-
class AddColumnDAuditCashboxes < ActiveRecord::Migration
  def up
    add_column :d_audit_cashboxes, :cashbox1_2000paper, :integer, :defalut => 0
    add_column :d_audit_cashboxes, :cashbox2_2000paper, :integer, :defalut => 0
    add_column :d_audit_cashboxes, :cashbox3_2000paper, :integer, :defalut => 0
    add_column :d_audit_cashboxes, :cashbox4_2000paper, :integer, :defalut => 0
    add_column :d_audit_cashboxes, :cashbox5_2000paper, :integer, :defalut => 0
    add_column :d_audit_cashboxes, :cashbox6_2000paper, :integer, :defalut => 0    
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫1_二千円札';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫2_二千円札';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫3_二千円札';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫4_二千円札';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫5_二千円札';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_2000paper IS '金庫6_二千円札';"
    
  end

  def down
    add_column :d_audit_cashboxes, :cashbox1_2000paper
    add_column :d_audit_cashboxes, :cashbox2_2000paper
    add_column :d_audit_cashboxes, :cashbox3_2000paper
    add_column :d_audit_cashboxes, :cashbox4_2000paper
    add_column :d_audit_cashboxes, :cashbox5_2000paper
    add_column :d_audit_cashboxes, :cashbox6_2000paper
  end
end
