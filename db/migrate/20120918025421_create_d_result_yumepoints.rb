# -*- coding:utf-8 -*-
class CreateDResultYumepoints < ActiveRecord::Migration
  def change
    create_table :d_result_yumepoints do |t|
      t.integer :d_result_id,      :null => false
      t.column  :yumepoint_class,  :smallint,      :limit => 1,   :null => false
      t.column  :yumepoint_num,    :smallint,      :null => false
      t.integer :yumepoint,        :null => false
      t.integer :yumepoint_money,  :null => false
      t.integer :created_user_id
      t.integer :updated_user_id
         
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_yumepoints.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_yumepoints.yumepoint_class IS '夢ポイント種別';
             COMMENT ON COLUMN d_result_yumepoints.yumepoint_num IS '件数';
             COMMENT ON COLUMN d_result_yumepoints.yumepoint IS 'ポイント';
             COMMENT ON COLUMN d_result_yumepoints.yumepoint_money IS '金額';
             COMMENT ON COLUMN d_result_yumepoints.created_user_id IS '作成者id';             
             COMMENT ON COLUMN d_result_yumepoints.updated_user_id IS '更新者id';
    "
  end
end
