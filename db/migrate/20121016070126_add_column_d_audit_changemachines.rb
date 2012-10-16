# -*- coding:utf-8 -*-
class AddColumnDAuditChangemachines < ActiveRecord::Migration
  def up
    
    add_column :d_audit_changemachines, :pos1machineno1, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno2, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno3, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno4, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno5, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno6, :string, :limit => 10
    add_column :d_audit_changemachines, :pos1machineno7, :string, :limit => 10
    
    add_column :d_audit_changemachines, :pos2machineno1, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno2, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno3, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno4, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno5, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno6, :string, :limit => 10
    add_column :d_audit_changemachines, :pos2machineno7, :string, :limit => 10
    
    add_column :d_audit_changemachines, :pos3machineno1, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno2, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno3, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno4, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno5, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno6, :string, :limit => 10
    add_column :d_audit_changemachines, :pos3machineno7, :string, :limit => 10
    
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno1 IS 'POS1釣銭機1';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno2 IS 'POS1釣銭機2';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno3 IS 'POS1釣銭機3';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno4 IS 'POS1釣銭機4';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno5 IS 'POS1釣銭機5';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno6 IS 'POS1釣銭機6';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos1machineno7 IS 'POS1釣銭機7';"
    
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno1 IS 'POS2釣銭機1';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno2 IS 'POS2釣銭機2';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno3 IS 'POS2釣銭機3';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno4 IS 'POS2釣銭機4';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno5 IS 'POS2釣銭機5';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno6 IS 'POS2釣銭機6';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos2machineno7 IS 'POS2釣銭機7';"

    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno1 IS 'POS3釣銭機1';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno2 IS 'POS3釣銭機2';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno3 IS 'POS3釣銭機3';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno4 IS 'POS3釣銭機4';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno5 IS 'POS3釣銭機5';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno6 IS 'POS3釣銭機6';"
    execute "COMMENT ON COLUMN m_machine_numbers.pos3machineno7 IS 'POS3釣銭機7';"

  end

  def down
    
    remove_column :d_audit_changemachines, :pos1machineno1
    remove_column :d_audit_changemachines, :pos1machineno2
    remove_column :d_audit_changemachines, :pos1machineno3
    remove_column :d_audit_changemachines, :pos1machineno4
    remove_column :d_audit_changemachines, :pos1machineno5
    remove_column :d_audit_changemachines, :pos1machineno6
    remove_column :d_audit_changemachines, :pos1machineno7
    
    remove_column :d_audit_changemachines, :pos2machineno1
    remove_column :d_audit_changemachines, :pos2machineno2
    remove_column :d_audit_changemachines, :pos2machineno3
    remove_column :d_audit_changemachines, :pos2machineno4
    remove_column :d_audit_changemachines, :pos2machineno5
    remove_column :d_audit_changemachines, :pos2machineno6
    remove_column :d_audit_changemachines, :pos2machineno7
    
    remove_column :d_audit_changemachines, :pos3machineno1
    remove_column :d_audit_changemachines, :pos3machineno2
    remove_column :d_audit_changemachines, :pos3machineno3
    remove_column :d_audit_changemachines, :pos3machineno4
    remove_column :d_audit_changemachines, :pos3machineno5
    remove_column :d_audit_changemachines, :pos3machineno6
    remove_column :d_audit_changemachines, :pos3machineno7
    
  end
  
end
