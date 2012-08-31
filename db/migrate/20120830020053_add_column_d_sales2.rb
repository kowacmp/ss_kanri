# -*- coding:utf-8 -*-
class AddColumnDSales2 < ActiveRecord::Migration
  def up
    add_column :d_sales, :exist_money, :integer
    execute "COMMENT ON COLUMN d_sales.exist_money IS '現金有高'"
    add_column :d_sales, :over_short, :integer
    execute "COMMENT ON COLUMN d_sales.over_short IS '過不足'"
      
  end


  def down
    remove_column :d_sales, :exist_money
    remove_column :d_sales, :over_short
  end
end
