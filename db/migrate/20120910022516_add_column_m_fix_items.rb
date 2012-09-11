# -*- coding:utf-8 -*-
class AddColumnMFixItems < ActiveRecord::Migration
  def up
    add_column :m_fix_items, :fix_item_ryaku,    :string, :limit => 10
    execute "COMMENT ON COLUMN m_fix_items.fix_item_ryaku IS '固定額内訳略称'"
  end

  def down
    remove_column :m_fix_items, :fix_item_ryaku
  end
end
