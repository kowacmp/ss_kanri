# -*- coding:utf-8 -*-
class AddColumnMItems < ActiveRecord::Migration
  def up
    add_column :m_items, :item_kana, :string, :limit => 10

    execute "COMMENT ON COLUMN m_items.item_kana IS '内訳カナ';"

  end

  def down
  end
end
