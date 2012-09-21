# -*- coding:utf-8 -*-
class AddColumnDResultSelfReports2 < ActiveRecord::Migration
  def up
    add_column :d_result_self_reports, :cb, :integer
    add_column :d_result_self_reports, :ozone, :integer
    execute "COMMENT ON COLUMN d_result_self_reports.cb IS 'キャッシュバック';
             COMMENT ON COLUMN d_result_self_reports.ozone IS 'オゾン'
    "       
  end

  def down
    remove_column :d_result_self_reports, :cb
    remove_column :d_result_self_reports, :ozone
  end
end
