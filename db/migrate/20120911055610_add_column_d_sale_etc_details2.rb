# -*- coding:utf-8 -*-
class AddColumnDSaleEtcDetails2 < ActiveRecord::Migration
  def up
    remove_column :d_sale_etc_details, :price
    add_column    :d_sale_etc_details, :uriage, :integer
    execute "COMMENT ON COLUMN d_sale_etc_details.uriage IS '売上'" 
  end

  def down
    remove_column :d_sale_etc_details, :uriage
    add_column    :d_sale_etc_details, :price,  :integer
    execute "COMMENT ON COLUMN d_sale_etc_details.price IS '単価'"
  end
end
