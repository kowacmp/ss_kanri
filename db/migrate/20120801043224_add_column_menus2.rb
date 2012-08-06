# -*- coding:utf-8 -*-
class AddColumnMenus2 < ActiveRecord::Migration
  def up
    add_column :menus, :menu_cd3, :smallint
    rename_column :menus, :parent_menu_id, :menu_cd1    
    rename_column :menus, :display_order, :menu_cd2
    
    execute "COMMENT ON COLUMN menus.menu_cd1 IS 'メニューコード１'"    
    execute "COMMENT ON COLUMN menus.menu_cd2 IS 'メニューコード２'"    
    execute "COMMENT ON COLUMN menus.menu_cd3 IS 'メニューコード３'"    
  end

  def down
    remove_column :menus, :menu_cd3    
  end
end
