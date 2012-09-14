module DDutiesHelper
  
  #人権費入力のユーザを取得する
  def get_user_dutry(user_class, m_shop_id, start_yyyy, start_mm, start_dd, end_dd)
    str_conditions = "m_shop_id= #{m_shop_id} and "
    str_conditions << " user_class = #{user_class} and "
    str_conditions << " nyusya_date <= '#{start_yyyy}/#{start_mm}/#{end_dd}' and "
    str_conditions << " (deleted_flg = 0 or (deleted_flg = 1 and deleted_at>= '#{start_yyyy}/#{start_mm}/#{start_dd}')) "
    
    users = User.find(:all, 
              :conditions=>[str_conditions],
              :order => "account")
              

  end
  
  #社員の入力欄を作成
  def set_syain_row(index, loopcnt, select_where)
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      loopcnt.times { |i|
        if Time.now.day == (i+1)
          rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
        else
          rtn_html << "<td style='text-align: center;'>"
        end if
                
        unless d_duties[n].blank?

          if d_duties[n].day == (i + 1)
            rtn_html << "<label id='syain_#{i+1}_#{index}'>#{d_duties[n].day_work_time}</label>"
            n += 1
          else
            if d_duties[n].day >= i + 1
              rtn_html << "<label id='syain_#{i+1}_#{index}'></label>"
            end
            
          end
        else
          rtn_html << "<label id='syain_#{i+1}_#{index}'></label>"
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        if Time.now.day == (i+1)
          rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
        else
          rtn_html << "<td style='text-align: center;'>"
        end if
        rtn_html << "<label id='syain_#{i+1}_#{index}'></label></td>"
        
      }
    end
    rtn_html << ""
  end
  
  #社員の日数の計
  def set_syain_nisu_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
      if Time.now.day == (i+1)
        rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
      else
        rtn_html << "<td style='text-align: center;'>"
      end if
      rtn_html << "<label id='syain_nisu_kei_#{i}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""
  end

  #バイトの入力欄作成
  def set_banto_row(index, loopcnt, select_where)
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      loopcnt.times { |i|
        if Time.now.day == (i+1)
          rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
        else
          rtn_html << "<td style='text-align: center;'>"
        end if
        
        unless d_duties[n].blank?
          
          if d_duties[n].day == (i + 1)
            rtn_html << "<label id='baito_#{i+1}_#{index}'>#{d_duties[n].all_work_time}</label></td>"
            n += 1
          else
            if d_duties[n].day >= i + 1
              rtn_html << "<td><label id='baito_#{i+1}_#{index}'></label></td>"
            end
            
          end
        else
          rtn_html << "<td><label id='baito_#{i+1}_#{index}'></label>"
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        if Time.now.day == (i+1)
          rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
        else
          rtn_html << "<td style='text-align: center;'>"
        end if
        rtn_html << "<label id='baito_#{i+1}_#{index}'></label></td>"
        
      }
    end
    rtn_html << ""
    
  end
  
  #バイト時間の計
  def set_baito_jikan_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
      if Time.now.day == (i+1)
        rtn_html << "<td style='text-align: center; background-color: #F7DC67'>"
      else
        rtn_html << "<td style='text-align: center;'>"
      end if
      rtn_html << "<label id='baito_jikan_kei_#{i}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""    
  end
  
end
