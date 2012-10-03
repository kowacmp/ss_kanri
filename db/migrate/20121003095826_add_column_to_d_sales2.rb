# -*- coding:utf-8 -*-
class AddColumnToDSales2 < ActiveRecord::Migration
  def change
    add_column :d_sales, :recive_check, :integer, :defalut => 0, :limit=>1
    execute "COMMENT ON COLUMN d_sales.recive_check IS '入金確認　０：未確定　１：確定';"

  end
end
