# -*- coding:utf-8 -*-
class ChangeColumnDResultMeters < ActiveRecord::Migration
  def up
    rename_column :d_result_meters, :create_user_id, :created_user_id
    rename_column :d_result_meters, :update_user_id, :updated_user_id
     
    execute "COMMENT ON COLUMN d_result_meters.created_user_id IS '作成者id'"  
    execute "COMMENT ON COLUMN d_result_meters.updated_user_id IS '更新者id'"         
  end

  def down
  end
end
