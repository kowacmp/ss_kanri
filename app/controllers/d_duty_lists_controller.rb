
class DDutyListsController < ApplicationController
  def index
    search
  end

  def search
    
    if params[:date] == nil
      @input_ymd = Time.now
      @input_ym_s = Time.now.strftime("%Y%m")
      @shop_kbn = 0
    else
      @input_ymd = Date.new(params[:date][:year].to_i,params[:date][:month].to_i,1)
      @input_ym_s = Date.new(params[:date][:year].to_i,params[:date][:month].to_i,1).strftime("%Y%m")
      @shop_kbn = params[:shop_kbn]
    end
    
    #selectboxの選択年度を設定
    @start_year = Time.now.localtime.strftime("%Y").to_i - 1
    
    select_sql = "select a.*,b.*,c.code_name as shop_kbn_name "
    select_sql << " from m_shops a " 
    select_sql << " left join ( "
    select_sql << " select duty_nengetu,m_shop_id,max(day) as last_day from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' "
    select_sql << " ) b on a.id = b.m_shop_id "
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') c on a.shop_kbn = cast(c.code as integer) "
    
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn} "
    
    @shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.shop_cd")
    
  end
  
end
