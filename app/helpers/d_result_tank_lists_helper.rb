module DResultTankListsHelper
  
  def get_sum_stock(from_ymd,to_ymd,shop_id,oil_id)
    sql = <<-SQL
      select COALESCE(sum(stock),0) as stock from d_results a,d_result_tanks b,m_tanks c
      where result_date between ? and ?
      and a.id = b.d_result_id
      and a.m_shop_id = ?
      and c.id = b.m_tank_id
      and c.m_oil_id = ?
    SQL
    
    DResultTank.find_by_sql([sql,from_ymd,to_ymd,shop_id,oil_id]).first.stock
  end
end
