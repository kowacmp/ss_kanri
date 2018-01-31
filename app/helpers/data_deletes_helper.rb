# -*- coding:utf-8 -*-
module DataDeletesHelper
  
  def get_del_date(date,keep_month)

    wk_ymd = date << keep_month + 1
    
    del_date = wk_ymd.strftime("%Y/%m/%d")
    return del_date
    
  end
  
  def get_del_user(user_id)
    #勤怠データ存在チェック
    @usercnt = DDuty.count(:all, :conditions=>["user_id = ? or created_user_id = ? or updated_user_id= ? ",user_id,user_id,user_id])
    if @usercnt != 0 
       return @usercnt
    else
      #目標値データ存在チェック
      @usercnt = DAim.count(:all, :conditions => ["created_user_id = ? or updated_user_id= ? ",user_id,user_id])
      if @usercnt != 0 
        return @usercnt
      else
        #実績データ存在チェック
        @usercnt = DResult.count(:all, :conditions => ["double_check_user_id = ? or created_user_id = ? or updated_user_id= ? ",user_id,user_id,user_id])
        if @usercnt != 0 
           return @usercnt
        else
          #売上データ存在チェック
          @usercnt = DSale.count(:all, :conditions => ["double_check_user_id = ? or created_user_id = ? or updated_user_id= ? ",user_id,user_id,user_id])
          if @usercnt != 0 
             return @usercnt
          else
            #洗車売上データ存在チェック
            @usercnt = DWashSale.count(:all, :conditions => ["created_user_id = ? or updated_user_id= ? ",user_id,user_id])
            if @usercnt != 0 
              return @usercnt
            else
              #他売上データ存在チェック
              @usercnt = DSaleEtc.count(:all, :conditions => ["created_user_id = ? or updated_user_id = ? ",user_id,user_id])
              if @usercnt != 0 
                 return @usercnt
              else
                #売上現金管理表データ存在チェック
                @usercnt = DSaleReport.count(:all, :conditions=> ["confirm_id = ? or approve_id1 = ? or approve_id2 = ? or approve_id3 = ? or
                                            approve_id4 = ? or approve_id5 = ? " ,user_id,user_id,user_id,user_id,user_id,user_id])
                if @usercnt != 0 
                   return @usercnt
                else
                  #洗車売上報告データ存在チェック
                  @usercnt = DWashsaleReport.count(:all, :conditions => ["created_user_id = ? or updated_user_id= ? " ,user_id,user_id])
                  if @usercnt != 0 
                     return @usercnt
                  else
                    #金庫釣銭監査データ存在チェック
                    @usercnt = DAuditCashbox.count(:all, :conditions => ["confirm_user_id = ? or kakunin_user_id = ? 
                                or approve_id1 = ? or approve_id2 = ? or approve_id3 = ? or approve_id4 = ? or approve_id5 = ?
                                or created_user_id = ? or updated_user_id= ? " ,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id])
                    if @usercnt  != 0 
                      return @usercnt
                    else
                      #釣銭機内監査データ存在チェック
                      @usercnt = DAuditChangemachine.count(:all, :conditions => ["confirm_user_id = ? or kakunin_user_id = ? 
                                  or approve_id1 = ? or approve_id2 = ? or approve_id3 = ? or approve_id4 = ? or approve_id5 = ?
                                  or created_user_id = ? or updated_user_id= ? " ,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id])
                      if @usercnt  != 0 
                        return @usercnt
                      else
                        #洗車機監査データ存在チェック
                        @usercnt = DAuditWash.count(:all, :conditions => ["confirm_user_id = ? or kakunin_user_id = ? 
                                    or approve_id1 = ? or approve_id2 = ? or approve_id3 = ? or approve_id4 = ? or approve_id5 = ?
                                    or created_user_id = ? or updated_user_id= ? " ,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id])
                        if @usercnt  != 0 
                          return @usercnt
                        else
                          #他売上監査データ存在チェック
                          @usercnt = DAuditEtc.count(:all, :conditions => ["confirm_user_id = ? or kakunin_user_id = ? 
                                      or approve_id1 = ? or approve_id2 = ? or approve_id3 = ? or approve_id4 = ? or approve_id5 = ?
                                      or created_user_id = ? or updated_user_id= ? " ,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id,user_id])
                          if @usercnt  != 0 
                            return @usercnt
                          else
                            #備品購入申請データ存在チェック
                            @usercnt = DFixture.count(:all, :conditions => ["approve_id1 = ? or created_user_id = ? or updated_user_id= ? " ,user_id,user_id,user_id])
                            if @usercnt  != 0 
                              return @usercnt
                            else
                              return @usercnt
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
