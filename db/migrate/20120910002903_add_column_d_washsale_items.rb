# -*- coding:utf-8 -*-
class AddColumnDWashsaleItems < ActiveRecord::Migration
  def up
    add_column :d_washsale_items, :price, :integer
    execute "COMMENT ON COLUMN d_washsale_items.price IS '単価'"
  end

  def down
    remove_column :d_washsale_items, :price
  end
end
