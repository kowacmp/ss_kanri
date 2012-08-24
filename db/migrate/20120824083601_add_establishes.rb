# -*- coding:utf-8 -*-
class AddEstablishes < ActiveRecord::Migration
  def up
    add_column :establishes, :system_name, :string,:limit => 255
    execute "COMMENT ON COLUMN establishes.system_name IS 'システム名'"
    
    add_column :establishes, :tax_rate, :decimal, :precision => 5,  :scale => 2,  :null => false
    execute "COMMENT ON COLUMN establishes.tax_rate IS '消費税率'"
    
    add_column :establishes, :limit, :decimal, :precision => 3,  :scale => 0,  :null => false
    execute "COMMENT ON COLUMN establishes.limit IS '制限範囲'"
    
    
    change_column :establishes, :name,     :string, :limit => 255
    change_column :establishes, :zip_cd,   :string, :limit => 8
    change_column :establishes, :address,  :string, :limit => 255
    
    execute "COMMENT ON COLUMN establishes.name IS '会社名';
             COMMENT ON COLUMN establishes.zip_cd IS '郵便番号';
             COMMENT ON COLUMN establishes.address IS '住所';
    "
  end

  def down
    remove_column :establishes, :system_name
    remove_column :establishes, :tax_rate
    remove_column :establishes, :limit
  end
end
