module DResultsHelper
  def m_oiletc_sql(d_result, oiletc_group)
    sql = "select m.id, m.oiletc_name, m.oiletc_tani, d.pos1_data, d.pos2_data, d.pos3_data"
    sql << " from m_oiletcs m left join d_result_oiletcs d"
    sql << "   on (m.id = d.m_oiletc_id "
    if d_result.blank?
      sql << " and d.d_result_id is null)"
    else
      sql << " and d.d_result_id = #{d_result.id})"  
    end
    
    sql << " where m.oiletc_group = #{oiletc_group} and m.deleted_flg = 0 order by m.oiletc_cd" 

    return sql  
  end
  
  def syukei_data(d_result, select_date)
    p "syukei_data   syukei_data   syukei_data"
    if d_result.blank?
      now = Time.parse(select_date)
      result_date = Time.parse(select_date).strftime("%Y%m%d")
    else  
      now = Time.parse(d_result.result_date)
      result_date = d_result.result_date
    end
    
    @syukei_reserves = Array.new
    
    for i in 0..4
      ymd = now + i.months
      start_ymd = ymd.strftime("%Y%m") + "01"
      end_ymd = ymd.strftime("%Y%m") + "31"
      
      if d_result.blank?
        nikkei_count = 0
      else  
        #日計
        nikkei_count = DResultReserve.count(:conditions => ["d_result_id = ? and get_date between ? and ?",
                                                            d_result.id, start_ymd, end_ymd])
      end
             
      #累計                                                        
      sql = "select count(*) from d_result_reserves r, d_results d"
      sql << " where r.d_result_id = d.id and d.result_date <= '#{result_date}'"
      sql << "   and r.get_date between '#{start_ymd}' and '#{end_ymd}'"
    
      ruikei = DResultReserve.find_by_sql(sql) 
      

      @syukei_reserves[i] = Hash::new
      @syukei_reserves[i][:month] = ymd.strftime("%m")
      @syukei_reserves[i][:nikkei] = nikkei_count
      @syukei_reserves[i][:ruikei] = ruikei[0].count
    end    
  end
end
