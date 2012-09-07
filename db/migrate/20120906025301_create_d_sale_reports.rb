# -*- coding:utf-8 -*-
class CreateDSaleReports < ActiveRecord::Migration
  def change
    create_table :d_sale_reports do |t|
      t.string :sale_date ,:limit => 6, :null => false
      t.integer :m_shop_id, :null => false
      t.integer :kakutei_flg, :limit => 1, :null => false
      t.integer :confirm_id
      t.date :confirm_date
      t.integer :approve_id1
      t.date :approve_date1
      t.integer :approve_id2
      t.date :approve_date2
      t.integer :approve_id3
      t.date :approve_date3
      t.integer :approve_id4
      t.date :approve_date4
      t.integer :approve_id5
      t.date :approve_date5
      
      t.timestamps
    end

    execute "COMMENT ON COLUMN d_sale_reports.sale_date IS '売上年月'"
    execute "COMMENT ON COLUMN d_sale_reports.m_shop_id IS '店舗id'"
    execute "COMMENT ON COLUMN d_sale_reports.kakutei_flg IS '確認フラグ 0.未確認 1.確認済'"
    execute "COMMENT ON COLUMN d_sale_reports.confirm_id IS '確認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.confirm_date IS '確認日'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_id1 IS '承認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_date1 IS '承認日'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_id2 IS '承認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_date2 IS '承認日'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_id3 IS '承認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_date3 IS '承認日'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_id4 IS '承認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_date4 IS '承認日'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_id5 IS '承認者id'"
    execute "COMMENT ON COLUMN d_sale_reports.approve_date5 IS '承認日'"
    
  end
end
