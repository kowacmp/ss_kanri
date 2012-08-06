# -*- coding:utf-8 -*-
class AddColumnMenus < ActiveRecord::Migration
  def up
    add_column :menus, :messege_send, :smallint

    execute "COMMENT ON COLUMN menus.messege_send IS 'メッセージ種別  0:送信無　1:承認　2:回覧'"
  end

  def down
    remove_column :menus, :messege_send
  end
end
