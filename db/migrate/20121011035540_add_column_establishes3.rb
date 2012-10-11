# -*- coding:utf-8 -*-
class AddColumnEstablishes3 < ActiveRecord::Migration
  def up
    add_column :establishes, :add_work_rate, :decimal, :precision=>5, :scale=>2, :default => 0
    add_column :establishes, :add_nigth_work_rate, :decimal, :precision=>5, :scale=>2, :default => 0
    
    execute "COMMENT ON COLUMN establishes.add_work_rate IS '残業割増率';"
    execute "COMMENT ON COLUMN establishes.add_nigth_work_rate IS '深夜残業割増率';"
    
  end

  def down
  end
end
