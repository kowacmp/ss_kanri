module DYumePointListsHelper
  
  def sum_rows_yume_points(result_date,shop_kbn)
    sql = <<-SQL
      SELECT COALESCE(sum(yumepoint_num),0)   as yumepoint_num,
             COALESCE(sum(yumepoint),0)       as yumepoint,
             COALESCE(sum(yumepoint_money),0) as yumepoint_money,
             COALESCE(sum(pay_money),0)       as pay_money
      FROM d_results a ,d_result_yumepoints b,m_shops c
       where a.id = b.d_result_id
         and result_date = ?
         and a.m_shop_id = c.id
         and c.shop_kbn = ?
    SQL
    
    sum_yume_points = DResult.find_by_sql([sql,result_date,shop_kbn]).first
  end
  
  def get_yume_point(result_date,shop_id)
    #d_result = DResult.where('result_date = ? and m_shop_id = ?',result_date,shop_id).first
    
    sql = <<-SQL
      SELECT COALESCE(sum(yumepoint_num),0)   as yumepoint_num,
             COALESCE(sum(yumepoint),0)       as yumepoint,
             COALESCE(sum(yumepoint_money),0) as yumepoint_money,
             COALESCE(sum(pay_money),0)       as pay_money
      FROM d_results a ,d_result_yumepoints b
       where a.id = b.d_result_id
         and a.m_shop_id = ?
         and result_date = ?
    SQL
    
    #if d_result == nil
    #  yume_point = nil
    #else
      yume_point = DResultOiletc.find_by_sql([sql,shop_id,result_date]).first
    #end
    
    return yume_point
  end
  
end
