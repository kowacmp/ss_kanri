# -*- coding:utf-8 -*-
class AddColumnEstablishes < ActiveRecord::Migration
  def up
    add_column :establishes, :light_oil, :decimal, :precision => 5, :scale => 2
    change_column :establishes, :limit, :decimal, :precision => 5, :scale => 2
    
    execute "COMMENT ON COLUMN establishes.light_oil IS '軽油税'" 
  end

  def down
    remove_column :establishes, :light_oil
  end
end
