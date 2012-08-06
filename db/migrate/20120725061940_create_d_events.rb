# -*- coding:utf-8 -*-
class CreateDEvents < ActiveRecord::Migration
  def change
    create_table :d_events do |t|
      t.string :start_day,        :limit => 8,  :null => false
      t.string :end_day,          :limit => 8,  :null => false
      t.string :action_day,       :limit => 8,  :null => false     
      t.integer :menu_id
      t.string :contents,         :limit => 40, :null => false
      t.integer :receive_group1,  :null => false
      t.integer :receive_group2
      t.integer :created_user_id, :null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_events.start_day IS '公開開始日';
             COMMENT ON COLUMN d_events.end_day IS '公開終了日';
             COMMENT ON COLUMN d_events.action_day IS '実施日';             
             COMMENT ON COLUMN d_events.menu_id IS 'メニューid';
             COMMENT ON COLUMN d_events.contents IS '内容';
             COMMENT ON COLUMN d_events.receive_group1 IS '受信権限id1';
             COMMENT ON COLUMN d_events.receive_group2 IS '受信権限id2';
             COMMENT ON COLUMN d_events.created_user_id IS '作成者id ： user_id';
    "    
  end
end
