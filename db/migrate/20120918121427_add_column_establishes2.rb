# -*- coding:utf-8 -*-
class AddColumnEstablishes2 < ActiveRecord::Migration
  def up
    add_column :establishes, :yumepoint_cost, :decimal, :precision => 5, :scale => 2
    execute "COMMENT ON COLUMN establishes.yumepoint_cost IS '夢ポイント原価'"
  end

  def down
    remove_column :establishes, :yumepoint_cost
  end
end
