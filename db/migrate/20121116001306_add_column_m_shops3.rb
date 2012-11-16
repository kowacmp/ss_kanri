# -*- coding:utf-8 -*-
class AddColumnMShops3 < ActiveRecord::Migration
  def up
    add_column :m_shops, :settling_month, :integer
    
    execute "COMMENT ON COLUMN m_shops.settling_month IS '決算月';"
  end

  def down
    remove_column :m_shops, :settling_month
  end
end
