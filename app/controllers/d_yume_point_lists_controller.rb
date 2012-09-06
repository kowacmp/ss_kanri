class DYumePointListsController < ApplicationController
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
    

  end

  def print
  end

end
