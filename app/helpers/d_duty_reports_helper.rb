module DDutyReportsHelper
  #人件費合計
  def set_jinken_kei(loopcnt)
    rtn_html = ""
    
    loopcnt.times { |i|
      rtn_html << "<td style='text-align: right;'>"
      rtn_html << "<label id='col_jinken_kei_#{i+1}'></label>"
      rtn_html << "</td>"
     }   
     rtn_html << ""    
  end
  
  #洗車売上合計取得
  def d_result_total_sensya(select_where)
    return DResultSelfReport.find_by_sql("select sum(sensya) sensya from d_result_self_reports a inner join d_results b on a.d_result_id = b.id where #{select_where}")
  end
  
  #油外売上合計取得
  def d_result_total_yugai(select_where)
    return DResultReport.find_by_sql("select sum(arari) arari from d_result_reports a inner join d_results b on a.d_result_id = b.id where #{select_where}")
  end
  
  #洗車売上（日）作成
  def set_sensya_row(loopcnt, select_where)
    rtn_html = ""
    d_result_self_report = DResultSelfReport.find_by_sql("select b.result_date, a.* from d_result_self_reports a inner join d_results b on a.d_result_id = b.id where #{select_where} order by result_date")
    
    unless d_result_self_report.blank?
      n = 0
      
      loopcnt.times { |i|
        rtn_html << "<td style='text-align: right;background-color: #99E562;'>"

        unless d_result_self_report[n].blank?

          if d_result_self_report[n].result_date.to_s[6,2].to_i == (i + 1)

              #金額をセット
              rtn_html << "<label id='col_result_#{i+1}'>#{num_fmt(d_result_self_report[n].sensya)}</label>"
            
            n += 1
          end
        else
          rtn_html << "<label id='col_result_#{i+1}'></label>"
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        rtn_html << "<td style='text-align: right;background-color: #99E562;'>"
        rtn_html << "<label id='col_result_#{i+1}'></label>"
        rtn_html << "</td>"
      }
    end
    rtn_html << ""    
  end
  
  #油外売上（日）作成
  def set_yugai_row(loopcnt, select_where)
    rtn_html = ""
    d_result_report = DResultReport.find_by_sql("select b.result_date, a.* from d_result_reports a inner join d_results b on a.d_result_id = b.id where #{select_where} order by result_date")
    
    unless d_result_report.blank?
      n = 0
      
      loopcnt.times { |i|
        rtn_html << "<td style='text-align: right;background-color: #99E562;'>"

        unless d_result_report[n].blank?

          if d_result_report[n].result_date.to_s[6,2].to_i == (i + 1)

              #金額をセット
              rtn_html << "<label id='col_result_#{i+1}'>#{num_fmt(d_result_report[n].arari)}</label>"
            
            n += 1
          end
        else
          rtn_html << "<label id='col_result_#{i+1}'></label>"
        end
        rtn_html << "</td>"
      }
    else
      #データがなかったら空枠を作成
      loopcnt.times { |i|
        rtn_html << "<td style='text-align: right;background-color: #99E562;'>"
        rtn_html << "<label id='col_result_#{i+1}'></label>"
        rtn_html << "</td>"
      }
    end
    rtn_html << ""     
  end
  
end
