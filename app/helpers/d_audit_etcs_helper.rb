module DAuditEtcsHelper
  
  def get_sub_meter_etc(sale_date_from,sale_date_to,m_shop_id,m_wash_id)
    
    #予備メーターが発生した日を取得
    sql = <<-SQL
        select 
            a.sale_date
        from 
                     d_sale_etcs        a 
          inner join d_sale_etc_details b
        on 
              a.id = b.d_sale_etc_id
        where 
                a.sale_date  >=  ? 
            and a.sale_date  <=  ?
            and a.m_shop_id  =  ?
            and b.m_etc_id   =  ?
            and (b.sub_meter !=  0 
            or (b.sub_meter = 0 and b.meter <> 0))
        order by
            a.sale_date
     
     SQL
    
    @d_sale_etcs = DSaleEtc.find_by_sql([sql,sale_date_from,sale_date_to,m_shop_id,m_wash_id])
    return @d_sale_etcs
  end
    
  def get_gosa_etc(sale_date_from,sale_date_to,m_shop_id,m_wash_id)
    
    # 誤差が発生した日を取得
    sql = <<-SQL
        select 
            a.sale_date
        from 
                     d_sale_etcs        a 
          inner join d_sale_etc_details b
        on 
              a.id = b.d_sale_etc_id
        where 
                a.sale_date  >=  ?
            and a.sale_date  <=  ?
            and a.m_shop_id  =  ?
            and b.m_etc_id   =  ?
            and b.etc_no     =  99
            and b.error_money != 0
        order by
            a.sale_date
     
     SQL
    @d_sale_etcs = DSaleEtc.find_by_sql([sql,sale_date_from,sale_date_to,m_shop_id,m_wash_id])
    return @d_sale_etcs
  end
end
