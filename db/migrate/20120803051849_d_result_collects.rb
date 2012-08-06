# -*- coding:utf-8 -*-
class DResultCollects < ActiveRecord::Migration
  def change
    create_table :d_result_collects do |t|
      t.integer  :d_result_id,     :null => false
      t.integer  :m_collect_id,    :null => false
      t.integer  :get_num,         :null => false          
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps             
    end
    
    execute "COMMENT ON COLUMN d_result_collects.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_collects.m_collect_id IS '回収種別id';
             COMMENT ON COLUMN d_result_collects.get_num IS '件数';
             COMMENT ON COLUMN d_result_collects.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_result_collects.update_user_id IS '更新者id';
    "          
  end
end
