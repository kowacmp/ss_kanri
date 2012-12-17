# -*- coding:utf-8 -*-
module DDutiesHelper
  
  #人権費入力のユーザを取得する
  def get_user_dutry(user_class, m_shop_id, start_yyyy, start_mm, start_dd, end_dd)
    str_conditions = "m_shop_id= #{m_shop_id} and "
    str_conditions << " user_class in (#{user_class}) and "
    #2012/12/06 入社年月日属性変更対応
    #str_conditions << " nyusya_date <= '#{start_yyyy}/#{start_mm}/#{end_dd}' and "
    str_conditions << " nyusya_date <= '#{start_yyyy}#{start_mm}#{end_dd}' and "
    #2012/12/06 退職日追加対応 削除日→退職日
    #str_conditions << " (deleted_flg = 0 or (deleted_flg = 1 and deleted_at>= '#{start_yyyy}/#{start_mm}/#{start_dd}')) "
    str_conditions << " deleted_flg = 0 and (coalesce(taisyoku_date,'') = '' or (substring(taisyoku_date,1,6) >= '#{start_yyyy}#{start_mm}')) "
    p "str_conditions=#{str_conditions}"
    users = User.find(:all, 
              :conditions=>[str_conditions],
              :order => "duty_sort, duty_kbn_sort, account")
              

  end
  
  #社員の入力欄を作成
  #outputkbn->nilの場合は時間を送る
  #outputkbn->moneyの場合は金額を送る
  #outputkbn->time-moneyの場合は時間と金額(hidden)を送る
  def set_syain_row(input_ym, user_id, loopcnt, select_where, outputkbn=nil, d_today_color="#F7DC67")
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i and input_ym.to_s == Time.now.localtime.strftime("%Y%m")
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
        if Time.now.day.to_i == (i+1).to_i and input_ym.to_s == Time.now.localtime.strftime("%Y%m")
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
  def set_syain_nisu_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
#      if Time.now.day.to_i == (i+1).to_i
#        today_color = "background-color: #{d_today_color};"
#      else
#        today_color =""
#      end 
  
      rtn_html << "<td style='text-align: center; background-color:#A5D7AA'>"
      rtn_html << "<label id='col_syain_nisu_kei_#{i+1}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""
  end

  #バイトの入力欄作成
  #outputkbn->nilの場合は時間を送る
  #outputkbn->moneyの場合は金額を送る
  #outputkbn->time-moneyの場合は時間と金額(hidden)を送る
  def set_banto_row(input_ym, user_id, loopcnt, select_where, outputkbn=nil, d_today_color="#F7DC67")
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      
      loopcnt.times { |i|
        if Time.now.day.to_i == (i+1).to_i and input_ym.to_s == Time.now.localtime.strftime("%Y%m")
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
        if Time.now.day.to_i == (i+1).to_i and input_ym.to_s == Time.now.localtime.strftime("%Y%m")
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
  def set_baito_jikan_kei(loopcnt)

    rtn_html = ""
    
    loopcnt.times { |i|
#      if Time.now.day.to_i == (i+1).to_i
#        today_color = "background-color: #{d_today_color};"
#      else
#        today_color =""
#      end 
  
      rtn_html << "<td style='text-align: center; background-color:#A5D7AA'>"
      rtn_html << "<label id='col_baito_jikan_kei_#{i+1}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""
           
  end

  #表示する情報が何日まで表示するかを取得する
  def get_d_duty_output_day(input_day, m_shop_id)
    if @from_view == 'syoukai_menu'
      select_sql = "select day from d_duties where duty_nengetu=? and m_shop_id=? and kakutei_flg = 1 group by day"
    else
      select_sql = "select day from d_duties where duty_nengetu=? and m_shop_id=? and input_flg = 1 group by day"
    end
    select_days = DDuty.find_by_sql([select_sql, input_day.to_s, m_shop_id])
    if select_days[0].blank?
      return 0,"'0'"
    else
      ret_array = Array::new
      select_days.each_with_index{|select_day, index|
        ret_array[index] = "'#{input_day.to_s + format("%02d",select_day.day.to_i)}'"
      }
            
      return ret_array.count, ret_array.join(',')
    end
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
    d_duty = DDuty.count("kakutei_flg", :conditions=>["m_shop_id=? and duty_nengetu=? and day=? and kakutei_flg = 1", m_shop_id, duty_nengetu.to_s, day])

    if d_duty == 0
      return 0
    else
      return 1
    end    
  end
    
  #バイトの詳細合計を集計
  def calc_baito_total(total, d_dutry)
   
   unless d_dutry.blank?

     total[:day_work_time] = ((total[:day_work_time].to_f*10) + (d_dutry[:day_work_time].to_f*10)) / 10
     total[:day_over_time] = ((total[:day_over_time].to_f*10) + (d_dutry[:day_over_time].to_f*10)) / 10
     total[:night_work_time] = ((total[:night_work_time].to_f*10) + (d_dutry[:night_work_time].to_f*10)) / 10
     total[:night_over_time] = ((total[:night_over_time].to_f*10) + (d_dutry[:night_over_time].to_f*10)) / 10
     total[:all_work_time] = ((total[:all_work_time].to_f*10) + (d_dutry[:all_work_time].to_f*10)) / 10
     total[:get_money1] = total[:get_money1].to_i + d_dutry[:get_money1].to_i
     total[:get_money2] = total[:get_money2].to_i + d_dutry[:get_money2].to_i
     total[:get_money3] = total[:get_money3].to_i + d_dutry[:get_money3].to_i
     total[:get_money4] = total[:get_money4].to_i + d_dutry[:get_money4].to_i
   end
  end
  
  #勤続年月を求める
  def get_keika_ym(input_ym, nyusya_ym)
    #入社年月からの経過年月を求める
    input_y = input_ym.to_s[0,4].to_i
    input_m = input_ym.to_s[4,2].to_i

    nyusya_y = nyusya_ym[0,4].to_i
    nyusya_m = nyusya_ym[4,2].to_i
    
    if input_m < nyusya_m
      keika_m = 12 - nyusya_m + input_m
      input_y = input_y - 1
    else
      keika_m = input_m - nyusya_m
    end
    keika_y = input_y - nyusya_y
    
    tmp_str = ""
    tmp_str << "#{keika_y}年" unless keika_y ==0
    tmp_str << "#{keika_m}ヶ月"  
    
    return tmp_str
  end
  
  #ユーザ情報のランク名称を取得
  def get_user_rank_name(user_rank)
    
    m_code = MCode.where(:kbn => 'user_rank', :code => user_rank.to_s).first
    
    if m_code.blank?
      return ""
    else
      return m_code.code_name
    end
    
  end
  
end
