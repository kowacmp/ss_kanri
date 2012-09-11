#coding: utf-8
class ChangeColumnDResultReports < ActiveRecord::Migration
  def up
    rename_column :d_result_reports, :coating, :sp_plus
    rename_column :d_result_self_reports, :coating, :sp_plus
    
    execute "COMMENT ON COLUMN d_result_reports.sp_plus IS 'スピードパスプラス'" 
    execute "COMMENT ON COLUMN d_result_self_reports.sp_plus IS 'スピードパスプラス'" 
  end

  def down
  end
end
