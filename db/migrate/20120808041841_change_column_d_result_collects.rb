# -*- coding:utf-8 -*-
class ChangeColumnDResultCollects < ActiveRecord::Migration
  def up
    rename_column :d_result_collects, :m_collect_id, :m_oiletc_id
    
    execute "COMMENT ON COLUMN d_result_collects.m_oiletc_id IS '油外マスタid'"              
  end

  def down
  end
end
