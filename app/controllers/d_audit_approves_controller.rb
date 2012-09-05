class DAuditApprovesController < ApplicationController

  def index

    # 処理なし

  end

  def edit

    # 処理選択よりメニューIDを取得する
    @menu_id = 1 #TODO:マスタを表示すること
    
    # 処理選択より対象テーブルを取得する
    @table = "d_audit_changemachines" #TODO:決め打ち
    
    # 承認ID、及び名称を取得する
    @approval_id = 0
    @approval_name = ""
    m_approval = MApproval.find(:first, :conditions => ["menu_id=?", @menu_id])
    
    for i in 1..5 do
       if m_approval["apprpval_id#{i}"] = current_user.id then
         @approval_id   = i
         @approval_name = m_approval["apprpval_name#{i}"] 
       end
    end
    
    # 承認済を含むの条件を先に作る
    where_zumi = ""
    if params[:header][:zumi_flg].to_s != "1" then
      where_zumi = " and coalesce(a.approve_id#{@approval_id}, 0) = 0 "  
    end
    
    sql = <<-SQL
      select
         a.id 
        ,a.m_shop_id
        ,a.audit_date
        ,a.created_user_id
        ,a.confirm_user_id
        ,coalesce(a.approve_id#{@approval_id}, 0) as approve_id
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
        ,a.audit_date
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
      if to_boolean(approval[:old_approval_flg]) != to_boolean(approval[:approval_flg]) then
            
        # TODO:書込テーブルをtableを見て変更すること
        rec = DAuditChangemachine.find(approval[:id])
         
        if to_boolean(approval[:approval_flg]) then
          #ON
          rec["approve_id#{approval_id}"] = current_user.id
          rec["approve_date#{approval_id}"] = upd_time.to_date
        else
          #OFF
          rec["approve_id#{approval_id}"] = 0
          rec["approve_date#{approval_id}"] = nil
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
                                               :kansa => params[:header][:kansa],
                                               :shop_kbn => params[:header][:shop_kbn],
                                               :audit_class => params[:header][:audit_class],
                                               :zumi_flg => 1} #チェックONを強制的に出す    
    
  end
  
  private
  def to_boolean(obj)
    
    return (obj.to_s == "true" or obj.to_s == "1")
    
  end

end