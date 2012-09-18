# -*- coding:utf-8 -*-
class AddColumnMOiletcs2 < ActiveRecord::Migration
  def up
    add_column :m_oiletcs, :oiletc_arari, :decimal, :precision => 7, :scale => 2
    execute "COMMENT ON COLUMN m_oiletcs.oiletc_arari IS '粗利'" 
  end

  def down
    remove_column :m_oiletcs, :oiletc_arari
  end
end
