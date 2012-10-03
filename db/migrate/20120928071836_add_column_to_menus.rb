# -*- coding:utf-8 -*-
class AddColumnToMenus < ActiveRecord::Migration
  def up
    add_column :menus, :permission_actions, :text
    execute "COMMENT ON COLUMN menus.permission_actions IS '利用できるアクションを設定 nullの場合は全てのアクションを利用できる';"
    
    #初期セット
    execute "update menus set permission_actions = 'index?audit_class=0,edit,edit_tbl1,edit_comment' where uri='d_audit_cashboxes?audit_class=0';"
    execute "update menus set permission_actions = 'd_audit_cashboxes?audit_class=1' where uri='index?audit_class=1,edit,edit_tbl1,edit_tbl2,edit_comment';"
    execute "update menus set permission_actions = 'd_audit_changemachines?audit_class=0' where uri='index?audit_class=0,show,edit,edit_comment,confirm_shop_id_select,confirm_user_id_select,confirm_user_pass_select';"
    execute "update menus set permission_actions = 'd_audit_changemachines?audit_class=1' where uri='index?audit_class=1,show,edit,edit_comment,confirm_shop_id_select,confirm_user_id_select,confirm_user_pass_select';"
    execute "update menus set permission_actions = 'd_audit_etcs?audit_class=0' where uri='index?audit_class=0,edit,dialog_gosa';"
    execute "update menus set permission_actions = 'd_audit_etcs?audit_class=1' where uri='index?audit_class=1,edit,dialog_gosa';"
    execute "update menus set permission_actions = 'd_audit_washes?audit_class=0' where uri='index?audit_class=0,edit,dialog_gosa';"
    execute "update menus set permission_actions = 'd_audit_washes?audit_class=1' where uri='index?audit_class=1,edit,dialog_gosa';"
    execute "update menus set permission_actions = 'd_results/new' where uri='new,meter_index,tank_index,yume_index,yume_new,yume_edit,yume_delete,select_date';"
    execute "update menus set permission_actions = 'd_sales/new' where uri='new';"
    execute "update menus set permission_actions = 'd_washpurika_reports?mode=edit' where uri='index?mode=edit,edit';"
    execute "update menus set permission_actions = 'd_washpurika_reports?mode=show' where uri='index?mode=show';"
    
  end

  def down
    remove_column :menus, :actions
  end
end
