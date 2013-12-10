module DNanacoPointListsHelper
  
  def get_nanaco_point(result_date,shop_kbn)

    sql = <<-SQL
      SELECT ms.shop_cd,ms.shop_ryaku ,COALESCE(np1.nanacopoint_num,0) nanacopoint_num
                                      ,COALESCE(np2.nanacopoint,0) nanacopoint
      FROM m_shops ms
      LEFT JOIN (
                  select a.m_shop_id,COALESCE(sum(pos1_data),0) 
                                   + COALESCE(sum(pos2_data),0) 
                                   + COALESCE(sum(pos3_data),0) as nanacopoint_num
                  from d_results a ,d_result_oiletcs b
                  where a.id = b.d_result_id
                    and b.m_oiletc_id = 31
                    and a.result_date = ?
                  group by a.m_shop_id
                 ) np1 
      ON ms.id = np1.m_shop_id
      LEFT JOIN (
                  select a.m_shop_id,COALESCE(sum(pos1_data),0) 
                                   + COALESCE(sum(pos2_data),0) 
                                   + COALESCE(sum(pos3_data),0) as nanacopoint
                  from d_results a ,d_result_oiletcs b
                  where a.id = b.d_result_id
                    and b.m_oiletc_id = 32
                    and a.result_date = ?
                  group by a.m_shop_id
                 ) np2 
      ON ms.id = np2.m_shop_id
      WHERE ms.shop_kbn = ?
      ORDER BY ms.shop_cd
    SQL
    
    nanaco_point = DResultOiletc.find_by_sql([sql,result_date,result_date,shop_kbn])
    
    return nanaco_point
  end
  
  def get_nanaco_point_total(date_from,date_to,shop_kbn)

    sql = <<-SQL
      SELECT COALESCE(sum(np1.nanacopoint_num),0) nanacopoint_num
            ,COALESCE(sum(np2.nanacopoint),0) nanacopoint
      FROM m_shops ms
      LEFT JOIN (
                  select a.m_shop_id,COALESCE(sum(pos1_data),0) 
                                   + COALESCE(sum(pos2_data),0) 
                                   + COALESCE(sum(pos3_data),0) as nanacopoint_num
                  from d_results a ,d_result_oiletcs b
                  where a.id = b.d_result_id
                    and b.m_oiletc_id = 31
                    and (a.result_date >= ? and a.result_date <= ? )
                  group by a.m_shop_id
                 ) np1 
      ON ms.id = np1.m_shop_id
      LEFT JOIN (
                  select a.m_shop_id,COALESCE(sum(pos1_data),0) 
                                   + COALESCE(sum(pos2_data),0) 
                                   + COALESCE(sum(pos3_data),0) as nanacopoint
                  from d_results a ,d_result_oiletcs b
                  where a.id = b.d_result_id
                    and b.m_oiletc_id = 32
                    and (a.result_date >= ? and a.result_date <= ? )
                  group by a.m_shop_id
                 ) np2 
      ON ms.id = np2.m_shop_id
      WHERE ms.shop_kbn = ?
    SQL
    
    nanaco_point_total = DResultOiletc.find_by_sql([sql,date_from,date_to,date_from,date_to,shop_kbn]).first
    
    return nanaco_point_total
  end
  
end
