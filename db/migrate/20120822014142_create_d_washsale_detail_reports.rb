# -*- coding:utf-8 -*-
class CreateDWashsaleDetailReports < ActiveRecord::Migration
  def change
    create_table :d_washsale_detail_reports do |t|
      t.integer :d_washsale_report_id,:default => 0,:null => false
      t.integer :m_wash_id           ,:default => 0,:null => false
      t.integer :wash_no             ,:default => 0,:null => false,:limit => 2
      t.integer :meter               ,:default => 0
      t.integer :sale_meter          ,:default => 0
      t.integer :created_user_id     ,:default => 0,:null => false
      t.integer :updated_user_id     ,:default => 0,:null => false

      t.timestamps
    end
    execute "COMMENT ON COLUMN d_washsale_detail_reports.d_washsale_report_id IS '洗車売上id';
             COMMENT ON COLUMN d_washsale_detail_reports.m_wash_id IS '洗車機id';
             COMMENT ON COLUMN d_washsale_detail_reports.wash_no IS '洗車機No';
             COMMENT ON COLUMN d_washsale_detail_reports.meter IS 'メーター';
             COMMENT ON COLUMN d_washsale_detail_reports.sale_meter IS '月間メーター';
             COMMENT ON COLUMN d_washsale_detail_reports.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_washsale_detail_reports.updated_user_id IS '更新者id';
    "  
  end
end
