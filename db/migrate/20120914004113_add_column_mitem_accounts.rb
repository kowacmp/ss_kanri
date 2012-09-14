# -*- coding:utf-8 -*-
class AddColumnMitemAccounts < ActiveRecord::Migration
  def up
    add_column :m_item_accounts, :item_account_class, :integer
    execute "COMMENT ON COLUMN m_item_accounts.item_account_class IS '勘定種別'"
  end

  def down
    remove_column :m_item_accounts, :item_account_class
  end
end
