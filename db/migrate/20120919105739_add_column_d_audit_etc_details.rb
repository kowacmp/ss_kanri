# -*- coding:utf-8 -*-
class AddColumnDAuditEtcDetails < ActiveRecord::Migration
  def up
    add_column :d_audit_etc_details, :uriage, :integer
    execute "COMMENT ON COLUMN d_audit_etc_details.uriage IS '売上'"    
  end

  def down
    remove_column :d_audit_etc_details, :uriage
  end
end
