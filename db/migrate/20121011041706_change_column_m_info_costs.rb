# -*- coding:utf-8 -*-
class ChangeColumnMInfoCosts < ActiveRecord::Migration
  def up
    execute "ALTER TABLE m_info_costs RENAME night_pay to skill_pay;"
    
    execute "COMMENT ON COLUMN m_info_costs.skill_pay IS '能力給';"
  end

  def down
  end
end
