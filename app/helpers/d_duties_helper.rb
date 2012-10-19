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
  #outputkbn->nilの場合は時間を送る
  #outputkbn->moneyの場合は金額を送る
  #outputkbn->time-moneyの場合は時間と金額(hidden)を送る
  def set_syain_row(user_id, loopcnt, select_where, outputkbn=nil, d_today_color="#F7DC67")
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #{d_today_color};";
        else
          today_color =""
        end 
        
        if outputkbn == "money"
          rtn_html << "<td style='text-align: right;#{today_color}'>"
        else
          rtn_html << "<td style='text-align: center;#{today_color}'>"
        end

        unless d_duties[n].blank?

          if d_duties[n].day == (i + 1)
            case outputkbn
              when "money"#金額をセット
                rtn_html << "<label id='syain_all_money_#{i+1}_#{user_id}'>#{num_fmt(d_duties[n].all_money)}</label>"
              when "time-money"#勤怠を表示して金額を隠しで出力
                if d_duties[n].day_work_time.to_i == 1
                  rtn_html << "<label id='syain_#{i+1}_#{user_id}'>出</label>"
                else
                  rtn_html << "<label id='syain_#{i+1}_#{user_id}' style='color:red'>休</label>"
                end
                rtn_html << hidden_field_tag("syain_all_money_#{i+1}_#{user_id}",d_duties[n].all_money)
              else
                if d_duties[n].day_work_time.to_i == 1
                  rtn_html << "<label id='syain_#{i+1}_#{user_id}'>出</label>"
                else
                  rtn_html << "<label id='syain_#{i+1}_#{user_id}' style='color:red'>休</label>"
                end
                rtn_html << hidden_field_tag("hiden_syain_#{i+1}_#{user_id}", d_duties[n].day_work_time.to_i)
            end
            
            
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
          today_color = "background-color: #{d_today_color};"
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
  def set_syain_nisu_kei(loopcnt, d_today_color="#F7DC67")
    rtn_html = ""
    
    loopcnt.times { |i|
      if Time.now.day.to_i == (i+1).to_i
        today_color = "background-color: #{d_today_color};"
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
  #outputkbn->nilの場合は時間を送る
  #outputkbn->moneyの場合は金額を送る
  #outputkbn->time-moneyの場合は時間と金額(hidden)を送る
  def set_banto_row(user_id, loopcnt, select_where, outputkbn=nil, d_today_color="#F7DC67")
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i
          today_color = "background-color: #{d_today_color};"
        else
          today_color =""
        end 
          
        if outputkbn == "money"
          rtn_html << "<td style='text-align: right;#{today_color}'>"
        else
          rtn_html << "<td style='text-align: center;#{today_color}'>"
        end

        unless d_duties[n].blank?

          if d_duties[n].day == (i + 1)
            case outputkbn
              when "money"#金額をセット
                rtn_html << "<label id='baito_all_money_#{i+1}_#{user_id}'>#{num_fmt(d_duties[n].all_money)}</label>"
              when "time-money"#勤怠を表示して金額を隠しで出力
                if d_duties[n].all_work_time.to_f > 0
                  rtn_html << "<label id='baito_#{i+1}_#{user_id}'>#{d_duties[n].all_work_time}</label>"
                else
                  rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
                end
                rtn_html << hidden_field_tag("baito_all_money_#{i+1}_#{user_id}",d_duties[n].all_money)
              else
                if d_duties[n].all_work_time.to_f > 0
                  rtn_html << "<label id='baito_#{i+1}_#{user_id}'>#{d_duties[n].all_work_time}</label>"
                else
                  rtn_html << "<label id='baito_#{i+1}_#{user_id}'></label>"
                end
            end
            
            if outputkbn == "money"
              #金額をセット
            else
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
          today_color = "background-color: #{d_today_color};"
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
  def set_baito_jikan_kei(loopcnt, d_today_color="#F7DC67")

    rtn_html = ""
    
    loopcnt.times { |i|
      if Time.now.day.to_i == (i+1).to_i
        today_color = "background-color: #{d_today_color};"
      else
        today_color =""
      end 
  
      rtn_html << "<td style='text-align: center; #{today_color}'>"
      rtn_html << "<label id='col_baito_jikan_kei_#{i+1}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""
           
  end

  #outputkbn->moneyの場合は金額を送る
  def d_duty_syain_total(select_where, outputkbn=nil)
    if outputkbn == "money"
      return DDuty.find_by_sql("select sum(all_money) all_money from d_duties where #{select_where}")
    else
      return DDuty.find_by_sql("select count(*) nisu from d_duties where #{select_where} and day_work_time <> 0 ")
    end
  end
  
  #outputkbn->moneyの場合は金額を送る
  def d_duty_baito_total(select_where, outputkbn=nil)
    if outputkbn == "money"
      return DDuty.find_by_sql("select sum(all_money) all_money from d_duties where #{select_where} ")
    else
      return DDuty.find_by_sql("select sum(all_work_time) jikan from d_duties where #{select_where} ")
    end    
  end
  
  #勤怠データの対象店舗の対象日の入力済みフラグを取得
  #入力済みフラグが立っているデータが１つでもあれば、１を返す。以外は０
  def get_d_dutie_input_flg(m_shop_id, duty_nengetu, day)
    d_duty = DDuty.count("input_flg", :conditions=>["m_shop_id=? and duty_nengetu=? and day=? and input_flg = 1", m_shop_id, duty_nengetu.to_s, day])

    if d_duty == 0
      return 0
    else
      return 1
    end
  end 
  
  
  #勤怠データの対象店舗の対象日の確定フラグを取得
  #確定フラグが立っているデータが１つでもあれば、１を返す。以外は０
  def get_d_dutie_kakutei_flg(m_shop_id, duty_nengetu, day)
    d_duty = DDuty.count("input_flg", :conditions=>["m_shop_id=? and duty_nengetu=? and day=? and kakutei_flg = 1", m_shop_id, duty_nengetu.to_s, day])

    if d_duty == 0
      return 0
    else
      return 1
    end    
  end
    
end
