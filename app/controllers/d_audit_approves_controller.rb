class DAuditApprovesController < ApplicationController

  def index

    # 処理なし

  end

  def edit
    
    # 詳細からの戻りを考慮
    if params[:header].blank? 
      redirect_to :action => "edit", :header => session[:d_audit_approves_header]
      return
    end
    session[:d_audit_approves_header] = params[:header]
    
    p "params[:header]1=======================#{params[:header][:ym_y]}"
    p "params[:header]1========================#{params[:header][:ym_m]}"
    # params[:header][:ym_y] = Date.today.year.to_s
    #  params[:header][:ym_m] = sprintf('%02d', Date.today.month)
    #end
    p "params[:header]2=======================#{params[:header][:ym_y]}"
    p "params[:header]2========================#{params[:header][:ym_m]}"

    # 処理選択よりメニューIDを取得する
    case params[:header][:kansa].to_s
    when "1" #金庫
      @table = "d_audit_cashboxes"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "34"
      else
        @menu_id = "38"
      end
      @audit_date = "audit_date"
    when "2" #釣銭
      @table = "d_audit_changemachines"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "35"
      else
        @menu_id = "39"
      end
      @audit_date = "audit_date"
    when "3" #洗車
      @table = "d_audit_washes"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "36"
      else
        @menu_id = "40"
      end
      @audit_date = "audit_date_from"
    when "4" #その他
      @table = "d_audit_etcs"

      if params[:header][:audit_class].to_s == "0" then
        @menu_id = "37"
      else
        @menu_id = "41"
      end
      @audit_date = "audit_date_from"
    end
    
    # 承認ID、及び名称を取得する
    @approval_id = 0
    @approval_name = ""
    m_approval = MApproval.find(:first, :conditions => ["menu_id=?", @menu_id])
    if not(m_approval.nil?) then
      for i in 1..5 do
        if m_approval["approval_id#{i}"].to_s == current_user.id.to_s then
          @approval_id   = i
          @approval_name = m_approval["approval_name#{i}"] 
        end
      end
    end
    
    sql = <<-SQL
      select
         a.*
      from 
                    #{ @table } as a
        inner join  m_shops
      on 
             a.m_shop_id = m_shops.id
      where
            m_shops.shop_kbn = #{params[:header][:shop_kbn]}
        and a.audit_class = #{params[:header][:audit_class]}
        and substring(a.#{@audit_date},1,6) = '#{params[:header][:ym_y]}#{params[:header][:ym_m]}'
      order by
         m_shops.shop_cd,a.#{@audit_date}
    SQL
    
    @approval = MApproval.find_by_sql(sql)

  end

  def update

    #更新日時をバッファ
    upd_time = Time.now 

    #書込先の共通情報を取得
    table = params[:approval][:table]
    approval_id = params[:approval][:approval_id]
    approval_name = params[:approval][:approval_name]

    #更新全体をトランザクション処理    
    MApproval.transaction {  

    i = 1
    until params["approval#{i}"].nil? do
      
      #1行分のを取得する
      approval = params["approval#{i}"]

      #チェックが変更されていたら書込する
      if approval[:old_approval_flg].to_s != approval[:approval_flg].to_s then
            
        case params[:approval][:table].to_s
        when "d_audit_cashboxes"
          rec = DAuditCashbox.find(approval[:id])
        when "d_audit_changemachines"
          rec = DAuditChangemachine.find(approval[:id])
        when "d_audit_washes"
          rec = DAuditWash.find(approval[:id])
        when "d_audit_etcs"
          rec = DAuditEtc.find(approval[:id])
        end 
        
        # 1～5に自分が書込されていたら初期化
        for j in 1..5 do
          if rec["approve_id#{j}"].to_s == current_user.id.to_s then
            rec["approve_id#{j}"] = 0
            rec["approve_date#{j}"] = nil
          end
        end
                  
        if approval[:approval_flg].to_s == "true" then
          # マスタに設定されているIDの箇所に書込
          rec["approve_id#{approval_id}"] = current_user.id
          rec["approve_date#{approval_id}"] = upd_time.to_date
        end
      
        rec[:updated_user_id] = current_user.id
        rec[:updated_at] = upd_time
      
        rec.save!
        
      end
      
      i += 1
    
    end
    
    } #トランザクション終了

    #トップに戻る
    redirect_to :action => "edit", :header => {
                                               :ym_y => params[:hheader][:ym_y],
                                               :ym_m => params[:hheader][:ym_m],
                                               :kansa => params[:hheader][:kansa],
                                               :shop_kbn => params[:hheader][:shop_kbn],
                                               :audit_class => params[:hheader][:audit_class],
                                               :zumi_flg => true} #チェックONを強制的に出す    
    
  end
  
  # 各詳細画面からの承認のAJAX更新
  def update_audit_approves
    
    # 更新対象の情報を得る
    approves = get_apploval_info(params[:table], params[:id].to_i)
    table = approves[:table]
    approval_id = approves[:approval_id]

    # 1～5に自分が書込されていたら初期化
    for j in 1..5 do
      if table["approve_id#{j}"].to_s == current_user.id.to_s then
            table["approve_id#{j}"] = 0
            table["approve_date#{j}"] = nil
      end
    end
    
    if params[:checked].to_s == "true" then
      # マスタに設定されているIDの箇所に書込
      table["approve_id#{approval_id}"] = current_user.id
      table["approve_date#{approval_id}"] = Time.now.to_date
    end
    
    table.save!
    
    head :ok
    
  end
  
end