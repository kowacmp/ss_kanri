module DResultOilListsHelper
  
  def get_pos_data(from_ymd,shop_id)

    sql = <<-SQL
      select COALESCE(b.pos_data,0) as pos_data from m_oils a
      left join 
      (
      select COALESCE(b2.pos1_data,0) + COALESCE(b2.pos2_data,0) + COALESCE(b2.pos3_data,0) as pos_data, b2.m_oil_id
            from d_results b1
            left join d_result_oils b2 on b1.id = b2.d_result_id
            where b1.result_date = ?
            and b1.m_shop_id = ?
      ) b on a.id = b.m_oil_id
      where deleted_flg = 0
      order by oil_cd
    SQL
    
    return MOil.find_by_sql([sql,from_ymd,shop_id])
  end
  
  def get_result_oil_list_shops(shop_kbn)
    if shop_kbn == nil or shop_kbn == ""
      m_shops = MShop.where('deleted_flg = 0 and shop_cd <> 999999').order('shop_cd')
    else
      m_shops = MShop.where('deleted_flg = 0 and shop_cd <> 999999 and shop_kbn = ?',shop_kbn).order('shop_cd')
    end
    return m_shops
  end  
end
