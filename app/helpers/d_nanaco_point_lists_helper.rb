module DNanacoPointListsHelper
  
  def get_nanaco_point_num(result_date,shop_id)
    sql = <<-SQL
      SELECT COALESCE(sum(pos1_data),0) 
           + COALESCE(sum(pos2_data),0) 
           + COALESCE(sum(pos3_data),0) as nanacopoint_num
      FROM d_results a ,d_result_oiletcs b
       where a.id = b.d_result_id
         and b.m_oiletc_id = 31
         and a.m_shop_id = ?
         and a.result_date = ?
    SQL
    
    nanaco_point_num = DResultOiletc.find_by_sql([sql,shop_id,result_date]).first
    
    return nanaco_point_num
  end
  
  def get_nanaco_point(result_date,shop_id)

    sql = <<-SQL
      SELECT COALESCE(sum(pos1_data),0) 
           + COALESCE(sum(pos2_data),0) 
           + COALESCE(sum(pos3_data),0) as nanacopoint
      FROM d_results a ,d_result_oiletcs b
       where a.id = b.d_result_id
         and b.m_oiletc_id = 32
         and a.m_shop_id = ?
         and a.result_date = ?
    SQL
    
    nanaco_point = DResultOiletc.find_by_sql([sql,shop_id,result_date]).first
    
    return nanaco_point
  end
  
end
