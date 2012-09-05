# -*- coding:utf-8 -*-
class AddColumnDResultReports < ActiveRecord::Migration
  def up
    add_column :d_result_reports, :oiletc_sale, :integer
    add_column :d_result_reports, :oiletc_pace, :integer
    add_column :d_result_reports, :arari_total, :integer
    
    execute "COMMENT ON COLUMN d_result_reports.oiletc_sale IS '油外売上'"
    execute "COMMENT ON COLUMN d_result_reports.oiletc_pace IS '油外ペース'"
    execute "COMMENT ON COLUMN d_result_reports.arari_total IS '粗利トータル'" 
  end

  def down
    remove_column :d_result_reports, :oiletc_sale
    remove_column :d_result_reports, :oiletc_pace
    remove_column :d_result_reports, :arari_total
  end
end
