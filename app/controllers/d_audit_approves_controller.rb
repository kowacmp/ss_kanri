class DAuditApprovesController < ApplicationController

  def index

    # 処理なし

  end

  def edit

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
    
    # 承認済を含むの条件を先に作る
    where_zumi = ""
    if params[:header][:zumi_flg].to_s != "true" then #自分が承認していないもの
      where_zumi = "
                       and coalesce(a.approve_id1, 0) != #{current_user.id} 
                       and coalesce(a.approve_id2, 0) != #{current_user.id}
                       and coalesce(a.approve_id3, 0) != #{current_user.id}
                       and coalesce(a.approve_id4, 0) != #{current_user.id}
                       and coalesce(a.approve_id5, 0) != #{current_user.id}
                   "
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
        #{ where_zumi }
      order by
         m_shops.shop_cd
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
          rec = DAutitWash.find(approval[:id])
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
                                               :kansa => params[:hheader][:kansa],
                                               :shop_kbn => params[:hheader][:shop_kbn],
                                               :audit_class => params[:hheader][:audit_class],
                                               :zumi_flg => true} #チェックONを強制的に出す    
    
  end
  
end