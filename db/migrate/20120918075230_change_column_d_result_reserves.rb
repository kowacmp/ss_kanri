#coding: utf-8
class ChangeColumnDResultReserves < ActiveRecord::Migration
  def up
    execute "delete from d_result_reserves"
    rename_column :d_result_reserves, :get_date, :reserve_nengetu
    change_column :d_result_reserves, :reserve_nengetu, :string, :limit => 6, :null => false

    remove_column :d_result_reserves, :reserve_name
    add_column :d_result_reserves, :reserve_num, :smallint, :null => false
        
    execute "COMMENT ON COLUMN d_result_reserves.reserve_nengetu IS '車検年月';
             COMMENT ON COLUMN d_result_reserves.reserve_num IS '車検件数';
    "    
  end

  def down
  end
end
