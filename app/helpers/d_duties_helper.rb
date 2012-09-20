# -*- coding:utf-8 -*-
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
  def set_syain_row(user_id, loopcnt, select_where)
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #F7DC67;"
        else
          today_color =""
        end 
          
        rtn_html << "<td style='text-align: center;#{today_color}'>"

        unless d_duties[n].blank?

          if d_duties[n].day == (i + 1)
            if d_duties[n].day_work_time.to_i == 1
              rtn_html << "<label id='syain_#{i+1}_#{user_id}'>出</label>"
            else
              rtn_html << "<label id='syain_#{i+1}_#{user_id}' style='color:red'>休</label>"
            end

            rtn_html << hidden_field_tag("hiden_syain_#{i+1}_#{user_id}", d_duties[n].day_work_time.to_i)
            
            n += 1
          else
            if d_duties[n].day >= i + 1
              rtn_html << "<label id='syain_#{i+1}_#{user_id}'></label>"
              rtn_html << hidden_field_tag("hiden_syain_#{i+1}_#{user_id}", "")
            end
            
          end
        else
          rtn_html << "<label id='syain_#{i+1}_#{user_id}'></label>"
          rtn_html << hidden_field_tag("hiden_syain_#{i+1}_#{user_id}", "")
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #F7DC67;"
        else
          today_color =""
        end
        rtn_html << "<td style='text-align: center;#{today_color}'>"
        rtn_html << "<label id='syain_#{i+1}_#{user_id}'></label>"
        rtn_html << hidden_field_tag("hiden_syain_#{i+1}_#{user_id}", "")
        rtn_html << "</td>"
      }
    end
    rtn_html << ""
  end
  
  #社員の日数の計
  def set_syain_nisu_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
      if Time.now.day.to_i == (i+1).to_i
        today_color = "background-color: #F7DC67;"
      else
        today_color =""
      end 
  
      rtn_html << "<td style='text-align: center; #{today_color}'>"
      rtn_html << "<label id='col_syain_nisu_kei_#{i+1}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""
  end

  #バイトの入力欄作成
  def set_banto_row(user_id, loopcnt, select_where)
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #F7DC67;"
        else
          today_color =""
        end 
          
        rtn_html << "<td style='text-align: center;#{today_color}'>"

        unless d_duties[n].blank?

          if d_duties[n].day == (i + 1)
            if d_duties[n].all_work_time.to_f > 0
              rtn_html << "<label id='baito_#{i+1}_#{user_id}'>#{d_duties[n].all_work_time.to_f}</label>"
            else
              rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
            end
            
            n += 1
          else
            if d_duties[n].day >= i + 1
              rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
            end
            
          end
        else
          rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #F7DC67;"
        else
          today_color =""
        end
        rtn_html << "<td style='text-align: center;#{today_color}'>"
        rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
        rtn_html << "</td>"
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

    
  def d_duty_syain_nisu(select_where)
    return DDuty.find_by_sql("select count(*) nisu from d_duties where #{select_where} and day_work_time <> 0 ")
  end
  
  def d_duty_baito_jikan(select_where)
    return DDuty.find_by_sql("select sum(all_work_time) jikan from d_duties where #{select_where} ")
  end
end
