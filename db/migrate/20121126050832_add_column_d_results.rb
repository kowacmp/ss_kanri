# -*- coding:utf-8 -*-
class AddColumnDResults < ActiveRecord::Migration
  def up
    add_column :d_result_meters, :sub_meter,:integer
    
    execute "COMMENT ON COLUMN d_result_meters.sub_meter IS '予備メーター　前回メーターと異なる値を設定する場合';"
  end

  def down
    remove_column :d_result_meters, :sub_meter
  end
end
