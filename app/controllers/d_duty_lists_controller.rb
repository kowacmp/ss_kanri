
class DDutyListsController < ApplicationController
  def index
    search
  end

  def search
    
    @from_view = params[:from_view]
    
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
    
    #月末日取得
    @month_last_day = (Date.new(@input_ym_s.to_s[0,4].to_i, @input_ym_s.to_s[4,2].to_i, -1)).strftime("%d").to_i
    
    select_sql = "select a.*,b.*,f.code_name as shop_kbn_name, "
    select_sql << " c.input_flg as input_10,d.input_flg as input_20,e.input_flg as input_30 " 
    select_sql << " from m_shops a " 
    #最終登録日
    select_sql << " left join ( "
    select_sql << " select duty_nengetu,m_shop_id,max(day) as last_day from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' "
    select_sql << " ) b on a.id = b.m_shop_id "
    #入力チェック(10日)
    select_sql << " left join ( "
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and day = 10 and input_flg = 1 "
    select_sql << " ) c on a.id = c.m_shop_id "
    #入力チェック(20日)
    select_sql << " left join ( "
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and day = 20 and input_flg = 1 "
    select_sql << " ) d on a.id = d.m_shop_id "
    #入力チェック(月末)
    select_sql << " left join ( "
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and day = #{@month_last_day} and input_flg = 1 "
    select_sql << " ) e on a.id = e.m_shop_id "
    #店舗種別
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') f on a.shop_kbn = cast(f.code as integer) "
    
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn} "
    
    @shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.shop_cd")
    
  end
  
end
