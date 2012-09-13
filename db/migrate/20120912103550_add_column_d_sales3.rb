# -*- coding:utf-8 -*-
class AddColumnDSales3 < ActiveRecord::Migration
  def up
    add_column :d_sales, :balance_money, :integer, :default => 0
    execute "COMMENT ON COLUMN d_sales.balance_money IS '出納残高'"
  end

  def down
    remove_column :d_sales, :balance_money
  end
end
