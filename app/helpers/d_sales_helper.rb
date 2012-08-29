module DSalesHelper
  
  def get_d_sales_data(select_date)

    #データ取得SQL
    select_sql = "select " 
    select_sql << " a.sale_date "
    select_sql << " , a.sale_money1 + sale_money2 + sale_money3 as sale_money "
    select_sql << " , a.sale_purika "
    select_sql << " , b.item_money purika_tesuryo "
    select_sql << " , c.item_money sonota_money "
    select_sql << " , a.recive_money "
    select_sql << " , a.pay_money " 
    select_sql << " , a.sale_ass "
    select_sql << " , a.sale_change1 + a.sale_change2 + a.sale_change3 as sale_change "
    select_sql << " , a.sale_today_out "
    select_sql << " , a.sale_am_out "
    select_sql << " , a.sale_pm_out "
    select_sql << " , a.sale_cashbox "
    select_sql << " , a.sale_changebox "
    
    select_sql << " from d_sales a "
    select_sql << " left join(select d_sale_id, sum(item_money) item_money from d_sale_items where m_shop_id = #{@head[:m_shop_id]} and item_class = 3 group by d_sale_id) b on a.id = b.d_sale_id "
    select_sql << " left join(select d_sale_id, sum(item_money) item_money from d_sale_items where m_shop_id = #{@head[:m_shop_id]} and item_class = 4 group by d_sale_id) c on a.id = c.d_sale_id "
    select_sql << " where a.m_shop_id = #{@head[:m_shop_id]} and a.sale_date = '#{select_date}' "
    select_sql << " order by a.sale_date  "
    
      
    #データ取得
    d_sales = DSale.find_by_sql(select_sql)

    if d_sales[0]
      #前日データを取得
      zenjitu = d_sales[0].sale_date
      zenjitu = (Date.new(zenjitu.to_s[0,4].to_i, zenjitu.to_s[4,2].to_i, zenjitu.to_s[6,2].to_i) - 1).strftime("%Y%m%d")
      
      zenjitu_d_sale = DSale.find(:first,
         :conditions=>["m_shop_id = ? and sale_date = ? ", @head[:m_shop_id], zenjitu])

    end
    
    unless zenjitu_d_sale
      zenjitu_d_sale = DSale.new
    end

    return d_sales[0], zenjitu_d_sale 


  end
end
