module DYumePointListsHelper
  
  def sum_rows_yume_points(result_date,shop_kbn)
    sql = <<-SQL
      select sum(pos1_data) as pos1_data,sum(pos2_data) as pos2_data
      from d_result_oiletcs c,
      (select a.id from d_results a
       left join m_shops b
        on a.m_shop_id = b.id
       where result_date = ?
       and shop_kbn = ?) d
       where c.d_result_id = d.id
    SQL
    
    sum_yume_points = DResult.find_by_sql([sql,result_date,shop_kbn]).first
  end
  
  def get_yume_point(result_date,shop_id)
    d_result = DResult.where('result_date = ? and m_shop_id = ?',result_date,shop_id).first
    
    sql = <<-SQL
      select * from d_result_oiletcs a
        left join m_oiletcs b
        on a.m_oiletc_id = b.id
      where d_result_id = ?
        and b.oiletc_group = 2
    SQL
    
    if d_result == nil
      yume_point = nil
    else
      yume_point = DResultOiletc.find_by_sql([sql,d_result.id]).first
    end
    
    return yume_point
  end
  
end
