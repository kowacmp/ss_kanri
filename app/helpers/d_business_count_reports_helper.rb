module DBusinessCountReportsHelper
  
  def get_d_aim_total(ym,shop_id,aim_id)
    aim = DAim.where(:date => ym,:m_shop_id => shop_id,
           :m_aim_id => aim_id).select('id,date,m_shop_id,m_aim_id,aim_total').first
    unless aim == nil
      aim.aim_total
    else
      0
    end
  end  
  
  def get_result(result_date,shop_id)
    DResult.where(:result_date => result_date,:m_shop_id => shop_id).first
  end
  
  def get_results(start_ymd,end_ymd,shop_id)
    DResult.where(:result_date => start_ymd..end_ymd,:m_shop_id => shop_id)
  end
  
  def get_d_result_collect(results,m_aim_id)
    sum_get_num = 0
    get_num = 0
    results.each do |result|
      dr_collect = DResultCollect.where(:d_result_id => result.id,:m_oiletc_id => m_aim_id).first
      if dr_collect == nil
        get_num = 0
      else
        get_num = dr_collect.get_num
      end
      sum_get_num = sum_get_num + get_num
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
  
  def get_d_result_oiletc_daily(d_result,m_oiletc_id)
    sum_oiletc = 0
    pos1 = 0
    pos2 = 0
    pos3 = 0
    unless d_result == nil
      d_resutl_oiletc = DResultOiletc.where(:d_result_id => d_result.id,:m_oiletc_id => m_oiletc_id).first
    else
      d_resutl_oiletc = nil
    end
    unless d_resutl_oiletc == nil
      if d_resutl_oiletc.pos1_data == nil
        pos1 = 0
      else
        pos1 = d_resutl_oiletc.pos1_data
      end
      if d_resutl_oiletc.pos2_data == nil
        pos2 = 0
      else
        pos2 = d_resutl_oiletc.pos2_data
      end
      if d_resutl_oiletc.pos3_data == nil
        pos3 = 0
      else
        pos3 = d_resutl_oiletc.pos3_data
      end
     sum_oiletc = pos1 + pos2 + pos3
    else
      sum_oiletc = 0
    end 
    return sum_oiletc.to_i
  end
  
  def get_count_d_result_reserve_day(result_date,reserve_nengetu,shop_id)
    sql = <<-SQL
       SELECT reserve_num as cnt,reserve_nengetu FROM d_results a ,d_result_reserves b
       where a.id = b.d_result_id
         and a.m_shop_id = ?
         and a.result_date = ?
         and reserve_nengetu = ?
    SQL
    reserve = DResultReserve.find_by_sql([sql,shop_id,result_date,reserve_nengetu]).first
    if reserve == nil
      cnt = 0
    else
      cnt = reserve.cnt
    end
    return cnt
  end
  
  def get_count_d_result_reserve_month(ym,shop_id)
    sql = <<-SQL
    SELECT COALESCE(sum(reserve_num),0) as cnt FROM d_results a ,d_result_reserves b
       where a.id = b.d_result_id
         and a.m_shop_id = ?
         and reserve_nengetu = ?
    SQL
    reserve = DResultReserve.find_by_sql([sql,shop_id,ym]).first
    if reserve == nil
      cnt = 0
    else
      cnt = reserve.cnt
    end
    return cnt
  end
  
  def get_from_and_to_ymd(tmp_ymd,mode)
    if mode == 1 #from_ymd
      return_ymd = tmp_ymd.strftime("%Y%m") + '01'
    else #to_ymd
      return_ymd = tmp_ymd.strftime("%Y%m") + '31'
    end
  end
  
  def get_d_result_collect_get_num(d_result,m_aim_id)
    unless d_result == nil
      d_result_collect = DResultCollect.where(:d_result_id => d_result.id,:m_oiletc_id => m_aim_id).first
      if d_result_collect == nil
        0
      else
        d_result_collect.get_num
      end
    else
      0
    end
  end
end
