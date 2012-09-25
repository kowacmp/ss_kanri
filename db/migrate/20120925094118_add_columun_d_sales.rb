# -*- coding:utf-8 -*-
class AddColumunDSales < ActiveRecord::Migration
  def up
    add_column :d_sales, :sale_etc, :integer
    execute "COMMENT ON COLUMN d_sales.sale_etc IS 'その他売上';"
  end

  def down
    remove_column :d_sales, :sale_etc
  end
end
