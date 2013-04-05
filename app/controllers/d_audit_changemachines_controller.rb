class DAuditChangemachinesController < ApplicationController

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
    
    redirect_to :action => "edit", :id => params[:id], :readonly => true, :back => true, :comment => params[:comment].to_s
    
  end
  
  def edit

    if not(params[:id].nil?) then
      # IDを指定した呼出
      d_audit_changemachine = DAuditChangemachine.find(params[:id]) 
      session[:audit_class] = d_audit_changemachine[:audit_class].to_s
      @m_shop_id            = d_audit_changemachine[:m_shop_id]
      @created_user_id      = d_audit_changemachine[:created_user_id]
      @audit_date           = d_audit_changemachine[:audit_date]
      @audit_date = @audit_date[0..3] + "/" + @audit_date[4..5] + "/" + @audit_date[6..7] 
    else
      # 検索から呼出
      @m_shop_id       = params[:header][:m_shop_id] 
      @created_user_id = params[:header][:created_user_id]
      @audit_date      = params[:header][:audit_date]
    end

    # 釣銭機内監査データ読込
    @d_audit_changemachine = DAuditChangemachine.find(:all, :conditions => 
      ["audit_date=? AND audit_class=? AND m_shop_id=?",
          @audit_date.to_s.gsub("/",""),
          session[:audit_class],
          @m_shop_id])
   
    # 監査人が異なる場合の呼出は強制的に照会へ
    #if @d_audit_changemachine.length > 0 then
    #  if @d_audit_changemachine[0].created_user_id != @created_user_id then
    #    redirect_to :action => "show", :id => @d_audit_changemachine[0].id
    #    return
    #  end
    #end
   
    # データがない場合は新規
    if @d_audit_changemachine.length == 0 then
      @d_audit_changemachine = DAuditChangemachine.new()
            
      #監査日を設定
      @d_audit_changemachine.audit_date  = @audit_date.to_s.gsub("/","")
      
      #前回監査データより一部データを読込し設定
      #zenkansa = DAuditChangemachine.find(:first, :conditions => 
      #  ["audit_date<? AND m_shop_id=?",
      #    @audit_date.to_s.gsub("/",""),
      #    @m_shop_id])
      
      #if not(zenkansa.nil?) then
      #  for pos in 1..3
      #    for i in 1..7
      #      @d_audit_changemachine["pos#{pos}_before_money#{i}"] = zenkansa["pos#{pos}_after_money#{i}"]
      #    end
      #  end
      #end 
      
      # 新規のみマスタより名称を取得
      @m_machine_number = MMachineNumber.find(:first, :conditions => ["m_shop_id = ?", @m_shop_id])
      if not(@m_machine_number.nil?) then
        for i in 1..7
           @d_audit_changemachine["pos1machineno#{ i }"] = @m_machine_number["pos1machineno#{ i }"]
           @d_audit_changemachine["pos2machineno#{ i }"] = @m_machine_number["pos2machineno#{ i }"]
           @d_audit_changemachine["pos3machineno#{ i }"] = @m_machine_number["pos3machineno#{ i }"]
        end
      end
    end

    # 釣銭固定額読込
    # UPDATE BEGIN 2012.12.05 年またぎの月指定をしている場合を考慮 
    #@m_fix_money = MFixMoney.find(:first, :conditions => 
    #  ["m_shop_id = ? AND start_month <= ? AND end_month >= ? ",
    #      @m_shop_id, 
    #      @audit_date.to_s.gsub("/","")[4..5],
    #      @audit_date.to_s.gsub("/","")[4..5]])
   
      m_fix_moneys = MFixMoney.find(:all, :conditions => ["deleted_flg=0 and m_shop_id=?", @m_shop_id])
      @m_fix_money = nil
      t_month = @audit_date.to_s.gsub("/","")[4..5].to_i
      for rec in m_fix_moneys
        if rec.start_month.to_i <= rec.end_month.to_i then
          if (rec.start_month.to_i <= t_month) and (rec.end_month.to_i >= t_month) then
            @m_fix_money = rec
          end
        else 
          for i in rec.start_month.to_i .. 12
              @m_fix_money = rec if i == t_month
          end
          for i in 1 .. rec.end_month.to_i
              @m_fix_money = rec if i == t_month
          end
        end 
      end # for rec in m_fix_moneys
    # UPDATE BEGIN 2012.12.05 年またぎの月指定をしている場合を考慮 
  end

  def update

    # INSERT BEGIN 2013.04.05 削除機能を追加 
    if not(params[:delete_id].blank?)
      DAuditChangemachine.transaction {  
        DAuditChangemachine.destroy_all(["id=?", params[:delete_id].to_i])
      }
      if params[:audit_list].to_s == "true" then
        redirect_to :controller => "d_audit_lists", :action => "edit", :back => true
      else
        redirect_to :action => "index", :audit_class => session[:audit_class]
      end
      return
    end
    # INSERT END 2013.04.05 削除機能を追加

    #更新日時をバッファ
    upd_time = Time.now 

    #書込先読込
    @d_audit_changemachine = DAuditChangemachine.find(:first, :conditions => 
      ["audit_date=? AND audit_class=? AND m_shop_id=?",
          params[:d_audit_changemachine][:audit_date],
          session[:audit_class],
          params[:d_audit_changemachine][:m_shop_id]])
    
    #新規の場合
    if @d_audit_changemachine.nil? then
      @d_audit_changemachine = DAuditChangemachine.new()
      
      # form_forで定義されていない部分の初期化
      @d_audit_changemachine.audit_class = session[:audit_class]
      @d_audit_changemachine.m_shop_id = params[:d_audit_changemachine][:m_shop_id]
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
    if params[:audit_list].to_s == "true" then
      redirect_to :action => "edit", :id => @d_audit_changemachine.id, :audit_list => true
    else
      redirect_to :action => "edit", :id => @d_audit_changemachine.id, :readonly => false
    end
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

  def edit_comment
    
    render :layout => "modal"
    
  end

  # 立会人(ユーザ)選択時イベント(d_audit系で共通)
  def confirm_user_id_select
    
    # TO:confirm_user_id_select.js.erb
    
  end

  # 立会人(パスワード)選択イベント(d_audit系で共通)
  def confirm_user_pass_select
      
    i_pass = params[:pass][:user_pass] 
    i_user = User.find(params[:pass][:user_id])
    
    @pass_ok = i_user.valid_password?(i_pass)

    # TO:confirm_user_pass_select.js.erb

  end 
  
  # コメントのみのAJAX更新
  def update_comment
    
    @d_audit_changemachine = DAuditChangemachine.find(params[:id])
    @d_audit_changemachine[:comment] = params[:comment]
    @d_audit_changemachine.save!
    
    head :ok
    
  end
  
end
