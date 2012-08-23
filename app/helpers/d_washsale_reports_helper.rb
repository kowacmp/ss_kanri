module DWashsaleReportsHelper
  def sum_d_washsale_item_meter(d_wash_sales,m_wash_id,wash_no)
    sum_meter = 0
    d_wash_sales.each do |d_wash_sale|
      sum_meter = sum_meter + 
        DWashsaleItem.find(:all,:conditions => ['d_wash_sale_id = ? and m_wash_id = ? and wash_no = ?',
          d_wash_sale.id,m_wash_id,wash_no]).first.meter
    end
    return sum_meter
  end
  
  def sum_d_washsale_item_gosa(d_wash_sales,m_wash_id)
    sum_meter = 0
    d_wash_sales.each do |d_wash_sale|
      sum_meter = sum_meter + 
        DWashsaleItem.find(:all,:conditions => ['d_wash_sale_id = ? and m_wash_id = ? and wash_no = 99',
          d_wash_sale.id,m_wash_id]).first.error_money
    end
    return sum_meter
  end
  
  def get_d_washsale_detail_report(d_washsale_report_id,wash_id,wash_no)
    DWashsaleDetailReport.find(:all, :conditions => ['d_washsale_report_id = ? and m_wash_id = ? and wash_no = ?', d_washsale_report_id,wash_id,wash_no]).first
  end
    
  def format_month(month)
      month = month.to_s
      if month.length == 1
        month = "0" + month
      else
        month = month
      end
    return month
  end
  
  def get_last_month(year, month)
    year  = year.to_i
    month = month.to_i
    
    if month == 1
      month = 12
      year = year -1
    else
      month = month -1
    end
    month = format_month(month)
    return year.to_s + month.to_s
  end    
end
