class DTankComputeReportsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DResult.minimum("result_date")[0,4].to_i
    
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
        @shop_kbn = 0
      else
        if (params[:result_date]) == nil || (params[:result_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
          @shop_kbn = params[:shop_kbn]
        else
          @year  = params[:result_date][0,4]
          @month = params[:result_date][4,2]
          @shop_kbn = params[:shop_kbn]
        end
      end
      @this_month = @year + @month
      @from_ymd = @this_month + '01'
      @to_ymd = @this_month + '31'
      
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    @results = MShopGroup.find_by_sql([
      'select c.group_cd,c.group_name,d.* 
      from m_shop_groups c
      left join
      (select a.shop_cd,a.shop_name,a.shop_ryaku,a.shop_kbn,a.m_shop_group_id ,b.* 
       from m_shops a
      left join 
      (select m_shop_id,max(result_date) result_date from d_results
         where result_date between ? and ?
         group by m_shop_id) b
         on a.id = b.m_shop_id
       where a.shop_kbn <> 9
       and a.deleted_flg = 0
       and a.shop_kbn = ?) d
       on c.id = d.m_shop_group_id
       where c.deleted_flg = 0
       and shop_cd is not null
       order by group_cd,shop_cd',@from_ymd,@to_ymd,@shop_kbn])
  end

  def show
    
  end
end
