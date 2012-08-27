# -*- coding:utf-8 -*-
class ChangeColumnDResultTanks < ActiveRecord::Migration
  def up
    rename_column :d_result_tanks, :create_user_id, :created_user_id
    rename_column :d_result_tanks, :update_user_id, :updated_user_id
     
    execute "COMMENT ON COLUMN d_result_tanks.created_user_id IS '作成者id'"  
    execute "COMMENT ON COLUMN d_result_tanks.updated_user_id IS '更新者id'"      
  end

  def down
  end
end
