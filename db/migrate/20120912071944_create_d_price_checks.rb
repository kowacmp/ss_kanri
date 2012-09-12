# -*- coding:utf-8 -*-
class CreateDPriceChecks < ActiveRecord::Migration
  def change
    create_table :d_price_checks do |t|
      t.integer :m_shop_id,:null => false
      t.string  :research_day,:default => '00000000',:null => false ,:limit => 8
      t.integer :research_time,:default => 0,:null => false ,:limit => 2
      t.integer :normal_dis   ,:default => 0,:limit => 2
      t.integer :bargain_dis  ,:default => 0,:limit => 2
      t.integer :hg_price1    ,:default => 0,:limit => 4
      t.integer :rg_price1    ,:default => 0,:limit => 4
      t.integer :kg_price1    ,:default => 0,:limit => 4
      t.integer :tg_price1    ,:default => 0,:limit => 4
      t.integer :hg_price2    ,:default => 0,:limit => 4
      t.integer :rg_price2    ,:default => 0,:limit => 4
      t.integer :kg_price2    ,:default => 0,:limit => 4
      t.integer :tg_price2    ,:default => 0,:limit => 4
      t.integer :hg_price3    ,:default => 0,:limit => 4
      t.integer :rg_price3    ,:default => 0,:limit => 4
      t.integer :kg_price3    ,:default => 0,:limit => 4
      t.integer :tg_price3    ,:default => 0,:limit => 4
      t.integer :hg_price4    ,:default => 0,:limit => 4
      t.integer :rg_price4    ,:default => 0,:limit => 4
      t.integer :kg_price4    ,:default => 0,:limit => 4
      t.integer :tg_price4    ,:default => 0,:limit => 4
      t.integer :hg_price5    ,:default => 0,:limit => 4
      t.integer :rg_price5    ,:default => 0,:limit => 4
      t.integer :kg_price5    ,:default => 0,:limit => 4
      t.integer :tg_price5    ,:default => 0,:limit => 4
      t.integer :hg_price6    ,:default => 0,:limit => 4
      t.integer :rg_price6    ,:default => 0,:limit => 4
      t.integer :kg_price6    ,:default => 0,:limit => 4
      t.integer :tg_price6    ,:default => 0,:limit => 4

      t.integer :created_user_id,:default => 0
      t.integer :updated_user_id,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_price_checks.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_price_checks.research_day IS '調査日';
             COMMENT ON COLUMN d_price_checks.research_time IS '調査時刻';
             COMMENT ON COLUMN d_price_checks.normal_dis IS 'パネル通常';
             COMMENT ON COLUMN d_price_checks.bargain_dis IS 'パネル特売';
             COMMENT ON COLUMN d_price_checks.hg_price1 IS 'ハイオク価格1';
             COMMENT ON COLUMN d_price_checks.rg_price1 IS 'レギュラー価格1';
             COMMENT ON COLUMN d_price_checks.kg_price1 IS '軽油価格1';
             COMMENT ON COLUMN d_price_checks.tg_price1 IS '灯油価格1';
             COMMENT ON COLUMN d_price_checks.hg_price2 IS 'ハイオク価格2';
             COMMENT ON COLUMN d_price_checks.rg_price2 IS 'レギュラー価格2';
             COMMENT ON COLUMN d_price_checks.kg_price2 IS '軽油価格2';
             COMMENT ON COLUMN d_price_checks.tg_price2 IS '灯油価格2';
             COMMENT ON COLUMN d_price_checks.hg_price3 IS 'ハイオク価格3';
             COMMENT ON COLUMN d_price_checks.rg_price3 IS 'レギュラー価格3';
             COMMENT ON COLUMN d_price_checks.kg_price3 IS '軽油価格3';
             COMMENT ON COLUMN d_price_checks.tg_price3 IS '灯油価格3';
             COMMENT ON COLUMN d_price_checks.hg_price4 IS 'ハイオク価格4';
             COMMENT ON COLUMN d_price_checks.rg_price4 IS 'レギュラー価格4';
             COMMENT ON COLUMN d_price_checks.kg_price4 IS '軽油価格4';
             COMMENT ON COLUMN d_price_checks.tg_price4 IS '灯油価格4';
             COMMENT ON COLUMN d_price_checks.hg_price5 IS 'ハイオク価格5';
             COMMENT ON COLUMN d_price_checks.rg_price5 IS 'レギュラー価格5';
             COMMENT ON COLUMN d_price_checks.kg_price5 IS '軽油価格5';
             COMMENT ON COLUMN d_price_checks.tg_price5 IS '灯油価格5';
             COMMENT ON COLUMN d_price_checks.hg_price6 IS 'ハイオク価格6';
             COMMENT ON COLUMN d_price_checks.rg_price6 IS 'レギュラー価格6';
             COMMENT ON COLUMN d_price_checks.kg_price6 IS '軽油価格6';
             COMMENT ON COLUMN d_price_checks.tg_price6 IS '灯油価格6';
             COMMENT ON COLUMN d_price_checks.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_price_checks.updated_user_id IS '更新者id';
    "
  end
end
