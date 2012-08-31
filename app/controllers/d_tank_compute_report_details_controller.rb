#require 'time'

class DTankComputeReportDetailsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DResult.minimum("result_date",:conditions => ['m_shop_id = ?',current_user.m_shop_id])[0,4].to_i

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

      
      @tank_id = params[:select_tank].to_i unless params[:select_tank] == nil
      @oil_id = params[:select_oil].to_i unless params[:select_oil] == nil

      
      @d_results = DResult.find(:all,
      :conditions => ['result_date between ? and ? and m_shop_id = ?',@from_ymd,@to_ymd,current_user.m_shop_id])

    #respond_to do |format|
    #  format.js
    #end
  end

  def change_radio
    @shop_id = params[:shop_id].to_i
    @rbtn = params[:rbtn].to_i
  end

  def change_oil
    @oil_id = params[:oil_id]
    @shop_id = params[:shop_id]
    #respond_to do |format|
    #  format.js
    #end
  end
  
  def print
  end

end
