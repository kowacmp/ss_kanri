# -*- coding:utf-8 -*-
class AddColumnDAuditCashboxes3 < ActiveRecord::Migration
  def up
    
    add_column :d_audit_cashboxes, :cashbox1_yugai, :integer
    add_column :d_audit_cashboxes, :cashbox2_yugai, :integer
    add_column :d_audit_cashboxes, :cashbox3_yugai, :integer
    add_column :d_audit_cashboxes, :cashbox4_yugai, :integer
    add_column :d_audit_cashboxes, :cashbox5_yugai, :integer
    add_column :d_audit_cashboxes, :cashbox6_yugai, :integer
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_yugai IS 'POS1当日油外売上';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_yugai IS 'POS2当日油外売上';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_yugai IS 'POS3当日油外売上';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_yugai IS 'POS4当日油外売上';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_yugai IS 'POS5当日油外売上';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_yugai IS 'POS6当日油外売上';"
    
  end

  def down
    
    remove_column :d_audit_cashboxes, :cashbox1_yugai
    remove_column :d_audit_cashboxes, :cashbox2_yugai
    remove_column :d_audit_cashboxes, :cashbox3_yugai
    remove_column :d_audit_cashboxes, :cashbox4_yugai
    remove_column :d_audit_cashboxes, :cashbox5_yugai
    remove_column :d_audit_cashboxes, :cashbox6_yugai
    
  end
end
