class DAuditChecksController < ApplicationController
  
  def index

    # 処理なし

  end

  def edit

    # チェック項目(マスタ)を読込 (d_audit_checkはView側で個別読込します)
    @m_audit_checks = MAuditCheck.find_by_sql("
      select
         m_audit_checks.id
        ,m_class_checks.item
        ,m_audit_checks.content
        ,(select count(*) from m_audit_checks 
            where deleted_flg = 0 and m_class_check_id = m_class_checks.id) as cnt
      from 
                   m_class_checks
        inner join m_audit_checks
      on 
          m_class_checks.id = m_audit_checks.m_class_check_id
      where
             m_class_checks.deleted_flg = 0
         and m_audit_checks.deleted_flg = 0
      order by
             m_class_checks.class_code
            ,m_audit_checks.check_code
    ")
    
  end

  def update
    
    #更新日時をバッファ
    upd_time = Time.now 
    
    #更新全体をトランザクション処理    
    DAuditEtc.transaction {  
  
    # 明細レコードを保存
    rec_cnt = 1
    until params["d_audit_check#{rec_cnt}"].nil? do
      
      # 更新する1件分のデータを取得
      rec = params["d_audit_check#{rec_cnt}"]
      
      # チェックフラグの未選択を0に置換する
      rec[:check_flg] = "0" if (rec[:check_flg].to_s == "") 
      
      # 更新対象のActiveRecordを取得
      if rec[:id] == "" 
        d_audit_check = DAuditCheck.new()
        d_audit_check.created_user_id = current_user.id
        d_audit_check.created_at = upd_time
      else
        d_audit_check = DAuditCheck.find(rec[:id])
      end
      
      # 更新データをActiveRecordにセット
      d_audit_check.attributes = rec
      
      # タイムスタンプ情報をセット
      d_audit_check.updated_user_id = current_user.id
      d_audit_check.updated_at = upd_time
      
      # 1件分のActiveRecord保存
      d_audit_check.save!
      
      rec_cnt += 1
    end
    
    # 合計レコード保存(m_audit_check_id=999)
    rec = params["d_audit_check"]
    if rec[:id] == ""
      d_audit_check = DAuditCheck.new()
      d_audit_check.created_user_id = current_user.id
      d_audit_check.created_at = upd_time
    else
      d_audit_check = DAuditCheck.find(rec[:id])
    end
    
    # 更新データをActiveRecordにセット
    d_audit_check.attributes = rec
    
    # タイムスタンプ情報をセット
    d_audit_check.updated_user_id = current_user.id
    d_audit_check.updated_at = upd_time
      
    # 合計レコードのActiveRecord保存
    d_audit_check.save!
      
    } #トランザクション終了
   
    # 再読込
    audit_date = params[:d_audit_check][:audit_date]
    audit_date = "#{audit_date[0..3]}/#{audit_date[4..5]}/#{audit_date[6..7]}"
    redirect_to :action => "edit", :header => {:audit_date => audit_date,
                                               :m_shop_id  => params[:d_audit_check][:m_shop_id]}
    
  
  end

end
