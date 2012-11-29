# -*- coding:utf-8 -*-
class AddColumnDPriceChecks2 < ActiveRecord::Migration
  def up
    rename_column :d_price_checks, :minus_name4, :minus_name5
    add_column    :d_price_checks, :minus_name4, :string, :limit => 10
    add_column    :d_price_checks, :minus_gak4,  :decimal, :precision => 3, :scale => 1, :default => 0
    
    execute "COMMENT ON COLUMN d_price_checks.minus_name5 IS '予備';"
    execute "COMMENT ON COLUMN d_price_checks.minus_name4 IS 'マイナス名称4　プリカ(灯油)';"
    execute "COMMENT ON COLUMN d_price_checks.minus_gak4  IS 'マイナス金額4';"
    
  end

  def down
    remove_column :d_price_checks, :minus_name4
    remove_column :d_price_checks, :minus_gak4
    rename_column :d_price_checks, :minus_name5, :minus_name4 
    
    execute "COMMENT ON COLUMN d_price_checks.minus_name4 IS '予備';"
  end
end
