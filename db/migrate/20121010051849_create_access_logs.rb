# -*- coding:utf-8 -*-
class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.datetime :access_date
      t.integer :user_id
      t.string :controller
      t.string :action
      t.string :remote_host
      t.text :params
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN access_logs.access_date IS 'アクセス日時';"
    execute "COMMENT ON COLUMN access_logs.user_id IS 'アクセスユーザID';"
    execute "COMMENT ON COLUMN access_logs.controller IS 'コントローラ名';"
    execute "COMMENT ON COLUMN access_logs.action IS 'アクション名';"
    execute "COMMENT ON COLUMN access_logs.remote_host IS 'クライアントのホスト名';"
    execute "COMMENT ON COLUMN access_logs.params IS 'パラメータ';"
    
  end
end
