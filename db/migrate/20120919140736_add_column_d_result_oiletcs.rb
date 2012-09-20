# -*- coding:utf-8 -*-
class AddColumnDResultOiletcs < ActiveRecord::Migration
  def up
    add_column :d_result_oiletcs, :oiletc_arari, :integer
    execute "COMMENT ON COLUMN d_result_oiletcs.oiletc_arari IS '粗利金額'"     
  end

  def down
    remove_column :d_result_oiletcs, :oiletc_arari
  end
end
