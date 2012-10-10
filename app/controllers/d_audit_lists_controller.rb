# -*- coding:utf-8 -*-
class DAuditListsController < ApplicationController

  def index
    
    # 処理なし
    
  end

  def edit

    # 検索パラメータ取得
    @p_header = params[:header]
    
    # 処理選択よりメニューIDを取得する
    case params[:header][:kansa].to_s
    when "1" #金庫
      @table = "d_audit_cashboxes"
      @shori_name = "金庫"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "38"
      else
        @menu_id = "43"
      end
      
    when "2" #釣銭
      @table = "d_audit_changemachines"
      @shori_name = "釣銭"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "39"
      else
        @menu_id = "44"
      end
    
    when "3" #洗車
      @table = "d_audit_washes"
      @shori_name = "洗車"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "40"
      else
        @menu_id = "45"
      end
    
    when "4" #その他
      @table = "d_audit_etcs"
      @shori_name = "その他"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "42"
      else
        @menu_id = "46"
      end
    
    end
    
    # audit_date_from～to と audit_date の切り分け
    audit_date = @p_header[:audit_date].to_s.delete("/")
    case @table
    when "d_audit_etcs", "d_audit_washes"
      w_audit_date = " audit_date_from <= '#{ audit_date }' and audit_date_to >= '#{ audit_date }' "
    else
      w_audit_date = " audit_date = '#{ audit_date }' "
    end
    
    # SQL文組み立て
    @sql = "
      select
         * 
      from 
        #{ @table }
      where 
            #{ w_audit_date }
        and audit_class = #{ @p_header[:audit_class] }
    "
    
    # 店舗読込
    if @p_header[:shop_kbn].to_s == "" then
      @m_shops = MShop.find(:all, :conditions => ["shop_kbn<>9"], :order => "shop_cd")
    else
      @m_shops = MShop.find(:all, :conditions => ["shop_kbn=?", @p_header[:shop_kbn]], :order => "shop_cd")
    end
      
  end

  # AJAX LOCK処理(単体)
  def lock
    
    audit = get_audit_record(params[:table], params[:id])
    
    if params[:kakutei_flg].to_s == "checked" then
      audit.kakutei_flg = 1
    else
      audit.kakutei_flg = 0
    end
    
    audit.updated_user_id = current_user.id
    audit.save!
    
    head :ok
    
  end
  
  # AJAX LOCK処理(複数件)
  def lock_all
    
    ids = params[:ids].to_s.split(",")
    for id in ids
      
      audit = get_audit_record(params[:table], id)
      
      if params[:kakutei_flg].to_s == "checked" then
        audit.kakutei_flg = 1
      else
        audit.kakutei_flg = 0
      end
      
      audit.updated_user_id = current_user.id
      audit.save!
    end
    
    head :ok
    
  end
  
private
  # AJAX LOCK 対象のActiveRecord取得
  def get_audit_record(table, id)
    
    case table
    when "d_audit_cashboxes"
      audit = DAuditCashbox.find(id)
    when "d_audit_changemachines"
      audit = DAuditChangemachine.find(id)
    when "d_audit_washes"
      audit = DAuditWash.find(id)
    when "d_audit_etcs"
      audit = DAuditEtc.find(id)
    end
    
    return audit
    
  end

end
