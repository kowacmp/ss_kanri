#coding: utf-8
module DWashSalesHelper
  def get_m_washes
   MWash.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'wash_cd')    
  end
  
  def get_d_wash_sale(hiduke)
    DWashSale.find(:all, :conditions => ["sale_date = ? and m_shop_id = ?",hiduke,current_user.m_shops_id]).first
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
  
  def keisan_uriage(d_washsales_item,d_washsales_item_yesterday)
    unless d_washsales_item == nil || d_washsales_item_yesterday == nil
      if d_washsales_item.meter != 0 && d_washsales_item_yesterday.meter != 0
        d_washsales_item.meter - d_washsales_item_yesterday.meter
          else
          0
          end
        else
          0
        end
  end
  
end
