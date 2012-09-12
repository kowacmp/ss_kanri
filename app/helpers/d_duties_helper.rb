module DDutiesHelper
  
  #社員の入力欄を作成
  def set_syain_row(index, loopcnt, select_where)
    rtn_html = ""
    d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    unless d_duties.blank?
      n = 0
      loopcnt.times { |i|
        
        unless d_duties[n].blank?
          p n
          p d_duties[n].day
          if d_duties[n].day == (i + 1)
            rtn_html << "<td style='text-align: center;'><label id='syain_#{i+1}_#{index}'>#{d_duties[n].day_work_time}</label></td>"
            n += 1
          else
            if d_duties[n].day >= i + 1
              rtn_html << "<td><label id='syain_#{i+1}_#{index}'></label></td>"
            end
            
          end
        else
          rtn_html << "<td><label id='syain_#{i+1}_#{index}'></label></td>"
        end
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        rtn_html << "<td><label id='syain_#{i+1}_#{index}'></label></td>"
        
      }
    end
    rtn_html << ""
  end
  
  def set_syain_nisu_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
      
      rtn_html << "<td style='text-align: center;'>"
      #rtn_html << "<label id='syain_nisu_kei_#{i}'></label>"
      rtn_html << "</td>"
     }    
  end

end
