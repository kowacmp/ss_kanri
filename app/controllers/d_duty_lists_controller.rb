
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
    select_sql << " case when c.cnt = 10 then '1' else '0' end as input_10 "
    select_sql << ", case when d.cnt = 10 then '1' else '0' end as input_20 "
    select_sql << ", case when e.cnt = (#{@month_last_day}-20) then '1' else '0' end as input_30 "

    select_sql << ", case when g.cnt = 10 then '1' else '0' end as kakutei_10 "
    select_sql << ", case when h.cnt = 10 then '1' else '0' end as kakutei_20 "
    select_sql << ", case when i.cnt = (#{@month_last_day}-20) then '1' else '0' end as kakutei_30 "
    select_sql << " from m_shops a " 
    #最終登録日
    select_sql << " \n left join ( "
    select_sql << " select duty_nengetu,m_shop_id,max(day) as last_day from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' "
    select_sql << " ) b on a.id = b.m_shop_id "
    #入力チェック(10日)
    select_sql << " \n left join ( "
    select_sql << " select cc.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and (day >= 1 and day <= 10) and input_flg = 1 "
    select_sql << " ) cc group by cc.m_shop_id "
    select_sql << " ) c on a.id = c.m_shop_id "
    #入力チェック(20日)
    select_sql << " \n left join ( "
    select_sql << " select dd.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg, count(*) as cnt from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and (day >= 11 and day <= 20) and input_flg = 1 "
    select_sql << " ) dd group by dd.m_shop_id "
    select_sql << " ) d on a.id = d.m_shop_id "
    #入力チェック(月末)
    select_sql << " \n left join ( "
    select_sql << " select ee.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,input_flg, count(*) as cnt from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,input_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}'and (day >= 21 and day <= #{@month_last_day}) and input_flg = 1 "
    select_sql << " ) ee group by ee.m_shop_id "
    select_sql << " ) e on a.id = e.m_shop_id "

    #確定チェック(10日)
    select_sql << " \n left join ( "
    select_sql << " select gg.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,kakutei_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,kakutei_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and (day >= 1 and day <= 10) and kakutei_flg = 1 "
    select_sql << " ) gg group by gg.m_shop_id "
    select_sql << " ) g on a.id = g.m_shop_id "
    #確定チェック(20日)
    select_sql << " \n left join ( "
    select_sql << " select hh.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,kakutei_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,kakutei_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}' and (day >= 11 and day <= 20) and kakutei_flg = 1 "
    select_sql << " ) hh group by hh.m_shop_id "
    select_sql << " ) h on a.id = h.m_shop_id "
    #確定チェック(月末)
    select_sql << " \n left join ( "
    select_sql << " select ii.m_shop_id, count(*) as cnt from ("
    select_sql << " select duty_nengetu,m_shop_id,day,kakutei_flg from d_duties "
    select_sql << " group by duty_nengetu,m_shop_id,day,kakutei_flg "
    select_sql << " having duty_nengetu = '#{@input_ym_s[0,6]}'and (day >= 21 and day <= #{@month_last_day}) and kakutei_flg = 1 "
    select_sql << " ) ii group by ii.m_shop_id "
    select_sql << " ) i on a.id = i.m_shop_id "

    #店舗種別
    select_sql << " \n left join (select * from m_codes where kbn='shop_kbn') f on a.shop_kbn = cast(f.code as integer) "
    
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn} "
    
    @shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.shop_cd")
    
  end

  #確定済み登録
  def kakutei_check
    if params[:kakutei_flg] == "checked" 
      params[:kakutei_flg] = 1
    else
      params[:kakutei_flg] = 0
    end   

    update_sql = "update d_duties "
    update_sql << " set kakutei_flg = #{params[:kakutei_flg]} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where duty_nengetu = '#{params[:input_day].to_s.gsub("/", "")}' "
    update_sql << " and day >= #{params[:day1]} "
    update_sql << " and day <= #{params[:day2]} "
    update_sql << " and m_shop_id = #{params[:m_shop_id]}"
    ActiveRecord::Base::connection.execute(update_sql)
    head :ok
    #respond_to do |format|
    #  format.js { render :layout => false }
    #end      
  end
  
  #確定済み登録
  def kakutei_check_all
    if params[:kakutei_flg] == "checked" 
      params[:kakutei_flg] = 1
    else
      params[:kakutei_flg] = 0
    end   

    update_sql = "update d_duties "
    update_sql << " set kakutei_flg = #{params[:kakutei_flg]} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where duty_nengetu = '#{params[:input_day].to_s.gsub("/", "")}' "
    update_sql << " and day >= #{params[:day1]} "
    update_sql << " and day <= #{params[:day2]} "
    update_sql << " and m_shop_id in (select id from m_shops where shop_kbn = #{params[:shop_kbn]})"
    ActiveRecord::Base::connection.execute(update_sql)
    head :ok
    #respond_to do |format|
    #  format.js { render :layout => false }
    #end      
  end
  
end
