#coding: utf-8
module DWashSalesHelper
  
  def get_zenkai_date(sale_date,shop_id,mode)
    if sale_date.length == 10
      sale_date = sale_date.delete("/")
    end
      if mode == 'list'
        zenkai_date = DWashSale.maximum(:sale_date,
          :conditions => ['sale_date < ? and m_shop_id = ?',sale_date,shop_id])
      else
        zenkai_date = DWashSale.maximum(:sale_date,
          :conditions => ['sale_date < ? and m_shop_id = ?',sale_date,current_user.m_shop_id])
      end
    return zenkai_date
  end
  
  def get_sum_meter(d_wash_sale_id,wash_id)
    DWashsaleItem.sum(:meter,
               :conditions => ['d_wash_sale_id = ? and m_wash_id = ? and wash_no <> 99',d_wash_sale_id,wash_id])    
  end
  
  def get_m_washes
   MWash.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'wash_cd')    
  end
  
  def get_m_washe(wash_cd)
    MWash.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ? and wash_cd = ? ",1,wash_cd] ).first    
  end
  
  #複数取得
  def get_d_wash_sales(hiduke)
      DWashSale.find(:all, :conditions => ["sale_date = ?",hiduke],:order => 'id')   
  end

  def get_d_wash_sales_month(month,m_shop_id)
      DWashSale.find(:all, 
      :conditions => ["sale_date between ? and ? and m_shop_id = ?",
        month + "01",month + "31",m_shop_id],
      :order => 'id')   
  end
    
  #単数取得
    def get_d_wash_sale(hiduke,m_shop_id,mode)
    if mode == 'list'
      DWashSale.find(:all, :conditions => ["sale_date = ? and m_shop_id = ?",hiduke,m_shop_id]).first      
    else
      DWashSale.find(:all, :conditions => ["sale_date = ? and m_shop_id = ?",hiduke,current_user.m_shop_id]).first
    end
  end
  
  #複数取得
  def get_d_washsale_items(d_wash_sale_id) 
    DWashsaleItem.find(:all, :conditions => ["d_wash_sale_id= ?",d_wash_sale_id], :order => 'm_wash_id,wash_no')
  end
  
  #単一取得
  def get_d_washsale_item(d_wash_sale_id,m_wash_id,wash_no) 
    DWashsaleItem.find(:all, 
    :conditions => ["d_wash_sale_id= ? and m_wash_id = ? and wash_no = ?",d_wash_sale_id,m_wash_id,wash_no]).first
  end
  
  def keisan_uriage(d_washsales_item,d_washsales_item_mae)
    unless d_washsales_item == nil || d_washsales_item_mae == nil
      if d_washsales_item.meter != 0 && d_washsales_item_mae.meter != 0
        d_washsales_item.meter - d_washsales_item_mae.meter
          else
          0
          end
        else
          0
        end
  end
  
=begin    
  #2012/10/03 nishimura
  #曜日取得
  def washsale_date_format(today, i)
    day = today + i.days
    #return_day = day.strftime("%d日")
    #wday = day_of_the_week(day.wday)
    return day
  end


  #2012/10/03 nishimura
  #登録フラグ取得
  def get_m_washsale_plan(m_shop_id,m_wash_id,wday)
    
    if wday == 0
      #"日"
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).sunday : 0
    elsif wday == 1
      #"月"      
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).monday : 0
    elsif wday == 2
      #"火"      
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).tuesday : 0
    elsif wday == 3
      #"水"      
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).wednesday : 0
    elsif wday == 4
      #"木"      
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).thursday : 0
    elsif wday == 5
      #"金"      
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).friday : 0
    elsif wday == 6
      #"土"    
      washsale_plan_flg = 
        MWashsalePlan.find(:first, 
                           :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]) ? 
          MWashsalePlan.find(:first, 
                             :conditions => ["m_shop_id = ? and m_wash_id = ? and deleted_flg = 0",m_shop_id,m_wash_id]).saturday : 0       
    end
    
    return washsale_plan_flg  
  end
=end
  
  #2013/05/28 
  #2012/10/03 nishimura
  #機種毎前回データ取得
  def get_wash_zenkai_date(sale_date,shop_id,wash_id,wash_no,mode)
    
    sql =  "   
         select max(c.sale_date) as sale_date from 
         (select a.sale_date,a.m_shop_id,b.m_wash_id,b.wash_no from 
         (select * from d_wash_sales) a 
         left join d_washsale_items b on  a.id = b.d_wash_sale_id and b.meter >= 0
         group by a.sale_date,a.m_shop_id,b.m_wash_id,b.wash_no 
         having a.sale_date < '#{sale_date}' 
            and a.m_shop_id = ? 
            and b.m_wash_id = #{wash_id} 
            and b.wash_no = #{wash_no} 
         order by a.sale_date,a.m_shop_id,b.m_wash_id,b.wash_no) c 
      "

    if sale_date.length == 10
      sale_date = sale_date.delete("/")
    end
      if mode == 'list'
        zenkai_date = DWashSale.find_by_sql([sql,shop_id]) ? DWashSale.find_by_sql([sql,shop_id]).first.sale_date : ''
      else
        zenkai_date = DWashSale.find_by_sql([sql,current_user.m_shop_id]) ? DWashSale.find_by_sql([sql,current_user.m_shop_id]).first.sale_date : ''
      end
    return zenkai_date
  end
  
end
