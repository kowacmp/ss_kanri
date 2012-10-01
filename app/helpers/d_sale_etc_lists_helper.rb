# -*- coding:utf-8 -*-
module DSaleEtcListsHelper
  def change_week_mark(flg)
    if flg == 1
      "●"
    else
      ""
    end
  end
  
  def wday_hantei(wday,m_shop_id)
    if wday == 0
      wday_cnt = MWashsalePlan.sum("sunday"  ,:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 1
      wday_cnt = MWashsalePlan.sum("monday"  ,:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 2
      wday_cnt = MWashsalePlan.sum("tuesday"  ,:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 3
      wday_cnt = MWashsalePlan.sum("wednesday",:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 4
      wday_cnt = MWashsalePlan.sum("thursday" ,:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 5
      wday_cnt = MWashsalePlan.sum("friday"  ,:conditions => ['m_shop_id = ? ',m_shop_id])
    elsif wday == 6
      wday_cnt = MWashsalePlan.sum("saturday",:conditions => ['m_shop_id = ? ',m_shop_id])
    end
    
    return wday_cnt
  end
  
  #複数取得
  def get_d_sale_etcs(hiduke)
      DSaleEtc.find(:all, :conditions => ["sale_date = ?",hiduke],:order => 'id')   
  end
  
end
