# -*- coding:utf-8 -*-
class ChangeMFixMoneys < ActiveRecord::Migration
  
  def change
    execute "DROP TABLE m_fix_moneys;"    
    
    create_table :m_fix_moneys do |t|
      t.integer :m_shop_id,         :null => false
      t.integer :start_month,       :null => false
      t.integer :end_month,         :null => false
      t.integer :m_fix_item_id1
      t.integer :fix_money1
      t.integer :m_fix_item_id2
      t.integer :fix_money2
      t.integer :m_fix_item_id3
      t.integer :fix_money3
      t.integer :m_fix_item_id4
      t.integer :fix_money4
      t.integer :m_fix_item_id5
      t.integer :fix_money5
      t.integer :m_fix_item_id6
      t.integer :fix_money6
      t.integer :m_fix_item_id7
      t.integer :fix_money7
      t.integer :m_fix_item_id8
      t.integer :fix_money8
      t.integer :m_fix_item_id9
      t.integer :fix_money9
      t.integer :m_fix_item_id10
      t.integer :fix_money10
      t.integer :m_fix_item_id11
      t.integer :fix_money11
      t.integer :m_fix_item_id12
      t.integer :fix_money12
      t.integer :m_fix_item_id13
      t.integer :fix_money13

      t.integer :total_cash_box
      t.integer :total_change_money
      t.integer :total_money
      t.column  :deleted_flg,            :smallint, :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_fix_moneys.m_shop_id IS '店舗id';
             COMMENT ON COLUMN m_fix_moneys.start_month IS '開始月';
             COMMENT ON COLUMN m_fix_moneys.end_month IS '終了月';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id1 IS '固定額内訳id1';
             COMMENT ON COLUMN m_fix_moneys.fix_money1 IS '固定額内訳額1';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id2 IS '固定額内訳id2';
             COMMENT ON COLUMN m_fix_moneys.fix_money2 IS '固定額内訳額2';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id3 IS '固定額内訳id3';
             COMMENT ON COLUMN m_fix_moneys.fix_money3 IS '固定額内訳額3';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id4 IS '固定額内訳id4';
             COMMENT ON COLUMN m_fix_moneys.fix_money4 IS '固定額内訳額4';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id5 IS '固定額内訳id5';
             COMMENT ON COLUMN m_fix_moneys.fix_money5 IS '固定額内訳額5';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id6 IS '固定額内訳id6';
             COMMENT ON COLUMN m_fix_moneys.fix_money6 IS '固定額内訳額6';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id7 IS '固定額内訳id7';
             COMMENT ON COLUMN m_fix_moneys.fix_money7 IS '固定額内訳額7';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id8 IS '固定額内訳id8';
             COMMENT ON COLUMN m_fix_moneys.fix_money8 IS '固定額内訳額8';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id9 IS '固定額内訳id9';
             COMMENT ON COLUMN m_fix_moneys.fix_money9 IS '固定額内訳額9';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id10 IS '固定額内訳id10';
             COMMENT ON COLUMN m_fix_moneys.fix_money10 IS '固定額内訳額10';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id11 IS '固定額内訳id11';
             COMMENT ON COLUMN m_fix_moneys.fix_money11 IS '固定額内訳額11';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id12 IS '固定額内訳id12';
             COMMENT ON COLUMN m_fix_moneys.fix_money12 IS '固定額内訳額12';
             COMMENT ON COLUMN m_fix_moneys.m_fix_item_id13 IS '固定額内訳id13';
             COMMENT ON COLUMN m_fix_moneys.fix_money13 IS '固定額内訳額13';
             
             COMMENT ON COLUMN m_fix_moneys.total_cash_box IS '金庫合計';
             COMMENT ON COLUMN m_fix_moneys.total_change_money IS '釣銭機合計';
             COMMENT ON COLUMN m_fix_moneys.total_money IS '釣銭合計';
             COMMENT ON COLUMN m_fix_moneys.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_fix_moneys.deleted_at IS '削除日時';
    "        
  end
  
end
