class DTankDecreaseReportsController < ApplicationController
  def index
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    @input_ymd_s = @input_ymd.delete("/")
    
    @rerports = DTankDecreaseReport.find_by_sql(['select a.*,b.result_date,b.kakutei_flg,c.id as shop_id,
           c.shop_cd,c.shop_name,c.shop_ryaku,d.group_name
           from d_tank_decrease_reports a,d_results b,m_shops c,m_shop_groups d
           where a.d_result_id = b.id
             and b.m_shop_id = c.id
             and a.m_shop_group_id = d.id
             and b.result_date = ?
           order by m_shop_group_id,c.id',@input_ymd_s])
  end

  def print
  end

end
