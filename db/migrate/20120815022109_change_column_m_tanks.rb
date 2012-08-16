# -*- coding:utf-8 -*-
class ChangeColumnMTanks < ActiveRecord::Migration
  def up
    remove_column :m_tanks, :tank_all
    remove_column :m_tanks, :measure1   
    remove_column :m_tanks, :measure2 
    remove_column :m_tanks, :measure3 
    remove_column :m_tanks, :measure4 
    remove_column :m_tanks, :measure5 
    remove_column :m_tanks, :measure6 
    remove_column :m_tanks, :measure7 
    remove_column :m_tanks, :measure8 
    remove_column :m_tanks, :measure9 
    remove_column :m_tanks, :measure10 
    remove_column :m_tanks, :measure11 
    remove_column :m_tanks, :measure12

    add_column :m_tanks, :tank_no, :smallint
    add_column :m_tanks, :volume, :integer, :limit => 3
    
    execute "COMMENT ON COLUMN m_tanks.tank_no IS 'タンクNo'"    
    execute "COMMENT ON COLUMN m_tanks.volume IS 'タンク容量 kl'"                                                       
  end

  def down
  end
end
