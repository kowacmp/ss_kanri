# -*- coding:utf-8 -*-
class AddColumnDResultTanks < ActiveRecord::Migration
  def up
    add_column :d_result_tanks, :adjust1, :integer
    add_column :d_result_tanks, :adjust2, :integer
    add_column :d_result_tanks, :comment, :string, :limit => 20
    
    execute "COMMENT ON COLUMN  d_result_tanks.adjust1 IS 'メーター異常';
             COMMENT ON COLUMN  d_result_tanks.adjust2 IS 'タンク戻し';
             COMMENT ON COLUMN  d_result_tanks.comment IS 'コメント';
            "
    
    execute "update d_result_tanks set 
               adjust1 = 0
              ,adjust2 = 0
            "
  end

  def down
    remove_column  :d_result_tanks, :adjust1
    remove_column  :d_result_tanks, :adjust2
    remove_column  :d_result_tanks, :comment
  end
end
