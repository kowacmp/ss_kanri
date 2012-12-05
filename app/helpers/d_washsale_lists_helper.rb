# -*- coding:utf-8 -*-
module DWashsaleListsHelper
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
  #2012/12/05 予備メーター入力件数取得追加
  #予備メーター入力件数取得
  def get_submeter_count_wash(m_shop_id,ymd)

    sql = <<-SQL
    SELECT count(*) as cnt FROM d_wash_sales
      INNER JOIN d_washsale_items
      ON d_wash_sales.id = d_washsale_items.d_wash_sale_id
      AND sub_meter is not null
      WHERE d_wash_sales.m_shop_id=?
      AND d_wash_sales.sale_date=?
    SQL
    submeter_count = DWashSale.find_by_sql([sql,m_shop_id,ymd]).first
    if submeter_count == nil
      cnt = 0
    else
      cnt = submeter_count.cnt
    end
    return cnt
  end

end
