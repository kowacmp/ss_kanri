# -*- coding:utf-8 -*-
class AddColumnToMWashes < ActiveRecord::Migration
  def up
    add_column :m_washes, :price, :integer
    execute "COMMENT ON COLUMN m_washes.price IS '単価'"
    execute "alter table m_washes alter column price set default 0"
    execute "update m_washes set price = 0 where price is null"
  end
  
  def down
    remove_column :m_washes, :price
  end
  
end
