# -*- coding:utf-8 -*-
class AddColumnDWashpurikaReports1 < ActiveRecord::Migration
   def up
    add_column :d_washpurika_reports, :object_day, :string, :limit => 8

    execute "COMMENT ON COLUMN d_washpurika_reports.object_day IS '対象年月日';"
  end

  def down
  end
end
