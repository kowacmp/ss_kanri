# -*- coding:utf-8 -*-
class AddColumnDResultSelfReports < ActiveRecord::Migration
  def up
    remove_column :d_result_reports, :oiletc_sale
    add_column :d_result_self_reports, :sensya_purika_sale, :integer
    
    execute "COMMENT ON COLUMN d_result_self_reports.sensya_purika_sale IS '洗車プリカ売上'" 
  end

  def down
    remove_column :d_result_self_reports, :sensya_purika_sale
  end
end
