# -*- coding:utf-8 -*-
class AddMInfoCosts < ActiveRecord::Migration
  def up
    add_column :m_info_costs, :etc_pay5,        :integer
    add_column :m_info_costs, :etc_pay6,        :integer
    
    change_column :m_info_costs, :users_id,     :integer,:null => false
    change_column :m_info_costs, :base_pay,     :integer
    change_column :m_info_costs, :night_pay,    :integer
    change_column :m_info_costs, :welfare_pay,  :integer
    change_column :m_info_costs, :etc_pay1,     :integer
    change_column :m_info_costs, :etc_pay2,     :integer
    change_column :m_info_costs, :etc_pay3,     :integer
    change_column :m_info_costs, :etc_pay4,     :integer
    change_column :m_info_costs, :deleted_flg,  :smallint,:null => false,:limit => 1, :default => 0
    
    rename_column :m_info_costs, :users_id, :user_id
    
    execute "COMMENT ON COLUMN m_info_costs.user_id IS 'ユーザID';
             COMMENT ON COLUMN m_info_costs.base_pay IS '基本給';
             COMMENT ON COLUMN m_info_costs.night_pay IS '深夜給';
             COMMENT ON COLUMN m_info_costs.welfare_pay IS '福利費';
             COMMENT ON COLUMN m_info_costs.etc_pay1 IS '手当1';
             COMMENT ON COLUMN m_info_costs.etc_pay2 IS '手当2';
             COMMENT ON COLUMN m_info_costs.etc_pay3 IS '手当3';
             COMMENT ON COLUMN m_info_costs.etc_pay4 IS '手当4';
             COMMENT ON COLUMN m_info_costs.etc_pay5 IS '手当5';
             COMMENT ON COLUMN m_info_costs.etc_pay6 IS '手当6';
             COMMENT ON COLUMN m_info_costs.deleted_flg IS '削除フラグ　0:通常　1:削除';
             COMMENT ON COLUMN m_info_costs.deleted_at IS '削除日時';
    "
    
    
  end

  def down
    remove_column :m_info_costs, :etc_pay5
    remove_column :m_info_costs, :etc_pay6
  end
end
