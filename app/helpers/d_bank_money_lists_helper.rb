module DBankMoneyListsHelper
  
  
  def get_bank_money(result_date,shop_id)
    
    #データ取得
    d_sale = DSale.find(:first,
                        :conditions=>["m_shop_id = ? and sale_date = ? ", shop_id, result_date])
                        
    if d_sale == nil
      return nil
    end
    
    #前日データを取得
    zenjitu = d_sale.sale_date
    zenjitu = (Date.new(zenjitu.to_s[0,4].to_i, zenjitu.to_s[4,2].to_i, zenjitu.to_s[6,2].to_i) - 1).strftime("%Y%m%d")
    
    zenjitu_d_sale = DSale.find(:first,
                                :conditions=>["m_shop_id = ? and sale_date = ? ", shop_id, zenjitu])
                                
    if zenjitu_d_sale == nil
      return nil
    end
    
    bank_money = zenjitu_d_sale.sale_pm_out.to_i + d_sale.sale_today_out.to_i -  d_sale.sale_ass.to_i + d_sale.sale_am_out.to_i
    
    return bank_money
  end
  
end
