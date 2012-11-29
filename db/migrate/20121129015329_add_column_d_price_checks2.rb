# -*- coding:utf-8 -*-
class AddColumnDPriceChecks2 < ActiveRecord::Migration
  def up
    rename_column :d_price_checks, :minus_name4, :minus_name6
    add_column    :d_price_checks, :minus_gak4,  :decimal, :precision => 3, :scale => 1, :default => 0
    add_column    :d_price_checks, :minus_gak5,  :decimal, :precision => 3, :scale => 1, :default => 0
    
    execute "COMMENT ON COLUMN d_price_checks.minus_name6 IS '備考';"
    execute "COMMENT ON COLUMN d_price_checks.minus_gak4  IS 'マイナス金額4　プリカ(灯油)';"
    execute "COMMENT ON COLUMN d_price_checks.minus_gak5  IS 'マイナス金額5　会員(灯油)';"
    
  end

  def down
    remove_column :d_price_checks, :minus_gak4
    remove_column :d_price_checks, :minus_gak5
    rename_column :d_price_checks, :minus_name6, :minus_name4 
    
    execute "COMMENT ON COLUMN d_price_checks.minus_name4 IS '予備';"
  end
end
