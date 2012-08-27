# -*- coding:utf-8 -*-
class AddColumnDTankDecreaseReports2 < ActiveRecord::Migration
  def up
    add_column :d_tank_decrease_reports, :oil_percent_total, :decimal, :precision => 5, :scale => 2

    execute "COMMENT ON COLUMN d_tank_decrease_reports.oil_percent_total IS '欠減率累計'" 
  end

  def down
    remove_column :d_tank_decrease_reports, :oil_percent_total
  end
end
