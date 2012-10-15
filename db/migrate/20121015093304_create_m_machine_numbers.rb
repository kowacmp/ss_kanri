# -*- coding:utf-8 -*-
class CreateMMachineNumbers < ActiveRecord::Migration
  def change
    create_table :m_machine_numbers do |t|
      t.integer :m_shop_id,:default => 0,:null => false
      t.string  :pos1machineno1,         :limit => 10
      t.string  :pos1machineno2,         :limit => 10
      t.string  :pos1machineno3,         :limit => 10
      t.string  :pos1machineno4,         :limit => 10
      t.string  :pos1machineno5,         :limit => 10
      t.string  :pos1machineno6,         :limit => 10
      t.string  :pos1machineno7,         :limit => 10
      t.string  :pos2machineno1,         :limit => 10
      t.string  :pos2machineno2,         :limit => 10
      t.string  :pos2machineno3,         :limit => 10
      t.string  :pos2machineno4,         :limit => 10
      t.string  :pos2machineno5,         :limit => 10
      t.string  :pos2machineno6,         :limit => 10
      t.string  :pos2machineno7,         :limit => 10
      t.string  :pos3machineno1,         :limit => 10
      t.string  :pos3machineno2,         :limit => 10
      t.string  :pos3machineno3,         :limit => 10
      t.string  :pos3machineno4,         :limit => 10
      t.string  :pos3machineno5,         :limit => 10
      t.string  :pos3machineno6,         :limit => 10
      t.string  :pos3machineno7,         :limit => 10

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_machine_numbers.m_shop_id IS '店舗id';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno1 IS 'POS1釣銭機1';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno2 IS 'POS1釣銭機2';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno3 IS 'POS1釣銭機3';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno4 IS 'POS1釣銭機4';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno5 IS 'POS1釣銭機5';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno6 IS 'POS1釣銭機6';
             COMMENT ON COLUMN m_machine_numbers.pos1machineno7 IS 'POS1釣銭機7';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno1 IS 'POS2釣銭機1';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno2 IS 'POS2釣銭機2';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno3 IS 'POS2釣銭機3';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno4 IS 'POS2釣銭機4';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno5 IS 'POS2釣銭機5';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno6 IS 'POS2釣銭機6';
             COMMENT ON COLUMN m_machine_numbers.pos2machineno7 IS 'POS2釣銭機7';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno1 IS 'POS3釣銭機1';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno2 IS 'POS3釣銭機2';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno3 IS 'POS3釣銭機3';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno4 IS 'POS3釣銭機4';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno5 IS 'POS3釣銭機5';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno6 IS 'POS3釣銭機6';
             COMMENT ON COLUMN m_machine_numbers.pos3machineno7 IS 'POS3釣銭機7';
    "
    
  end
end
