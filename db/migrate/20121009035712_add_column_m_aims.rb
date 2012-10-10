# -*- coding:utf-8 -*-
class AddColumnMAims < ActiveRecord::Migration
  def up
    add_column :m_aims, :aim_tani,:smallint, :defalut => 0    
    
    execute "COMMENT ON COLUMN m_aims.aim_tani IS '単位';"
  end

  def down
    add_column :m_aims, :aim_tani
  end
end
