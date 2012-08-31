# -*- coding:utf-8 -*-
class AddMEtcs < ActiveRecord::Migration
  def up
    add_column :m_etcs, :tax_flg, :smallint, :null => false, :default => 0
    execute "COMMENT ON COLUMN m_etcs.tax_flg IS '課税フラグ　0:非課税　1:課税'"
    
    change_column :m_etcs, :etc_cd,     :smallint,  :null => false,:limit => 2
    change_column :m_etcs, :etc_name,   :string,    :null => false,:limit => 20
    change_column :m_etcs, :etc_ryaku,  :string,    :null => false,:limit => 10
    change_column :m_etcs, :etc_tani,   :string,    :null => false,:limit => 4
    change_column :m_etcs, :etc_group,  :smallint,  :null => false,:limit => 1
    change_column :m_etcs, :deleted_flg,:smallint,  :null => false,:limit => 1, :default => 0
    
    execute "COMMENT ON COLUMN m_etcs.etc_cd IS '他売上コード';
             COMMENT ON COLUMN m_etcs.etc_name IS '他売上名';
             COMMENT ON COLUMN m_etcs.etc_ryaku IS '他売上略称';
             COMMENT ON COLUMN m_etcs.etc_tani IS '単位';
             COMMENT ON COLUMN m_etcs.etc_group IS 'グループ種類';
             COMMENT ON COLUMN m_etcs.deleted_flg IS '削除フラグ　0:通常　1:削除';
             COMMENT ON COLUMN m_etcs.deleted_at IS '削除日時';
    "
    
  end

  def down
    remove_column :m_etcs, :tax_flg
  end
end
