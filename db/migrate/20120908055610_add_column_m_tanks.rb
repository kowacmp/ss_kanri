# -*- coding:utf-8 -*-
class AddColumnMTanks < ActiveRecord::Migration
  def up
    add_column :m_tanks, :tank_union_no,    :smallint, :limit => 2, :default => 0
    execute "COMMENT ON COLUMN m_tanks.tank_union_no IS 'タンク結合No'"
  end

  def down
    remove_column :m_tanks, :tank_union_no
  end
end
