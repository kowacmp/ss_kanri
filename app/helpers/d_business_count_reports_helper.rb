module DBusinessCountReportsHelper
  
  def get_d_aim(ym,shop_id,aim_id)
    DAim.where(:date => ym,:m_shop_id => shop_id,
           :m_aim_id => aim_id).select('id,date,m_shop_id,m_aim_id,aim_total').first
  end  
  
  def get_result(result_date,shop_id)
    DResult.where(:result_date => result_date,:m_shop_id => shop_id).first
  end
  
  def get_results(start_ymd,end_ymd,shop_id)
    DResult.where(:result_date => start_ymd..end_ymd,:m_shop_id => shop_id)
  end
  
  def get_d_result_collect(results,m_aim_id)
    sum_get_num = 0
    results.each do |result|
      sum_get_num = sum_get_num + DResultCollect.where(:d_result_id => result.id,:m_oiletc_id => m_aim_id).first.get_num
    end
    return sum_get_num
  end
  
  def get_d_result_oiletc(results,m_aim_id)
    sum_get_num = 0
    results.each do |result|
      data = DResultOiletc.where(:d_result_id => result.id,:m_oiletc_id => m_aim_id).first
      unless data == nil
        sum_get_num = sum_get_num + (data.pos1_data.to_i + data.pos2_data.to_i + data.pos3_data.to_i)
      end
    end
    return sum_get_num
  end
  
  def get_d_result_oiletc_daily(d_result_id,m_oiletc_id)
    sum_oiletc = nil
    d_resutl_oiletc = DResultOiletc.where(:d_result_id => d_result_id,:m_oiletc_id => m_oiletc_id).first
    unless d_resutl_oiletc == nil
     sum_oiletc = d_resutl_oiletc.pos1_data + d_resutl_oiletc.pos2_data + d_resutl_oiletc.pos3_data
    end 
    return sum_oiletc
  end
  
  def get_count_d_result_reserve_day(get_date,shop_id)
    sql = <<-SQL
      SELECT count(*) as cnt FROM d_results a ,d_result_reserves b
       where a.id = b.d_result_id
         and a.m_shop_id = ?
         and b.get_date = ?
    SQL
    DResultReserve.find_by_sql([sql,shop_id,get_date]).first.cnt
  end
  
  def get_count_d_result_reserve_month(from_ymd,to_ymd,shop_id)
    sql = <<-SQL
      SELECT count(*) as cnt FROM d_results a ,d_result_reserves b
       where a.id = b.d_result_id
         and a.m_shop_id = ?
         and b.get_date between ? and ?
    SQL
    DResultReserve.find_by_sql([sql,shop_id,from_ymd,to_ymd]).first.cnt
  end
  
  def get_from_and_to_ymd(tmp_ymd,mode)
    if mode == 1 #from_ymd
      return_ymd = tmp_ymd.strftime("%Y%m") + '01'
    else #to_ymd
      return_ymd = tmp_ymd.strftime("%Y%m") + '31'
    end
  end
end
