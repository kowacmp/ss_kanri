# -*- coding:utf-8 -*-
class AddColumnToMenus < ActiveRecord::Migration
  def up
    add_column :menus, :permission_actions, :text
    execute "COMMENT ON COLUMN menus.permission_actions IS '利用できるアクションを設定 nullの場合は全てのアクションを利用できる';"
  end

  def down
    remove_column :menus, :actions
  end
end
