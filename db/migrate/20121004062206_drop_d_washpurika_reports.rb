# -*- coding:utf-8 -*-
class DropDWashpurikaReports < ActiveRecord::Migration
  def up
    drop_table :d_washpurika_reports
  end

  def down
  end
end
