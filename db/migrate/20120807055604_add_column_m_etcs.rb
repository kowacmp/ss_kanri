# -*- coding:utf-8 -*-
class AddColumnMEtcs < ActiveRecord::Migration
  def up
    add_column :m_etcs, :max_num, :smallint
    add_column :m_etcs, :kansa_flg, :smallint
    
    execute "COMMENT ON COLUMN m_etcs.max_num IS '最大数'"    
    execute "COMMENT ON COLUMN m_etcs.kansa_flg IS '監査フラグ　0:監査しない　1:監査項目'"  
  end


  def down
    remove_column :m_etcs, :max_num   
    remove_column :m_etcs, :kansa_flg     
  end
end
