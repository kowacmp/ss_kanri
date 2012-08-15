# -*- coding:utf-8 -*-
class CreateDWashSales < ActiveRecord::Migration
  def change
    create_table :d_wash_sales do |t|
      t.string :sale_date,       :null => false,:default => '00000000',:limit => 8
      t.integer :m_shop_id,     :null => false,:default => 0
      t.integer :kakutei_flg,    :null => false,:default => 0,:limit => 2
      t.integer :created_user_id,:null => false,:default => 0
      t.integer :updated_user_id, :null => false,:default => 0

      t.timestamps
      
    end
    
    execute "COMMENT ON COLUMN d_wash_sales.sale_date IS '売上日';
             COMMENT ON COLUMN d_wash_sales.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_wash_sales.kakutei_flg IS '確定フラグ';
             COMMENT ON COLUMN d_wash_sales.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_wash_sales.updated_user_id IS '更新者id';
    "
  end
end
