# -*- coding:utf-8 -*-
class CreateDResultReserves < ActiveRecord::Migration
  def change
    create_table :d_result_reserves do |t|
      t.integer   :d_result_id,     :null => false
      t.string    :get_date,        :null => false, :limit => 8
      t.string    :reserve_name,                    :limit => 50      
      t.integer   :created_user_id, :null => false
      t.integer   :updated_user_id, :null => false

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_reserves.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_reserves.get_date IS '車検予約日';
             COMMENT ON COLUMN d_result_reserves.reserve_name IS '車検予約者名';
             COMMENT ON COLUMN d_result_reserves.created_user_id IS '作成者id ： user_id';
             COMMENT ON COLUMN d_result_reserves.created_user_id IS '更新者id ： user_id';
             
    "     
  end
end
