# -*- coding:utf-8 -*-
class CreateDPriceCheckEtcs < ActiveRecord::Migration
  def change
    create_table :d_price_check_etcs do |t|
      t.integer :m_etc_shop_id,:null => false
      t.string  :research_day ,:limit => 8,:default => '00000000',:null => false
      t.integer :research_time,:limit => 2,:default => 0,:null => false
      t.string  :item1        ,:limit => 20
      t.integer :hg_price1    ,:limit => 4,:default => 0
      t.integer :rg_price1    ,:limit => 4,:default => 0
      t.integer :kg_price1    ,:limit => 4,:default => 0
      t.integer :tg_price1    ,:limit => 4,:default => 0
      t.string  :item2        ,:limit => 20
      t.integer :hg_price2    ,:limit => 4,:default => 0
      t.integer :rg_price2    ,:limit => 4,:default => 0
      t.integer :kg_price2    ,:limit => 4,:default => 0
      t.integer :tg_price2    ,:limit => 4,:default => 0      
      t.string  :item3        ,:limit => 20
      t.integer :hg_price3    ,:limit => 4,:default => 0
      t.integer :rg_price3    ,:limit => 4,:default => 0
      t.integer :kg_price3    ,:limit => 4,:default => 0
      t.integer :tg_price3    ,:limit => 4,:default => 0      
      t.string  :item4        ,:limit => 20
      t.integer :hg_price4    ,:limit => 4,:default => 0
      t.integer :rg_price4    ,:limit => 4,:default => 0
      t.integer :kg_price4    ,:limit => 4,:default => 0
      t.integer :tg_price4    ,:limit => 4,:default => 0
      t.string  :item5        ,:limit => 20
      t.integer :hg_price5    ,:limit => 4,:default => 0
      t.integer :rg_price5    ,:limit => 4,:default => 0
      t.integer :kg_price5    ,:limit => 4,:default => 0
      t.integer :tg_price5    ,:limit => 4,:default => 0      
      t.string  :item6        ,:limit => 20
      t.integer :hg_price6    ,:limit => 4,:default => 0
      t.integer :rg_price6    ,:limit => 4,:default => 0
      t.integer :kg_price6    ,:limit => 4,:default => 0
      t.integer :tg_price6    ,:limit => 4,:default => 0
      t.string  :note,:limit => 100
      t.integer :created_user_id,:default => 0
      t.integer :updated_user_id,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_price_check_etcs.m_etc_shop_id IS '他店舗id';
             COMMENT ON COLUMN d_price_check_etcs.research_day IS '調査日';
             COMMENT ON COLUMN d_price_check_etcs.research_time IS '調査時刻';
             COMMENT ON COLUMN d_price_check_etcs.item1 IS '項目1';
             COMMENT ON COLUMN d_price_check_etcs.hg_price1 IS 'ハイオク価格1';
             COMMENT ON COLUMN d_price_check_etcs.rg_price1 IS 'レギュラー価格1';
             COMMENT ON COLUMN d_price_check_etcs.kg_price1 IS '軽油価格1';
             COMMENT ON COLUMN d_price_check_etcs.tg_price1 IS '灯油価格1';
             COMMENT ON COLUMN d_price_check_etcs.item2 IS '項目2';
             COMMENT ON COLUMN d_price_check_etcs.hg_price2 IS 'ハイオク価格2';
             COMMENT ON COLUMN d_price_check_etcs.rg_price2 IS 'レギュラー価格2';
             COMMENT ON COLUMN d_price_check_etcs.kg_price2 IS '軽油価格2';
             COMMENT ON COLUMN d_price_check_etcs.tg_price2 IS '灯油価格2';
             COMMENT ON COLUMN d_price_check_etcs.item3 IS '項目3';
             COMMENT ON COLUMN d_price_check_etcs.hg_price3 IS 'ハイオク価格3';
             COMMENT ON COLUMN d_price_check_etcs.rg_price3 IS 'レギュラー価格3';
             COMMENT ON COLUMN d_price_check_etcs.kg_price3 IS '軽油価格3';
             COMMENT ON COLUMN d_price_check_etcs.tg_price3 IS '灯油価格3';
             COMMENT ON COLUMN d_price_check_etcs.item4 IS '項目4';
             COMMENT ON COLUMN d_price_check_etcs.hg_price4 IS 'ハイオク価格4';
             COMMENT ON COLUMN d_price_check_etcs.rg_price4 IS 'レギュラー価格4';
             COMMENT ON COLUMN d_price_check_etcs.kg_price4 IS '軽油価格4';
             COMMENT ON COLUMN d_price_check_etcs.tg_price4 IS '灯油価格4';
             COMMENT ON COLUMN d_price_check_etcs.item5 IS '項目5';
             COMMENT ON COLUMN d_price_check_etcs.hg_price5 IS 'ハイオク価格5';
             COMMENT ON COLUMN d_price_check_etcs.rg_price5 IS 'レギュラー価格5';
             COMMENT ON COLUMN d_price_check_etcs.kg_price5 IS '軽油価格5';
             COMMENT ON COLUMN d_price_check_etcs.tg_price5 IS '灯油価格5';             
             COMMENT ON COLUMN d_price_check_etcs.item6 IS '項目6';
             COMMENT ON COLUMN d_price_check_etcs.hg_price6 IS 'ハイオク価格6';
             COMMENT ON COLUMN d_price_check_etcs.rg_price6 IS 'レギュラー価格6';
             COMMENT ON COLUMN d_price_check_etcs.kg_price6 IS '軽油価格6';
             COMMENT ON COLUMN d_price_check_etcs.tg_price6 IS '灯油価格6';
             COMMENT ON COLUMN d_price_check_etcs.note IS '備考';
                          
             COMMENT ON COLUMN d_price_checks.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_price_checks.updated_user_id IS '更新者id';
    "
  end
end
