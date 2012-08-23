# -*- coding:utf-8 -*-
class CreateDWashsaleReports < ActiveRecord::Migration
  def change
    create_table :d_washsale_reports do |t|
      t.string :sale_date       ,:null => false,:default => '000000',:limit => 6
      t.integer :m_shop_id      ,:null => false,:default => 0
      t.integer :kakutei_flg    ,:null => false,:default => 0,:limit => 1
      t.integer :created_user_id,:null => false,:default => 0
      t.integer :updated_user_id,:null => false,:default => 0

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_washsale_reports.sale_date IS '売上日';
             COMMENT ON COLUMN d_washsale_reports.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_washsale_reports.kakutei_flg IS '確定フラグ';
             COMMENT ON COLUMN d_washsale_reports.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_washsale_reports.updated_user_id IS '更新者id';
    "
  end
end
