# -*- coding:utf-8 -*-
class AddColumnDResultSelfReports3 < ActiveRecord::Migration
  def up
    add_column :d_result_self_reports, :type_err, :integer
    execute "COMMENT ON COLUMN d_result_self_reports.type_err IS '入力ミス';"
  end

  def down
    remove_column :d_result_self_reports, :type_err
  end
end
