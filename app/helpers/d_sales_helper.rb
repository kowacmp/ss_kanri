module DSalesHelper
  
  def get_d_sales_data(select_date)

    #データ取得SQL
    select_sql = "select " 
    select_sql << " a.sale_date "
    select_sql << " , cast(a.sale_money1 as int) + cast(sale_money2 as int) + cast(sale_money3 as int) as sale_money "
    select_sql << " , a.sale_purika "
    select_sql << " , b.item_money purika_tesuryo "
    select_sql << " , c.item_money sonota_money "
    select_sql << " , a.recive_money "
    select_sql << " , a.pay_money " 
    select_sql << " , a.sale_ass "
    # 2012/09/25 ﾚｲｱｳﾄ修正 小田 start
    #select_sql << " , cast(a.sale_change1 as int) + cast(a.sale_change2 as int) + cast(a.sale_change3 as int) as sale_change "
    select_sql << " , cast(a.sale_change1 as int) + cast(a.sale_change2 as int) + cast(a.sale_change3 as int) + cast(a.sale_etc as int)as sale_change "
    # 2012/09/25 ﾚｲｱｳﾄ修正 小田 end
    select_sql << " , a.sale_today_out "
    select_sql << " , a.sale_am_out "
    select_sql << " , a.sale_pm_out "
    select_sql << " , a.sale_cashbox "
    select_sql << " , a.sale_changebox "
    select_sql << " , a.exist_money "
    select_sql << " , a.over_short "
    select_sql << " , a.balance_money "
    
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

    d_sale = d_sales[0]
    if d_sale then
       @d_sale_ass = zenjitu_d_sale.sale_pm_out.to_i + d_sale.sale_today_out.to_i + d_sale.sale_am_out.to_i   #ASS入金額
       @d_sale_syokei = d_sale.sale_money.to_i + d_sale.sale_purika.to_i + d_sale.sonota_money.to_i + d_sale.purika_tesuryo.to_i - d_sale.pay_money.to_i #小計
       # 2012/09/25 ﾚｲｱｳﾄ修正 小田 start
       #@zenjitu_d_sale_cash_arigaka = zenjitu_d_sale.sale_change1.to_i + zenjitu_d_sale.sale_change2.to_i + zenjitu_d_sale.sale_change3.to_i + zenjitu_d_sale.sale_cashbox.to_i
       @zenjitu_d_sale_cash_arigaka = zenjitu_d_sale.sale_change1.to_i + zenjitu_d_sale.sale_change2.to_i + zenjitu_d_sale.sale_change3.to_i  + zenjitu_d_sale.sale_etc.to_i + zenjitu_d_sale.sale_cashbox.to_i
       # 2012/09/25 ﾚｲｱｳﾄ修正 小田 end
       #@d_sale_calc_aridaka = @zenjitu_d_sale_cash_arigaka.to_i + @d_sale_syokei.to_i + @d_sale.sale_ass.to_i + @d_sale_ass.to_i
       @d_sale_cash_aridaka = d_sale.exist_money
       @calc_exist_money = ((d_sale.exist_money.to_i * -1) + d_sale.over_short.to_i) * -1
       @balance_money = d_sale.balance_money.to_i
    end
    
    return d_sale, zenjitu_d_sale 


  end
  
  #
  def calc_total(d_sale_total,init = false)
    return_hash = d_sale_total
    
    if init 
      return_hash[:sale_money] = ""
      return_hash[:sale_purika] = ""
      return_hash[:purika_tesuryo] = ""
      return_hash[:sonota_money] = ""
      return_hash[:recive_money] = ""
      return_hash[:pay_money] = ""
      return_hash[:d_sale_syokei] = ""
      return_hash[:sale_ass] = ""
      return_hash[:d_sale_ass] = ""
      return_hash[:zenjitu_d_sale_sale_pm_out] = ""
      return_hash[:sale_today_out] = ""
      return_hash[:sale_am_out] = ""
      return_hash[:sale_pm_out] = ""
      return_hash[:d_sale_calc_aridaka] = ""
      return_hash[:d_sale_cash_aridaka] = ""
      return_hash[:kabusoku] = ""
    end
    
    if @d_sale
      return_hash[:sale_money] = return_hash[:sale_money].to_i + @d_sale.sale_money.to_i
      return_hash[:sale_purika] = return_hash[:sale_purika].to_i + @d_sale.sale_purika.to_i
      return_hash[:purika_tesuryo] = return_hash[:purika_tesuryo].to_i + @d_sale.purika_tesuryo.to_i
      return_hash[:sonota_money] = return_hash[:sonota_money].to_i + @d_sale.sonota_money.to_i
      return_hash[:recive_money] = return_hash[:recive_money].to_i + @d_sale.recive_money.to_i
      return_hash[:pay_money] = return_hash[:pay_money].to_i + @d_sale.pay_money.to_i
      return_hash[:d_sale_syokei] = return_hash[:d_sale_syokei].to_i + @d_sale_syokei.to_i
      return_hash[:sale_ass] = return_hash[:sale_ass].to_i + @d_sale.sale_ass.to_i
      return_hash[:d_sale_ass] = return_hash[:d_sale_ass].to_i + @d_sale_ass.to_i
      return_hash[:zenjitu_d_sale_sale_pm_out] = return_hash[:zenjitu_d_sale_sale_pm_out].to_i + @zenjitu_d_sale.sale_pm_out.to_i
      return_hash[:sale_today_out] = return_hash[:sale_today_out].to_i + @d_sale.sale_today_out.to_i
      return_hash[:sale_am_out] = return_hash[:sale_am_out].to_i + @d_sale.sale_am_out.to_i
      return_hash[:sale_pm_out] = return_hash[:sale_pm_out].to_i + @d_sale.sale_pm_out.to_i
      return_hash[:d_sale_calc_aridaka] = return_hash[:d_sale_calc_aridaka].to_i + @calc_exist_money.to_i
      return_hash[:d_sale_cash_aridaka] = return_hash[:d_sale_cash_aridaka].to_i + @d_sale.exist_money.to_i
      return_hash[:kabusoku] = return_hash[:kabusoku].to_i + @d_sale.over_short.to_i
    end  
    return return_hash

  end
  
end
