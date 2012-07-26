# -*- coding:utf-8 -*-
class CreateDComments < ActiveRecord::Migration
  def change
    create_table :d_comments do |t|
      t.timestamp :send_day,      :null => false, :comment => 'test'
      t.integer :menu_id,         :null => false
      t.string :contents,         :limit => 40, :null => false
      t.integer :send_id,         :null => false
      t.integer :receive_id,      :null => false
      t.integer :created_user_id, :null => false

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_comments.send_day IS '発信日';
             COMMENT ON COLUMN d_comments.menu_id IS 'メニューid';
             COMMENT ON COLUMN d_comments.contents IS '内容';
             COMMENT ON COLUMN d_comments.send_id IS '発信ユーザーid';
             COMMENT ON COLUMN d_comments.receive_id IS '受信ユーザーid';
             COMMENT ON COLUMN d_comments.created_user_id IS '作成者id ： user_id';
    "    
  end 
end
