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

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "38"
      else
        @menu_id = "43"
      end
      
    when "2" #釣銭
      @table = "d_audit_changemachines"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "39"
      else
        @menu_id = "44"
      end
    
    when "3" #洗車
      @table = "d_audit_washes"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "40"
      else
        @menu_id = "45"
      end
    
    when "4" #その他
      @table = "d_audit_etcs"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "42"
      else
        @menu_id = "46"
      end
    
    end
    
    
    
    
  end

 
end
