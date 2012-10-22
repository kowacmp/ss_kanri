# -*- coding:utf-8 -*-
class CreateDPriceChecks3 < ActiveRecord::Migration
  def up
    # 既に作成済みのテーブルは破棄する
    execute "drop table d_price_checks"
    
    create_table :d_price_checks do |t|
      t.integer :m_shop_id,    :null => false
      t.string  :research_day, :null => false ,:limit => 8
      t.integer :research_time,:null => false ,:limit => 2
      
      t.string :dis1_name,   :limit => 5
      
      t.string :dis1_1_name, :limit => 10
      t.string :dis1_1_rg,   :limit => 10
      t.string :dis1_1_hg,   :limit => 10
      t.string :dis1_1_kg,   :limit => 10
      t.string :dis1_1_tg,   :limit => 10
      
      t.string  :dis1_2_name, :limit => 10
      t.integer :dis1_2_code
      t.string  :dis1_2_rg,   :limit => 10
      t.string  :dis1_2_hg,   :limit => 10
      t.string  :dis1_2_kg,   :limit => 10
      t.string  :dis1_2_tg,   :limit => 10
      
      t.string :dis1_3_name, :limit => 10
      t.string :dis1_3_rg,   :limit => 10
      t.string :dis1_3_hg,   :limit => 10
      t.string :dis1_3_kg,   :limit => 10
      t.string :dis1_3_tg,   :limit => 10
      
      t.decimal :dis1_4_rg, :precision => 4, :scale => 1
      t.decimal :dis1_4_hg, :precision => 4, :scale => 1
      t.decimal :dis1_4_kg, :precision => 4, :scale => 1
      t.decimal :dis1_4_tg, :precision => 4, :scale => 1
      
      t.string :dis2_name,   :limit => 10
      
      t.string :dis2_1_name, :limit => 10
      t.string :dis2_1_rg,   :limit => 10
      t.string :dis2_1_hg,   :limit => 10
      t.string :dis2_1_kg,   :limit => 10
      t.string :dis2_1_tg,   :limit => 10
      
      t.string  :dis2_2_name, :limit => 10
      t.integer :dis2_2_code
      t.string  :dis2_2_rg,   :limit => 10
      t.string  :dis2_2_hg,   :limit => 10
      t.string  :dis2_2_kg,   :limit => 10
      t.string  :dis2_2_tg,   :limit => 10
      
      t.string :dis2_3_name, :limit => 10
      t.string :dis2_3_rg,   :limit => 10
      t.string :dis2_3_hg,   :limit => 10
      t.string :dis2_3_kg,   :limit => 10
      t.string :dis2_3_tg,   :limit => 10
      
      t.string  :minus_name1, :limit => 10
      t.integer :minus_gak1,  :default => 0 
      
      t.string  :minus_name2, :limit => 10
      t.integer :minus_gak2,  :default => 0 
      
      t.string  :minus_name3, :limit => 10
      t.integer :minus_gak3,  :default => 0 
      
      t.string  :game, :limit => 3

      t.integer :created_user_id,:default => 0
      t.integer :updated_user_id,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_price_checks.m_shop_id     IS '店舗id';
             COMMENT ON COLUMN d_price_checks.research_day  IS '調査日';
             COMMENT ON COLUMN d_price_checks.research_time IS '調査時刻';
             
             COMMENT ON COLUMN d_price_checks.dis1_name IS '表示名称1(例:通常時)';
             
             COMMENT ON COLUMN d_price_checks.dis1_1_name IS '表示名称1_1(例:サインポール)';
             COMMENT ON COLUMN d_price_checks.dis1_1_rg   IS '表示名称1_1レギュラー';
             COMMENT ON COLUMN d_price_checks.dis1_1_hg   IS '表示名称1_1ハイオク';
             COMMENT ON COLUMN d_price_checks.dis1_1_kg   IS '表示名称1_1軽油';
             COMMENT ON COLUMN d_price_checks.dis1_1_tg   IS '表示名称1_1灯油';
             
             COMMENT ON COLUMN d_price_checks.dis1_2_name IS '表示名称1_2(例:下看)';
             COMMENT ON COLUMN d_price_checks.dis1_2_code IS '表示名称1_2コード(例:割チケ)';
             COMMENT ON COLUMN d_price_checks.dis1_2_rg   IS '表示名称1_2レギュラー';
             COMMENT ON COLUMN d_price_checks.dis1_2_hg   IS '表示名称1_2ハイオク';
             COMMENT ON COLUMN d_price_checks.dis1_2_kg   IS '表示名称1_2軽油';
             COMMENT ON COLUMN d_price_checks.dis1_2_tg   IS '表示名称1_2灯油';
             
             COMMENT ON COLUMN d_price_checks.dis1_3_name IS '表示名称1_3(例:通常価格)';
             COMMENT ON COLUMN d_price_checks.dis1_3_rg   IS '表示名称1_3レギュラー';
             COMMENT ON COLUMN d_price_checks.dis1_3_hg   IS '表示名称1_3ハイオク';
             COMMENT ON COLUMN d_price_checks.dis1_3_kg   IS '表示名称1_3軽油';
             COMMENT ON COLUMN d_price_checks.dis1_3_tg   IS '表示名称1_3灯油';
             
             COMMENT ON COLUMN d_price_checks.dis1_4_rg   IS '表示名称1_4レギュラー税抜';
             COMMENT ON COLUMN d_price_checks.dis1_4_hg   IS '表示名称1_4ハイオク税抜';
             COMMENT ON COLUMN d_price_checks.dis1_4_kg   IS '表示名称1_4軽油税抜';
             COMMENT ON COLUMN d_price_checks.dis1_4_tg   IS '表示名称1_4灯油税抜';
             
             COMMENT ON COLUMN d_price_checks.dis2_name IS '表示名称2(例:特売日)';
             
             COMMENT ON COLUMN d_price_checks.dis2_1_name IS '表示名称2_1(例:サインポール)';
             COMMENT ON COLUMN d_price_checks.dis2_1_rg   IS '表示名称2_1レギュラー';
             COMMENT ON COLUMN d_price_checks.dis2_1_hg   IS '表示名称2_1ハイオク';
             COMMENT ON COLUMN d_price_checks.dis2_1_kg   IS '表示名称2_1軽油';
             COMMENT ON COLUMN d_price_checks.dis2_1_tg   IS '表示名称2_1灯油';
             
             COMMENT ON COLUMN d_price_checks.dis2_2_name IS '表示名称2_2(例:下看)';
             COMMENT ON COLUMN d_price_checks.dis2_2_code IS '表示名称2_2コード(例:割チケ)';
             COMMENT ON COLUMN d_price_checks.dis2_2_rg   IS '表示名称2_2レギュラー';
             COMMENT ON COLUMN d_price_checks.dis2_2_hg   IS '表示名称2_2ハイオク';
             COMMENT ON COLUMN d_price_checks.dis2_2_kg   IS '表示名称2_2軽油';
             COMMENT ON COLUMN d_price_checks.dis2_2_tg   IS '表示名称2_2灯油';
             
             COMMENT ON COLUMN d_price_checks.dis2_3_name IS '表示名称2_3(例:通常価格)';
             COMMENT ON COLUMN d_price_checks.dis2_3_rg   IS '表示名称2_3レギュラー';
             COMMENT ON COLUMN d_price_checks.dis2_3_hg   IS '表示名称2_3ハイオク';
             COMMENT ON COLUMN d_price_checks.dis2_3_kg   IS '表示名称2_3軽油';
             COMMENT ON COLUMN d_price_checks.dis2_3_tg   IS '表示名称2_3灯油';
             
             COMMENT ON COLUMN d_price_checks.minus_name1   IS 'マイナス名称1';
             COMMENT ON COLUMN d_price_checks.minus_gak1    IS 'マイナス金額1';
             
             COMMENT ON COLUMN d_price_checks.minus_name2   IS 'マイナス名称2';
             COMMENT ON COLUMN d_price_checks.minus_gak2    IS 'マイナス金額2';
             
             COMMENT ON COLUMN d_price_checks.minus_name3   IS 'マイナス名称3';
             COMMENT ON COLUMN d_price_checks.minus_gak3    IS 'マイナス金額3';
             
             COMMENT ON COLUMN d_price_checks.game    IS 'ゲーム確率';
             
             COMMENT ON COLUMN d_price_checks.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_price_checks.updated_user_id IS '更新者id';
    "
  end

  def down
  end
end
