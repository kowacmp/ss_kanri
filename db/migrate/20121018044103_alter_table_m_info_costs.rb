# -*- coding:utf-8 -*-
class AlterTableMInfoCosts < ActiveRecord::Migration
  def up
    #テーブル削除して作成しなおす
    execute "drop table m_info_costs CASCADE;"
    
    create_table :m_info_costs do |t|
      t.integer :user_id
      t.integer :general_price
      t.integer :general_overtime
      t.integer :night_price
      t.integer :night_overtime
      t.integer :time_price1
      t.integer :time_price2
      t.integer :time_price3
      t.integer :time_price4
      t.integer :time_price5
      t.integer :time_price6
      t.integer :day_price1
      t.integer :day_price2
      t.integer :deleted_flg, :limit=>1, :default=>0
      t.timestamp :deleted_at

      t.timestamps
    end   

    execute "COMMENT ON COLUMN m_info_costs.user_id IS 'ユーザID';"
    execute "COMMENT ON COLUMN m_info_costs.general_price IS '社員：基本給　社員以外：通常単価';"
    execute "COMMENT ON COLUMN m_info_costs.general_overtime IS '通常残業（社員の場合は設定なし）';"
    execute "COMMENT ON COLUMN m_info_costs.night_price IS '深夜単価（社員の場合は設定なし）';"
    execute "COMMENT ON COLUMN m_info_costs.night_overtime IS '深夜残業（社員の場合は設定なし）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price1 IS '時間単価１（項目名称は、社員：monthly_name1　社員以外：m_cost_names.hour_name1から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price2 IS '時間単価２（項目名称は、社員：monthly_name2　社員以外：m_cost_names.hour_name2から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price3 IS '時間単価３（項目名称は、社員：monthly_name3　社員以外：m_cost_names.hour_name3から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price4 IS '時間単価４（項目名称は、社員：monthly_name4　社員以外：m_cost_names.hour_name4から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price5 IS '時間単価５（項目名称は、社員：monthly_name5　社員以外：m_cost_names.hour_name5から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.time_price6 IS '時間単価６（項目名称は、社員：monthly_name6　社員以外：m_cost_names.hour_name6から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.day_price1 IS '日数単価１（社員の場合は設定なし）（項目名称は、m_cost_names.day_name1から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.day_price2 IS '日数単価２（社員の場合は設定なし）（項目名称は、m_cost_names.day_name2から取得する）';"
    execute "COMMENT ON COLUMN m_info_costs.deleted_flg IS '削除フラグ（０：通常　１：削除）';"
     
  end

  def down
  end
end
