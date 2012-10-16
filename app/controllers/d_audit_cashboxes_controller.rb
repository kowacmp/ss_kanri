class DAuditCashboxesController < ApplicationController

  def index
 
    # 自主監査 or 本監査を取得しセッションへ保存
    if params[:audit_class] == "0" or params[:audit_class] == "1" then
      session[:audit_class] = params[:audit_class].to_s
    else
      redirect_to :controller => "homes", :action => "index"
      return
    end 
 
  end

  def show
    
    redirect_to :action => "edit", :id => params[:id], :readonly => true, :back => true
    
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
      
      # 名称、及び指定額取得
      fix_item_class = -1
      idx = 0
      m_fix_items = MFixItem.find(:all, :conditions => "deleted_flg=0", :order => "fix_item_class,fix_item_cd")
      m_fix_money = MFixMoney.find(:first, :conditions => ["deleted_flg=0 and m_shop_id = ? and start_month <= ? and end_month >= ?",
                                                            @m_shop_id, 
                                                            @audit_date.to_s.gsub("/","")[4..5],
                                                            @audit_date.to_s.gsub("/","")[4..5] ])
      for m_fix_item in m_fix_items
        if m_fix_money.nil? then
          # 金額マスタがない場合は未設定
        else
          # 金額マスタを読込、金額がある場合のみ設定
          for i in 1..13
            if m_fix_money["m_fix_item_id#{ i }"] == m_fix_item[:id] then
              if not(m_fix_money["fix_money#{ i }"].nil?) and (m_fix_money["fix_money#{ i }"] > 0) then
                if fix_item_class != m_fix_item.fix_item_class then
                  fix_item_class = m_fix_item.fix_item_class
                  idx = 0
                end
                idx += 1
                
                if fix_item_class == 0 then
                  @d_audit_cashbox["cashbox#{ idx }_name"] = m_fix_item[:fix_item_ryaku]
                  @d_audit_cashbox["cashbox#{ idx }"] = m_fix_money["fix_money#{ i }"]
                else
                  @d_audit_cashbox["sum#{ idx }_cashbox_name"] = m_fix_item[:fix_item_ryaku]
                  @d_audit_cashbox["sum#{ idx }_cashbox"] = m_fix_money["fix_money#{ i }"]
                end # fix_item_class == 0
              end # if not(m_fix_money["fix_money#{ i }"].nil?) and (m_fix_money["fix_money#{ i }"] > 0)
            end # if m_fix_money["m_fix_item_id#{ i }"] == m_fix_item[:id] 
          end # for i in 1..13
        end # if m_fix_money.nil?
      end # for m_fix_item in m_fix_items
    end # if @d_audit_cashbox.nil?
  end # def

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
