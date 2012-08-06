# -*- coding:utf-8 -*-
class CreateDMessages < ActiveRecord::Migration
  def change
    create_table :d_messages do |t|
      t.timestamp :send_day,        :null => false
      t.integer   :menu_id,         :null => false
      t.string    :contents,        :null => false, :limit => 40
      t.integer   :receive_id1
      t.integer   :receive_id2
      t.integer   :receive_id3
      t.integer   :receive_id4
      t.integer   :receive_id5
      t.integer   :receive_group1
      t.integer   :receive_group2   
      t.integer   :created_user_id, :null => false

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_messages.send_day IS '発信日';
             COMMENT ON COLUMN d_messages.menu_id IS 'メニューid';
             COMMENT ON COLUMN d_messages.contents IS '内容';
             COMMENT ON COLUMN d_messages.receive_id1 IS '受信ユーザーid1';
             COMMENT ON COLUMN d_messages.receive_id2 IS '受信ユーザーid2';
             COMMENT ON COLUMN d_messages.receive_id3 IS '受信ユーザーid3';
             COMMENT ON COLUMN d_messages.receive_id4 IS '受信ユーザーid4';
             COMMENT ON COLUMN d_messages.receive_id5 IS '受信ユーザーid5';
             COMMENT ON COLUMN d_messages.receive_group1 IS '受信権限id1';
             COMMENT ON COLUMN d_messages.receive_group2 IS '受信権限id2';
             COMMENT ON COLUMN d_messages.created_user_id IS '作成者id ： user_id';
    "    
  end
end
