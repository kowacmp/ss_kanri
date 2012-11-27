# -*- coding:utf-8 -*-
class AddColumnDWashsaleItems3 < ActiveRecord::Migration
  def up
    add_column :d_washsale_items, :sub_meter, :integer
    
    execute "COMMENT ON COLUMN d_washsale_items.sub_meter IS '予備メータ';"
  end

  def down
    remove_column :d_washsale_items, :sub_meter
  end
end
