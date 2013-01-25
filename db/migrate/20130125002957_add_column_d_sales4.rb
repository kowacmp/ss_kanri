# -*- coding:utf-8 -*-
class AddColumnDSales4 < ActiveRecord::Migration
  def up
    add_column :d_sales, :comment, :string, :limit => 100
    
    execute "COMMENT ON COLUMN d_sales.comment IS '過不足理由';"
  end

  def down
    remove_column :d_sales, :comment
  end
end
