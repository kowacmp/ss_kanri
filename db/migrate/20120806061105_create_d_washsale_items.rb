# -*- coding:utf-8 -*-
class CreateDWashsaleItems < ActiveRecord::Migration
  def change
    create_table :d_washsale_items do |t|
      t.integer :d_wash_sale_id ,:null => false
      t.integer :m_wash_id      ,:null => false
      t.integer :wash_no        ,:null => false,:limit => 2
      t.integer :meter                         ,:default => 0
      t.integer :error_money                   ,:default => 0
      t.string  :error_note                    ,:limit => 200
      t.integer :created_user_id,:null => false
      t.integer :updated_user_id ,:null => false

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_washsale_items.d_wash_sale_id IS '洗車売上id';
             COMMENT ON COLUMN d_washsale_items.m_wash_id IS '洗車機id';
             COMMENT ON COLUMN d_washsale_items.wash_no IS '洗車機No';
             COMMENT ON COLUMN d_washsale_items.meter IS '当日メーター';
             COMMENT ON COLUMN d_washsale_items.error_money IS '誤差金額';
             COMMENT ON COLUMN d_washsale_items.error_note IS '誤差内容';
             COMMENT ON COLUMN d_washsale_items.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_washsale_items.updated_user_id IS '更新者id';
    "  
  end
end
