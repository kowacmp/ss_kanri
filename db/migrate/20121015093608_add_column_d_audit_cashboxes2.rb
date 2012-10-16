# -*- coding:utf-8 -*-
class AddColumnDAuditCashboxes2 < ActiveRecord::Migration
  def up
    
    add_column :d_audit_cashboxes, :cashbox1_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :cashbox2_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :cashbox3_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :cashbox4_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :cashbox5_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :cashbox6_name, :string, :limit => 10

    add_column :d_audit_cashboxes, :sum1_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum2_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum3_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum4_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum5_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum6_cashbox_name, :string, :limit => 10
    add_column :d_audit_cashboxes, :sum7_cashbox_name, :string, :limit => 10

    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_name IS '金庫1_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_name IS '金庫2_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_name IS '金庫3_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_name IS '金庫4_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_name IS '金庫5_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_name IS '金庫6_名称';"

    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_cashbox_name IS '一括金庫1_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_cashbox_name IS '一括金庫2_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_cashbox_name IS '一括金庫3_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_cashbox_name IS '一括金庫4_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_cashbox_name IS '一括金庫5_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_cashbox_name IS '一括金庫6_名称';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_cashbox_name IS '一括金庫7_名称';"
    
  end

  def down
    
    remove_column :d_audit_cashboxes, :cashbox1_name 
    remove_column :d_audit_cashboxes, :cashbox2_name 
    remove_column :d_audit_cashboxes, :cashbox3_name 
    remove_column :d_audit_cashboxes, :cashbox4_name 
    remove_column :d_audit_cashboxes, :cashbox5_name 
    remove_column :d_audit_cashboxes, :cashbox6_name 

    remove_column :d_audit_cashboxes, :sum1_cashbox_name 
    remove_column :d_audit_cashboxes, :sum2_cashbox_name 
    remove_column :d_audit_cashboxes, :sum3_cashbox_name 
    remove_column :d_audit_cashboxes, :sum4_cashbox_name 
    remove_column :d_audit_cashboxes, :sum5_cashbox_name 
    remove_column :d_audit_cashboxes, :sum6_cashbox_name 
    remove_column :d_audit_cashboxes, :sum7_cashbox_name 
    
  end
end
