# -*- coding:utf-8 -*-
class AddColumnDPriceChecks < ActiveRecord::Migration
  def up
    add_column :d_price_checks, :minus_name4 , :string, :limit => 10
    
    execute "COMMENT ON COLUMN d_price_checks.minus_name4 IS 'マイナス名称4';"
  end

  def down
  end
end
