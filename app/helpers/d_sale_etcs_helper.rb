#coding: utf-8
module DSaleEtcsHelper
  
  def get_zenkai_date1(sale_date,shop_id,mode)
    if sale_date.length == 10
      sale_date = sale_date.delete("/")
    end
      if mode == 'list'
        zenkai_date = DSaleEtc.maximum(:sale_date,
          :conditions => ['sale_date < ? and m_shop_id = ?',sale_date,shop_id])
      else
        zenkai_date = DSaleEtc.maximum(:sale_date,
          :conditions => ['sale_date < ? and m_shop_id = ?',sale_date,current_user.m_shop_id])
      end
    return zenkai_date
  end
  
  def get_sum_meter(d_sale_etc_id,etc_id)
    DSaleEtcDetail.sum(:meter,
               :conditions => ['d_sale_etc_id = ? and m_etc_id = ? and etc_no <> 99',d_sale_etc_id,etc_id])    
  end
  
  def get_m_etcs
   MEtc.find(:all, :conditions => ["(deleted_flg is null or deleted_flg <> ?) and kansa_flg = 0",1], :order => 'etc_cd')    
  end
  
  def get_m_etc(etc_id)
    #MEtc.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ? and etc_cd = ? ",1,etc_cd] ).first
    MEtc.find(etc_id)    
  end
  
  def get_d_sale_etc(hiduke,m_shop_id,mode)
    if mode == 'list' then
      DSaleEtc.find(:all, :conditions => ["sale_date = ? and m_shop_id = ?",hiduke,m_shop_id]).first
    else
      DSaleEtc.find(:all, :conditions => ["sale_date = ? and m_shop_id = ?",hiduke,current_user.m_shop_id]).first
    end
  end
  
  #複数取得
  def get_d_sale_etc_details(d_sale_etc_id) 
    DSaleEtcDetail.find(:all, :conditions => ["d_sale_etc_id= ?",d_sale_etc_id], :order => 'm_etc_id,etc_no')
  end
  
  #単一取得
  def get_d_sale_etc_detail(d_sale_etc_id,m_etc_id,etc_no) 
    DSaleEtcDetail.find(:all, 
    :conditions => ["d_sale_etc_id= ? and m_etc_id = ? and etc_no = ?",d_sale_etc_id,m_etc_id,etc_no]).first
  end
  
  def keisan_uriage(d_sale_etc_deail,d_sale_etc_deail_mae)
    unless d_sale_etc_deail == nil || d_sale_etc_deail_mae == nil
      if d_sale_etc_deail.meter != 0 && d_sale_etc_deail_mae.meter != 0
        d_sale_etc_deail.meter - d_sale_etc_deail_mae.meter
      else
        0
      end
    else
      0
    end
  end
  
  #2012/10/04 nishimura
  #機種毎前回データ取得
  def get_etc_zenkai_date(sale_date,shop_id,etc_id,etc_no,mode)
    
    sql =  "   
         select max(c.sale_date) as sale_date from 
         (select a.sale_date,a.m_shop_id,b.m_etc_id,b.etc_no from 
         (select * from d_sale_etcs) a 
         left join d_sale_etc_details b on  a.id = b.d_sale_etc_id and b.meter > 0
         group by a.sale_date,a.m_shop_id,b.m_etc_id,b.etc_no 
         having a.sale_date < '#{sale_date}' 
            and a.m_shop_id = ?
            and b.m_etc_id = #{etc_id} 
            and b.etc_no = #{etc_no} 
         order by a.sale_date,a.m_shop_id,b.m_etc_id,b.etc_no) c 
      "
    
    if sale_date.length == 10
      sale_date = sale_date.delete("/")
    end
      if mode == 'list'
        zenkai_date = DSaleEtc.find_by_sql([sql,shop_id]) ? DSaleEtc.find_by_sql([sql,shop_id]).first.sale_date : ''
      else
        zenkai_date = DSaleEtc.find_by_sql([sql,current_user.m_shop_id]) ? DSaleEtc.find_by_sql([sql,current_user.m_shop_id]).first.sale_date : ''
      end
    return zenkai_date
  end
  
end
