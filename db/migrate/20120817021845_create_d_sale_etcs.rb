# -*- coding:utf-8 -*-
class CreateDSaleEtcs < ActiveRecord::Migration
  def change
    create_table :d_sale_etcs do |t|
      t.string :sale_date,       :null => false,:default => '00000000',:limit => 8
      t.integer :m_shop_id,      :null => false,:default => 0
      t.integer :kakutei_flg,    :null => false,:default => 0,:limit => 2
      t.integer :created_user_id,:null => false,:default => 0
      t.integer :updated_user_id,:null => false,:default => 0

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_sale_etcs.sale_date IS '売上日';
             COMMENT ON COLUMN d_sale_etcs.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_sale_etcs.kakutei_flg IS '確定フラグ';
             COMMENT ON COLUMN d_sale_etcs.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_sale_etcs.updated_user_id IS '更新者id';
    "
  end
end
