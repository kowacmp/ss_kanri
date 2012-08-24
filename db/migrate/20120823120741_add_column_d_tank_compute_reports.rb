# -*- coding:utf-8 -*-
class AddColumnDTankComputeReports < ActiveRecord::Migration
  def up
    add_column :d_tank_compute_reports, :decrease, :integer
    change_column :d_tank_compute_reports, :total_percentage, :decimal, :precision => 6, :scale => 3
    remove_column :d_tank_compute_reports, :m_oil_id
    
    execute "COMMENT ON COLUMN d_tank_compute_reports.decrease IS '増減'"  
  end


  def down
    remove_column :d_tank_compute_reports, :decrease    
  end
end
