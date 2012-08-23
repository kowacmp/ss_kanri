# -*- coding:utf-8 -*-
class AddColumnDSales < ActiveRecord::Migration
  def up
    add_column :d_sales, :sale_am_out, :integer
    execute "COMMENT ON COLUMN d_sales.sale_am_out IS '翌日出前'"
    add_column :d_sales, :sale_pm_out, :integer
    execute "COMMENT ON COLUMN d_sales.sale_pm_out IS '翌日出後'"
      
  end


  def down
    remove_column :d_sales, :sale_am_out
    remove_column :d_sales, :sale_pm_out
  end
end
