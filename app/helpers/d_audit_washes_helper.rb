
module DAuditWashesHelper
  #2013/05/02 予備メーター入力取得
  def get_sub_meter(sale_date_from,sale_date_to,m_shop_id,m_wash_id)

    sql = <<-SQL
        select 
            a.sale_date
        from 
                     d_wash_sales     a 
          inner join d_washsale_items b
        on 
              a.id = b.d_wash_sale_id
        where 
                a.sale_date  >=  ? 
            and a.sale_date  <=  ?
            and a.m_shop_id  =  ?
            and b.m_wash_id   =  ?
            and (b.sub_meter !=  0 
            or (b.sub_meter = 0 and b.meter <> 0))
        order by
            a.sale_date
     
     SQL
    
    @d_wash_sales = DWashSale.find_by_sql([sql,sale_date_from,sale_date_to,m_shop_id,m_wash_id])
    return @d_wash_sales
  end
  
  #2013/05/02 誤差発生日取得
  def get_gosa(sale_date_from,sale_date_to,m_shop_id,m_wash_id)

      sql = <<-SQL
        select 
            a.sale_date
        from 
                     d_wash_sales     a 
          inner join d_washsale_items b
        on 
              a.id = b.d_wash_sale_id
        where 
                a.sale_date  >=  ? 
            and a.sale_date  <=  ?
            and a.m_shop_id  =  ?
            and b.m_wash_id   =  ?
            and b.wash_no     =  99
            and b.error_money !=  0
        order by
            a.sale_date
     
     SQL
    
    @d_wash_sales = DWashSale.find_by_sql([sql,sale_date_from,sale_date_to,m_shop_id,m_wash_id])
    return @d_wash_sales
  end
  
end
