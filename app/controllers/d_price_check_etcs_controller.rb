class DPriceCheckEtcsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DPriceCheckEtc.minimum("research_day")[0,4].to_i
    
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
      else
        if (params[:result_date]) == nil || (params[:result_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
        else
          @year  = params[:result_date][0,4]
          @month = params[:result_date][4,2]
        end
      end
      @this_month = @year + @month
      @from_ymd = @this_month + '01'
      @to_ymd = @this_month + '31'
      p "*** from_ymd = #{@from_ymd} to_ymd = #{@to_ymd} ***"
      @d_price_check_etcs = DPriceCheckEtc.where(:research_day => @from_ymd..@to_ymd).group(
        'research_day,research_time').select(
          'research_day,research_time').order(
            'research_day,research_time')
      
    

  end

  def edit
    @etc_shops = MEtcShop.where(:m_shop_id => current_user.m_shop_id).order('access_group,id')
    @research_day  = params[:research_day]
    @research_time = params[:research_time]
  end

  def show
    @etc_shops = MEtcShop.where(:m_shop_id => current_user.m_shop_id).order('access_group,id')
    @research_day  = params[:research_day]
    @research_time = params[:research_time]
  end
end
