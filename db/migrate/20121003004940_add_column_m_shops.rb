# -*- coding:utf-8 -*-
class AddColumnMShops < ActiveRecord::Migration
  def up
    add_column :m_shops, :delivery_cd, :integer, :defalut => 0    
    
    execute "COMMENT ON COLUMN m_shops.delivery_cd IS '配送先コード';"
  end

  def down
    add_column :m_shops, :delivery_cd
  end
end
