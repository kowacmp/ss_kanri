# -*- coding:utf-8 -*-
class AddColumnDWashsaleItems2 < ActiveRecord::Migration
  def up
    remove_column :d_washsale_items, :price
    add_column    :d_washsale_items, :uriage, :integer
    execute "COMMENT ON COLUMN d_washsale_items.uriage IS '売上'"
  end

  def down
    remove_column :d_washsale_items, :uriage
    add_column    :d_washsale_items, :price,  :integer
    execute "COMMENT ON COLUMN d_washsale_items.price IS '単価'"
  end
end
