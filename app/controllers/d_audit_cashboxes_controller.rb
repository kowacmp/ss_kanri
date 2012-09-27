class DAuditCashboxesController < ApplicationController

  def index
 
    # 自主監査 or 本監査を取得しセッションへ保存
    if params[:audit_class] == "0" or params[:audit_class] == "1" then
      session[:audit_class] = params[:audit_class].to_s
    else
      redirect_to :controller => "homes", :action => "index"
      return
    end 
 
    # TEST用
    #@d_audit_cashbox = DAuditCashbox.new()
    
  end

  def edit
    
    if not(params[:id].nil?) then
      # IDを指定した呼出
      d_audit_cashbox       = DAuditCashbox.find(params[:id]) 
      session[:audit_class] = d_audit_cashbox[:audit_class].to_s
      @m_shop_id            = d_audit_cashbox[:m_shop_id]
      @created_user_id      = d_audit_cashbox[:created_user_id]
      @audit_date           = d_audit_cashbox[:audit_date]
      @audit_date = @audit_date[0..3] + "/" + @audit_date[4..5] + "/" + @audit_date[6..7] 
    else
      # 検索から呼出
      @m_shop_id       = params[:header][:m_shop_id] 
      @created_user_id = params[:header][:created_user_id]
      @audit_date      = params[:header][:audit_date]
    end
    
    # 金庫監査データ読込
    @d_audit_cashbox = DAuditCashbox.find(:first, :conditions => 
      ["audit_date=? AND audit_class=? AND m_shop_id=?",
          @audit_date.to_s.gsub("/",""),
          session[:audit_class],
          @m_shop_id])
    
    # データがない場合は新規
    if @d_audit_cashbox.nil? then
      @d_audit_cashbox = DAuditCashbox.new()
      
      # KEY部分を設定
      @d_audit_cashbox.audit_date      = @audit_date.to_s.gsub("/","")
      @d_audit_cashbox.audit_class     = session[:audit_class]
      @d_audit_cashbox.m_shop_id       = @m_shop_id
      @d_audit_cashbox.created_user_id = @created_user_id
     
    end
    
  end

  def update
    
    if params[:key][:id].to_s == "" then
      #　新規
      @d_audit_cashbox = DAuditCashbox.new()
      
      #  POSTデータに含まれない部分を設定
      @d_audit_cashbox["kakutei_flg"] = 0
      @d_audit_cashbox["kakunin_flg"] = 0
      @d_audit_cashbox["kakunin_user_id"] = 0
      @d_audit_cashbox["kakunin_date"] = nil
      for i in 1..5
        @d_audit_cashbox["approve_id#{ i }"] = 0
        @d_audit_cashbox["approve_date#{ i }"] = nil
      end
      @d_audit_cashbox["created_user_id"] = current_user.id
    else
      #  更新
      @d_audit_cashbox = DAuditCashbox.find(params[:key][:id])
    end
    
    # POSTデータを設定
    @d_audit_cashbox.attributes = params[:d_audit_cashbox]
    @d_audit_cashbox.confirm_shop_id = params[:confirm][:shop_id]
    @d_audit_cashbox.confirm_user_id = params[:confirm][:user_id]
    
    # 更新者設定
    @d_audit_cashbox.updated_user_id = current_user.id
    
    # 更新完了
    @d_audit_cashbox.save!
  
    # 再読込
    redirect_to :action => "edit", :header => {:m_shop_id       => params[:hheader][:m_shop_id],
                                               :created_user_id => params[:hheader][:created_user_id],
                                               :audit_date      => params[:hheader][:audit_date]}
      
  
  end

  def edit_tbl1
    
    render :layout => "modal"
    
  end

  def edit_comment
    
    render :layout => "modal"
    
  end

  def update_tbl1
    
    @d_audit_cashbox = params[:d_audit_cashbox]
    
  end

  def edit_tbl2
    
    render :layout => "modal"
    
  end

  def update_tbl2
    
    @d_audit_cashbox = params[:d_audit_cashbox]
    
  end


end
