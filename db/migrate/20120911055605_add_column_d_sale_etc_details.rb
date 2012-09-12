#coding: utf-8
class AddColumnDSaleEtcDetails < ActiveRecord::Migration
  def up
    add_column :d_sale_etc_details, :price, :integer
    execute "COMMENT ON COLUMN d_sale_etc_details.price IS '単価'" 
  end

  def down
    remove_column :d_sale_etc_details, :price, :integer
  end
end
