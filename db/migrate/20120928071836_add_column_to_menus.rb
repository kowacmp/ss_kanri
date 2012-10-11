# -*- coding:utf-8 -*-
class AddColumnToMenus < ActiveRecord::Migration
  def up
    add_column :menus, :permission_actions, :text
    execute "COMMENT ON COLUMN menus.permission_actions IS '利用できるアクションを設定 nullの場合は全てのアクションを利用できる';"
    
    #初期セット
    #実績メーター入力
    where_uri = "d_results/new"
    set_val = "new,meter_index,tank_index,yume_index,yume_new,yume_edit,yume_delete,select_date,oil_total_set"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #現金売上入力
    where_uri = "d_sales/new"
    set_val = "new,report_view"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #洗車プリカ目標販売
    where_uri = "d_washpurika_reports?mode=show"
    set_val = "index?mode=show"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #洗車メーター売上入力状況
    where_uri = "d_washsale_lists"
    set_val = "index,show,compare,d_wash_sales/index,d_wash_sales/entry_error"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #金庫自主監査
    where_uri = "d_audit_cashboxes?audit_class=0"
    set_val = "index?audit_class=0,edit,edit_tbl1,edit_comment"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #釣銭機自主監査
    where_uri = "d_audit_changemachines?audit_class=0"
    set_val = "index?audit_class=0,show,edit,edit_comment,confirm_shop_id_select,confirm_user_id_select,confirm_user_pass_select"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #洗車メーター自主監査
    where_uri = "d_audit_washes?audit_class=0"
    set_val = "index?audit_class=0,edit,dialog_gosa"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #他商品自主監査
    where_uri = "d_audit_etcs?audit_class=0"
    set_val = "index?audit_class=0,edit,dialog_gosa"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #金庫本監査
    where_uri = "d_audit_cashboxes?audit_class=1"
    set_val = "index?audit_class=1,edit,edit_tbl1,edit_tbl2,edit_comment"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #釣銭機本監査
    where_uri = "d_audit_changemachines?audit_class=1"
    set_val = "index?audit_class=1,show,edit,edit_comment,confirm_shop_id_select,confirm_user_id_select,confirm_user_pass_select"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #洗車メーター本監査
    where_uri = "d_audit_washes?audit_class=1"
    set_val = "index?audit_class=1,edit,dialog_gosa"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #他商品本監査
    where_uri = "d_audit_etcs?audit_class=1"
    set_val = "index?audit_class=1,edit,dialog_gosa"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #店舗マスタメンテ
    where_uri = "m_shops"
    set_val = "index,show,new,edit,m_meters/new"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"
    #洗車プリカ目標販売更新
    where_uri = "d_washpurika_reports?mode=edit"
    set_val = "index?mode=edit,edit"
    execute "update menus set permission_actions = '#{set_val}' where uri='#{where_uri}';"

  end

  def down
    remove_column :menus, :actions
  end
end
