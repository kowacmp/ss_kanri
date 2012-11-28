# -*- coding:utf-8 -*-
class AddColumnDSaleEtcDetails1 < ActiveRecord::Migration
  def up
    add_column :d_sale_etc_details, :sub_meter,:integer
    
    execute "COMMENT ON COLUMN d_result_meters.sub_meter IS '予備メーター　前回メーターと異なる値を設定する場合';"
  end

  def down
    remove_column :d_sale_etc_details, :sub_meter,:integer
  end
end
 