# -*- coding:utf-8 -*-
class CreateMCostNames < ActiveRecord::Migration
  def change
    create_table :m_cost_names do |t|
      t.integer :m_shop_id
      t.string :monthly_name1, :limit=>10
      t.string :monthly_name2, :limit=>10
      t.string :monthly_name3, :limit=>10
      t.string :monthly_name4, :limit=>10
      t.string :monthly_name5, :limit=>10
      t.string :monthly_name6, :limit=>10
      t.string :hour_name1, :limit=>10
      t.string :hour_name2, :limit=>10
      t.string :hour_name3, :limit=>10
      t.string :hour_name4, :limit=>10
      t.string :hour_name5, :limit=>10
      t.string :hour_name6, :limit=>10
      t.string :day_name1, :limit=>10
      t.string :day_name2, :limit=>10
      t.string :input_name1, :limit=>10
      t.string :input_name2, :limit=>10
      t.string :input_name3, :limit=>10
      t.string :input_name4, :limit=>10
      t.integer :deleted_flg, :limit=>1, :default=>0
      t.timestamp :deleted_at
      

      t.timestamps
    end
    
    #初期データを作成する
    execute "insert into m_cost_names(m_shop_id, monthly_name1, monthly_name2, monthly_name3, monthly_name4, monthly_name5, monthly_name6,
                                      hour_name1, hour_name2, hour_name3, hour_name4, hour_name5, hour_name6, day_name1, day_name2,
                                      input_name1, input_name2, input_name3, input_name4)
             select id 
                    ,'能力給','福利費','手当１','手当２','手当３','手当４'
                    ,'能力給','福利費','資格手当１','資格手当２','手当１','手当２'
                    ,'日数手当１','日数手当２'
                    ,'販売手当１','販売手当２','調整','月間手当'
             from m_shops
             where deleted_flg = 0;
    "
    
    execute "COMMENT ON COLUMN m_cost_names.m_shop_id IS '店舗ID';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name1 IS '月給項目１';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name2 IS '月給項目２';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name3 IS '月給項目３';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name4 IS '月給項目４';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name5 IS '月給項目５';"
    execute "COMMENT ON COLUMN m_cost_names.monthly_name6 IS '月給項目６';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name1 IS '時給項目１';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name2 IS '時給項目２';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name3 IS '時給項目３';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name4 IS '時給項目４';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name5 IS '時給項目５';"
    execute "COMMENT ON COLUMN m_cost_names.hour_name6 IS '時給項目６';"
    execute "COMMENT ON COLUMN m_cost_names.day_name1 IS '日給項目１';"
    execute "COMMENT ON COLUMN m_cost_names.day_name2 IS '日給項目２';"
    execute "COMMENT ON COLUMN m_cost_names.input_name1 IS '入力項目１';"
    execute "COMMENT ON COLUMN m_cost_names.input_name2 IS '入力項目２';"
    execute "COMMENT ON COLUMN m_cost_names.input_name3 IS '入力項目３';"
    execute "COMMENT ON COLUMN m_cost_names.input_name4 IS '入力項目４';"
    execute "COMMENT ON COLUMN m_cost_names.deleted_flg IS '削除フラグ（０：通常　１：削除）';"

    
  end
end
