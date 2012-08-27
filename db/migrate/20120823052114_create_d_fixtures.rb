# -*- coding:utf-8 -*-
class CreateDFixtures < ActiveRecord::Migration
  def change
    create_table :d_fixtures do |t|
      t.string :application_date,:null => false              ,:limit => 8
      t.integer :m_shop_id      ,:null => false,:default => 0
      t.string :buy_shop        ,:null => false              ,:limit => 50
      t.string :buy_item        ,:null => false              ,:limit => 100
      t.integer :buy_num        ,:null => false,:default => 0
      t.integer :buy_price      ,:null => false,:default => 0
      t.string :buy_object                                   ,:limit => 100
      t.integer :now_num                       ,:default => 0
      t.string :buy_day                                      ,:limit => 8
      t.string :comment                                      ,:limit => 100
      t.integer :approve_flg                   ,:default => 0,:limit => 1
      t.integer :approve_id1                   ,:default => 0
      t.string :approve_date1                               ,:limit => 8
      t.integer :created_user_id,:null => false,:default => 0
      t.integer :updated_user_id,:null => false,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_fixtures.application_date IS '申請日';
             COMMENT ON COLUMN d_fixtures.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_fixtures.buy_shop IS '購入先';
             COMMENT ON COLUMN d_fixtures.buy_item IS '購入品目';
             COMMENT ON COLUMN d_fixtures.buy_num IS '個数';
             COMMENT ON COLUMN d_fixtures.buy_price IS '単価';
             COMMENT ON COLUMN d_fixtures.buy_object IS '購入目的';
             COMMENT ON COLUMN d_fixtures.now_num IS '現在庫';
             COMMENT ON COLUMN d_fixtures.buy_day IS '購入日';
             COMMENT ON COLUMN d_fixtures.comment IS 'コメント';
             COMMENT ON COLUMN d_fixtures.approve_flg IS '承認フラグ';
             COMMENT ON COLUMN d_fixtures.approve_id1 IS '承認者id1';
             COMMENT ON COLUMN d_fixtures.approve_date1 IS '承認日1';
             COMMENT ON COLUMN d_fixtures.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_fixtures.updated_user_id IS '更新者id';
    "  
  end
end
