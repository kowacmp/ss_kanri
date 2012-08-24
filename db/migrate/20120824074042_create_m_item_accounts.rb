# -*- coding:utf-8 -*-
class CreateMItemAccounts < ActiveRecord::Migration
  def change
    create_table :m_item_accounts do |t|
      t.integer :item_account_code, :limit => 4,   :null => false
      t.string :item_account_name,  :limit => 20,  :null => false
      t.string :outline,            :limit => 100

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_item_accounts.item_account_code IS '勘定科目コード';
             COMMENT ON COLUMN m_item_accounts.item_account_name IS '勘定科目名称';
             COMMENT ON COLUMN m_item_accounts.outline IS '摘要';
    "
    
  end
end
