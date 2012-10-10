# -*- coding:utf-8 -*-
module DAuditListsHelper

  # 監査日取得
  def get_audit_date(rec)
  
    if rec.nil? then
      return ""
    else
      if rec[:audit_date_from].nil? then
        audit_date = rec[:audit_date].to_s
        return audit_date[0..3] + "/" + audit_date[4..5] + "/" + audit_date[6..7]
      else
        audit_date_from = rec[:audit_date_from].to_s
        audit_date_to = rec[:audit_date_to].to_s
      
        ret = audit_date_from[0..3] + "/" + audit_date_from[4..5] + "/" + audit_date_from[6..7] + "<br/>" +
          "～" + audit_date_to[0..3] + "/" + audit_date_to[4..5] + "/" + audit_date_to[6..7]
        
        return raw ret
      
      end
    end
  end
  
  # 種別取得
  def get_audit_class(rec)
  
    if rec.nil? then
      return ""
    else
      return MCode.find(:first, :conditions => ["kbn='audit_class' and code = ? ", rec[:audit_class].to_s])[:code_name]
    end
  
  end
  
  # 監査人取得
  def get_kansanin(rec)
  
    if rec.nil? then
      return ""
    else
      return User.find(rec[:created_user_id])[:user_name].to_s
    end
  
  end
  
  # 立会人取得
  def get_tatiainin(rec)
  
    if rec.nil? then
      return ""
    else
      return User.find(rec[:confirm_user_id])[:user_name].to_s
    end
  
  end
  
  # 入力状況
  def get_nyuryoku(rec)
    
    if rec.nil? then
      return "未"
    else
      return "済"
    end
  
  
  end 
  
end
