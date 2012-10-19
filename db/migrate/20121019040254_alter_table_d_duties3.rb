# -*- coding:utf-8 -*-
class AlterTableDDuties3 < ActiveRecord::Migration
  def up
    add_column :d_duties, :input_flg, :integer, :limit=>1, :default => 0
    execute "COMMENT ON COLUMN d_duties.input_flg IS '入力済みフラグ（０：未　１：済）';"
  end

  def down
  end
end
