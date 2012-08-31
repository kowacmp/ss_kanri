# -*- coding:utf-8 -*-
class AddMOilEtcs < ActiveRecord::Migration
  def up
    add_column :m_oiletcs, :tax_flg, :smallint, :null => false, :default => 0
    execute "COMMENT ON COLUMN m_oiletcs.tax_flg IS '課税フラグ　0:非課税　1:課税'"
    
    change_column :m_oiletcs, :oiletc_cd,     :smallint,  :null => false,:limit => 2
    change_column :m_oiletcs, :oiletc_name,   :string,    :null => false,:limit => 20
    change_column :m_oiletcs, :oiletc_ryaku,  :string,    :null => false,:limit => 10
    change_column :m_oiletcs, :oiletc_tani,   :string,    :null => false,:limit => 10
    change_column :m_oiletcs, :oiletc_group,  :smallint,  :null => false,:limit => 1
    change_column :m_oiletcs, :deleted_flg,:smallint,  :null => false,:limit => 1, :default => 0
    
    execute "COMMENT ON COLUMN m_oiletcs.oiletc_cd IS '油外コード';
             COMMENT ON COLUMN m_oiletcs.oiletc_name IS '油外名';
             COMMENT ON COLUMN m_oiletcs.oiletc_ryaku IS '油外略称';
             COMMENT ON COLUMN m_oiletcs.oiletc_tani IS '単位';
             COMMENT ON COLUMN m_oiletcs.oiletc_group IS 'グループ種類';
             COMMENT ON COLUMN m_oiletcs.deleted_flg IS '削除フラグ　0:通常　1:削除';
             COMMENT ON COLUMN m_oiletcs.deleted_at IS '削除日時';
    "
  end

  def down
    remove_column :m_oiletcs, :tax_flg
  end
end
