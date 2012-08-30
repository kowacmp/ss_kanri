# -*- coding:utf-8 -*-
class ChangeMOiletcs < ActiveRecord::Migration
  def up
    remove_column :m_oiletcs, :oiletc_tani
    add_column :m_oiletcs, :oiletc_tani,  :smallint,  :null => false,:limit => 1
    
    execute "COMMENT ON COLUMN m_oiletcs.oiletc_tani IS '単位';"
  end

  def down
    remove_column :m_oiletcs, :oiletc_tani
  end
end
