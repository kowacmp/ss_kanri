# -*- coding:utf-8 -*-
class AddColumnMOiletcs < ActiveRecord::Migration
  def up
    add_column :m_oiletcs, :oiletc_trade, :smallint
 
    execute "COMMENT ON COLUMN m_oiletcs.oiletc_trade IS '営業項目'"    
  end


  def down
    remove_column :m_oiletcs, :oiletc_trade   
  end
end
