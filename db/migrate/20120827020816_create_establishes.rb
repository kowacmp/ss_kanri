# -*- coding:utf-8 -*-
class CreateEstablishes < ActiveRecord::Migration
  def change
    create_table :establishes do |t|
      t.string    :name,          :limit => 255
      t.string    :zip_cd,        :limit => 8
      t.string    :address,       :limit => 255
      t.string    :system_name,   :limit => 255
      t.column    :tax_rate,      :decimal, :precision => 5,  :scale => 2,  :null => false,  :default => 0
      t.column    :limit,         :decimal, :precision => 3,  :scale => 0,  :null => false,  :default => 0
      t.column    :deleted_flg,   :smallint,  :limit => 1,  :default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN establishes.name IS '会社名';
             COMMENT ON COLUMN establishes.zip_cd IS '郵便番号';
             COMMENT ON COLUMN establishes.address IS '住所';
             COMMENT ON COLUMN establishes.system_name IS 'システム名';
             COMMENT ON COLUMN establishes.tax_rate IS '消費税率';
             COMMENT ON COLUMN establishes.limit IS '制限範囲';
             COMMENT ON COLUMN establishes.deleted_flg IS '削除フラグ';
             COMMENT ON COLUMN establishes.deleted_at IS '削除日時';
    "
    
  end
end
