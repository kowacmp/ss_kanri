class DAuditChangemachinesController < ApplicationController

  def index

    # 自主監査 or 本監査を取得しセッションへ保存
    if params[:audit_class] == "0" or params[:audit_class] == "1" then
      session[:audit_class] = params[:audit_class].to_s
    else
      redirect_to :controller => "homes", :action => "index"
      return
    end 

    @m_shops = MShop.find(current_user.m_shop_id)

    # 監査日が指定されている場合は再読込
    if not(params[:kansa].nil?) then
      hyouji_index
    end

  end
  
  def hyouji_index

    # 釣銭機内監査データ読込
    @d_audit_changemachine = DAuditChangemachine.find(:all, :conditions => 
      ["audit_date=? AND audit_class=? AND m_shop_id=?",
          params[:kansa][:ymd].to_s.gsub("/",""),
          session[:audit_class],
          current_user.m_shop_id])
   
    # データがない場合は新規
    if @d_audit_changemachine.length == 0 then
      @d_audit_changemachine = DAuditChangemachine.new()
            
      #監査日を設定
      @d_audit_changemachine.audit_date  = params[:kansa][:ymd].gsub("/","");
      
      #前回監査データより一部データを読込し設定
      zenkansa = DAuditChangemachine.find(:first, :conditions => 
        ["audit_date<? AND m_shop_id=?",
          params[:kansa][:ymd].gsub("/",""),
          current_user.m_shop_id])
      
      if not(zenkansa.nil?) then
        for pos in 1..3
          for i in 1..7
            @d_audit_changemachine["pos#{pos}_before_money#{i}"] = zenkansa["pos#{pos}_after_money#{i}"]
          end
        end
      end 
      
    end

    # 釣銭固定額読込
    @m_fix_money = MFixMoney.find(:first, :conditions => 
      ["m_shop_id = ? AND start_month <= ? AND end_month >= ? ",
          current_user.m_shop_id, 
          params[:kansa][:ymd].gsub("/","")[0..5],
          params[:kansa][:ymd].gsub("/","")[0..5]])
          
  end

  def update

    #更新日時をバッファ
    upd_time = Time.now 

    #書込先読込
    @d_audit_changemachine = DAuditChangemachine.find(:first, :conditions => 
      ["audit_date=? AND audit_class=? AND m_shop_id=?",
          params[:d_audit_changemachine][:audit_date],
          session[:audit_class],
          current_user.m_shop_id])
    
    #新規の場合
    if @d_audit_changemachine.nil? then
      @d_audit_changemachine = DAuditChangemachine.new()
      
      # form_forで定義されていない部分の初期化
      @d_audit_changemachine.audit_class = session[:audit_class]
      @d_audit_changemachine.m_shop_id = current_user.m_shop_id
      @d_audit_changemachine.kakutei_flg = 0
      @d_audit_changemachine.kakunin_flg = 0
      
      @d_audit_changemachine.created_user_id = current_user.id
      @d_audit_changemachine.created_at = upd_time
    end

    #form_forで生成された部分の取得
    d_audit_changemachine = params[:d_audit_changemachine]
    
    #form_forで生成された部分の同期
    @d_audit_changemachine.attributes = d_audit_changemachine

    #立会人
    @d_audit_changemachine.confirm_shop_id = params[:confirm][:shop_id]
    @d_audit_changemachine.confirm_user_id = params[:confirm][:user_id]

    #タイムスタンプ情報
    @d_audit_changemachine.updated_user_id = current_user.id
    @d_audit_changemachine.updated_at = upd_time
    
    #commit
    @d_audit_changemachine.save
    
    #トップに戻る
    redirect_to :action => "index", 
      :audit_class => session[:audit_class],
      :kansa => {:ymd => params[:d_audit_changemachine][:audit_date]}

  end

  # 立会人(店舗)選択時イベント(d_audit系で共通)
  def confirm_shop_id_select
    
    if params[:shop_id] == '' then
      @shop_id = nil
    else
      @shop_id = params[:shop_id]
    end 
    
    # TO:confirm_shop_id_select.js.erb
    
  end

  # 立会人(ユーザ)選択時イベント(d_audit系で共通)
  def confirm_user_id_select
    
    # TO:confirm_user_id_select.js.erb
    
  end

  # 立会人(パスワード)選択イベント(d_audit系で共通)
  def confirm_user_pass_select
  
    p "user_id=" + params[:pass][:user_id]
    p "user_pass=" + params[:pass][:user_pass]
  
    # TODO:パスワードの取得方法を考える必要有
    pass1 = params[:pass][:user_pass] 
    pass2 = "abc" 
  
    if pass1 == pass2 
      @pass_ok = true
    else
      @pass_ok = false
    end 

    # TO:confirm_user_pass_select.js.erb

  end 
  
end
