# -*- coding:utf-8 -*-
class AddColumnMShops4 < ActiveRecord::Migration
  def up
    add_column :m_shops, :open_day, :string, :limit => 8
    add_column :m_shops, :add_ym, :string, :limit => 6

    execute "COMMENT ON COLUMN m_shops.open_day IS '開店日';"
    execute "COMMENT ON COLUMN m_shops.add_ym IS '洗車プリカ起算年月';"
  end

  def down
    remove_column :m_shops, :open_day
    remove_column :m_shops, :add_ym
  end
end
