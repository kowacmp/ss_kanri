# -*- coding:utf-8 -*-
class DResults < ActiveRecord::Migration
  def change
    create_table :d_results do |t|
      t.string   :result_date,     :null => false, :limit => 8
      t.integer  :m_shop_id,       :null => false
      t.column   :kakutei_flg,     :smallint,  :null => false
      t.integer  :create_user_id,  :null => false
      t.integer  :update_user_id,  :null => false
      
      t.timestamps             
    end
    
    execute "COMMENT ON COLUMN d_results.result_date IS '実績日';
             COMMENT ON COLUMN d_results.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_results.kakutei_flg IS '確定フラグ';
             COMMENT ON COLUMN d_results.create_user_id IS '作成者id';
             COMMENT ON COLUMN d_results.update_user_id IS '更新者id';
    "          
  end
end
