# -*- coding:utf-8 -*-
class ChangeMEtcs < ActiveRecord::Migration
  def up
    remove_column :m_etcs, :etc_tani
    add_column :m_etcs, :etc_tani,  :smallint,  :null => false,:limit => 1
    
    execute "COMMENT ON COLUMN m_etcs.etc_tani IS '単位';"
  end

  def down
    remove_column :m_etcs, :etc_tani
  end
end
