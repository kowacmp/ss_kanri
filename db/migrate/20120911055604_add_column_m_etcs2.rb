# -*- coding:utf-8 -*-
class AddColumnMEtcs2 < ActiveRecord::Migration
  def up
    add_column :m_etcs, :etc_class, :smallint
    add_column :m_etcs, :price, :integer
    execute "COMMENT ON COLUMN m_etcs.etc_class IS '他売上種別'"    
    execute "COMMENT ON COLUMN m_etcs.price IS '単価'" 
  end


  def down
    remove_column :m_etcs, :etc_class   
    remove_column :m_etcs, :price
  end
end
