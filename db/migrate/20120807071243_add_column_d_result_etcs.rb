# -*- coding:utf-8 -*-
class AddColumnDResultEtcs < ActiveRecord::Migration
  def up
    add_column :d_result_etcs, :no, :smallint

    execute "COMMENT ON COLUMN d_result_etcs.no IS '機種番号'"  
  end


  def down
    remove_column :d_result_etcs, :no    
  end
end
