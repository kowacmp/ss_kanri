# -*- coding:utf-8 -*-
class CreateMFixMoneys < ActiveRecord::Migration
  def change
    create_table :m_fix_moneys do |t|
      t.integer :m_shop_id,         :null => false
      t.integer :start_month,       :null => false
      t.integer :end_month,         :null => false
      t.integer :cash_box
      t.integer :pos_register
      t.integer :part_time
      t.integer :wash_money
      t.integer :money_change
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
             COMMENT ON COLUMN m_fix_moneys.cash_box IS '金庫';
             COMMENT ON COLUMN m_fix_moneys.pos_register IS 'POSレジ';
             COMMENT ON COLUMN m_fix_moneys.part_time IS 'バイト用';
             COMMENT ON COLUMN m_fix_moneys.wash_money IS '洗車機釣銭';
             COMMENT ON COLUMN m_fix_moneys.money_change IS '両替機';
             COMMENT ON COLUMN m_fix_moneys.total_cash_box IS '金庫合計';
             COMMENT ON COLUMN m_fix_moneys.total_change_money IS '釣銭機合計';
             COMMENT ON COLUMN m_fix_moneys.total_money IS '釣銭合計';
             COMMENT ON COLUMN m_fix_moneys.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN m_fix_moneys.deleted_at IS '削除日時';
    "
    
  end
end
