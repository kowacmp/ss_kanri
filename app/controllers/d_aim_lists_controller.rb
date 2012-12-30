#include DAimsHelper

class DAimListsController < ApplicationController
  def index
    search
  end

  def search

    if params[:date] == nil
      date = DateTime.now
      year = date.strftime("%Y")
      month = date.strftime("%m")
    else
      year = params[:date][:year]
      month = params[:date][:month]
    end
    
    @month_first = Date.new(year.to_i,month.to_i,1)
    @input_ymd = Date.new(year.to_i,month.to_i,1).strftime("%Y/%m/%d")
    #2012/12/30 翌年度入力可対応
    @month_end = Date.new(year.to_i + 1,month.to_i,1)

    if params[:shop_kbn] == nil
      @shop_kbn = 0
    else
      @shop_kbn = params[:shop_kbn]
    end
    
    @input_ymd_s = @input_ymd.delete("/")
    
    @year = @input_ymd_s[0,4]
    @month = @input_ymd_s[4,2]
    @input_ym = @input_ymd_s[0,4] + @input_ymd_s[4,2]
    
    
    select_sql = "select a.id as shop_id,a.*,b.*,c.*,d.*,e.code_name shop_kbn_name "
    select_sql << " from m_shops a " 
    
    select_sql << " left join ("
    select_sql << "             select max(b1.id) as max_id,b1.m_shop_id "
    select_sql << "             from d_aims b1, "
    select_sql << "                  (select max(updated_at) as max_updated_at,m_shop_id from d_aims "
    select_sql << "                  where  date = '#{@input_ym}' group by m_shop_id) b2 "
    select_sql << "             where b1.updated_at = b2.max_updated_at "
    select_sql << "             group by b1.m_shop_id "
    select_sql << " ) b on a.id = b.m_shop_id "
    
    select_sql << " left join (select id,updated_user_id as last_user_id, "
    select_sql << "         to_char(updated_at,'YYYYMMDD') as last_update_at from d_aims) c on b.max_id = c.id "
    select_sql << " left join (select id,account as last_account,user_name as last_user_name from users) d on c.last_user_id = d.id "
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') e on a.shop_kbn = cast(e.code as integer) "
   
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn}"
    
    p select_sql
    
    @shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.shop_cd")
    
    #@shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
  end

end
