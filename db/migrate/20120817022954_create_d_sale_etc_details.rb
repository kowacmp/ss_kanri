# -*- coding:utf-8 -*-
class CreateDSaleEtcDetails < ActiveRecord::Migration
  def change
    create_table :d_sale_etc_details do |t|
      t.integer :d_sale_etc_id ,:null => false
      t.integer :m_etc_id      ,:null => false
      t.integer :etc_no        ,:null => false,:limit   => 2
      t.integer :meter                        ,:default => 0
      t.integer :error_money                  ,:default => 0
      t.string  :error_note                   ,:limit   => 200
      t.integer :created_user_id,:null => false
      t.integer :updated_user_id,:null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_sale_etc_details.d_sale_etc_id IS '他売上データid';
             COMMENT ON COLUMN d_sale_etc_details.m_etc_id IS '他売上id';
             COMMENT ON COLUMN d_sale_etc_details.etc_no IS '他売上No';
             COMMENT ON COLUMN d_sale_etc_details.meter IS '当日メーター';
             COMMENT ON COLUMN d_sale_etc_details.error_money IS '誤差金額';
             COMMENT ON COLUMN d_sale_etc_details.error_note IS '誤差内容';
             COMMENT ON COLUMN d_sale_etc_details.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_sale_etc_details.updated_user_id IS '更新者id';
    "  
  end
end
