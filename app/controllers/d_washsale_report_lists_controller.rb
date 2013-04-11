include DWashsaleReportsHelper

class DWashsaleReportListsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DWashsaleReport.minimum("sale_date")
    if @start_year == nil
      @start_year = @time_now.year.to_i
    else
      @start_year = @start_year[0,4].to_i
    end
    
    @mode = params[:mode]
    
    unless @mode == 'list'
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
        @shop_kbn = 0
      else
        if (params[:sale_date]) == nil || (params[:sale_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
          @shop_kbn = params[:shop_kbn]
        else
          @year = params[:sale_date][0,4]
          @month = params[:sale_date][4,2]
          @shop_kbn = params[:shop_kbn]
        end
      end
      @this_month = @year + @month
    else
      @this_month = params[:sale_date]
      @shop_kbn = params[:shop_kbn]
      @time_now = (@this_month[0,4] + "/" + @this_month[4,2] + "/01").to_time
    end
    
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
  end
  
  def update
    @sale_date   = params[:sale_date]
    
    # UPDATE BEGIN 2013.04.09 更新対象を厳密にする
    
    #@d_washsale_reports = DWashsaleReport.find(:all,:conditions => ['sale_date = ?',@sale_date])
    # 
    #@d_washsale_reports.each do |d_washsale_report|
    #    unless params[:cbox] == nil
    #      if params[:cbox].include?(d_washsale_report.id.to_s)
    #        d_washsale_report.kakutei_flg = 1
    #      else
    #        d_washsale_report.kakutei_flg = 0
    #      end #if
    #    else
    #      d_washsale_report.kakutei_flg = 0
    #    end # uless
    #  d_washsale_report.updated_user_id = current_user.id
    #  d_washsale_report.save!
    #end
    unless params[:kakutei_flgs].blank?
      params[:kakutei_flgs].each do |id, kakutei_flg|
        d_washsale_report = DWashsaleReport.find(id)
        d_washsale_report[:kakutei_flg] = kakutei_flg
        d_washsale_report[:updated_user_id] = current_user.id
        d_washsale_report.save!
      end
    end
    @d_washsale_reports = DWashsaleReport.find(:all,:conditions => ['sale_date = ?',@sale_date])
    
    # UPDATE END 2013.04.09 更新対象を厳密にする
    
    respond_to do |format|
     @time_now = (@sale_date[0,4] + "/" + @sale_date[4,2] + "/01").to_time
     @shop_kbn = params[:shop_kbn]
     @this_month = @sale_date
     @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
      format.html { render action: "index",:sale_date => @sale_date,:shop_kbn => @shop_kbn,
        notice: 'D wash sale was successfully updated.' }
    end
  end
end
