# -*- coding:utf-8 -*-
class AddColumnMShops2 < ActiveRecord::Migration
  def up
    add_column :m_shops, :price_sort, :integer, :default => 0    
    
    execute "COMMENT ON COLUMN m_shops.price_sort IS '価格表出力順';"
  end

  def down
    remove_column :m_shops, :price_sort
  end
end
