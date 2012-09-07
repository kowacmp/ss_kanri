# -*- coding:utf-8 -*-
class AddColumnToDAuditWashDetails < ActiveRecord::Migration
  def up
    add_column :d_audit_wash_details, :uriage, :integer
    execute "COMMENT ON COLUMN d_audit_wash_details.uriage IS '売上'"
    execute "alter table d_audit_wash_details alter column uriage set default 0"
    execute "update d_audit_wash_details set uriage = 0 where uriage is null"
  end
  
  def down
    remove_column :d_audit_wash_details, :uriage
  end
end
