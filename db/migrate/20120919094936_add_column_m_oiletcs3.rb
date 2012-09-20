# -*- coding:utf-8 -*-
class AddColumnMOiletcs3 < ActiveRecord::Migration
  def up
    add_column :m_oiletcs, :shop_kbn, :smallint
    execute "COMMENT ON COLUMN m_oiletcs.shop_kbn IS '店舗種別'" 
  end

  def down
    remove_column :m_oiletcs, :shop_kbn
  end
end
