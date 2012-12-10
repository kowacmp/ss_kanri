include DWashSalesHelper
include DWashsaleReportsHelper

class DWashsaleReportsController < ApplicationController
  def index
    search
  end

  def search
    @mode = params[:mode]

    unless @mode == 'list'
      @shop = MShop.find(current_user.m_shop_id)  
      @time_now = Time.now
      #select_yearの開始年
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id=params[:m_shop_id]
      @shop = MShop.find(@m_shop_id) 
    end

    #@start_year = DWashSale.minimum("sale_date",:conditions => ['m_shop_id = ?',@m_shop_id])[0,4].to_i
    dwashsalemin = DWashSale.minimum("sale_date",:conditions => ['m_shop_id = ?',@m_shop_id])
    if dwashsalemin.nil? then
      @start_year = "none" 
      return 
    end
    @start_year = dwashsalemin[0,4].to_i

    @mode = params[:mode]
    
    unless @mode == 'list'
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
      else
        @year = params[:date][:year].to_s
        @month = format_month(params[:date][:month])
      end
      @this_month = @year + @month
      @last_month = get_last_month(@year, @month)
    else
      @this_month = params[:sale_date]
      @last_month = get_last_month(@this_month[0,4], @this_month[4,2])
    end

    @d_washsale_report = get_d_washsale_report(@this_month,@m_shop_id)
    @d_washsale_report_last = 
      DWashsaleReport.find(:first,
                           :conditions => ["m_shop_id = ? and sale_date like ? ", @m_shop_id, @last_month + "%"],
                           :order => "sale_date")
    @m_washes = get_m_washes
  end

  def update
    @sale_date = params[:sale_date]
    @m_shop_id = params[:m_shop_id]
    @m_washes = get_m_washes
    
    DWashsaleReport.transaction do
      @d_washsale_report = get_d_washsale_report(@sale_date,@m_shop_id)

      if @d_washsale_report == nil
        @d_washsale_report = DWashsaleReport.new
        @d_washsale_report.sale_date = @sale_date
        @d_washsale_report.m_shop_id = @m_shop_id
        @d_washsale_report.kakutei_flg = 0
        @d_washsale_report.created_user_id = current_user.id
        @d_washsale_report.updated_user_id = current_user.id
      else  
        @d_washsale_report.updated_user_id = current_user.id
      end #if
      @d_washsale_report.save!
      
      @d_washsale_report = get_d_washsale_report(@sale_date,@m_shop_id)
      
      @m_washes.each do |wash|
        wash.max_num.times do |i|
          create_d_washsale_detail_report(@d_washsale_report.id,wash.id, (i+1))
        end #times
        
        #99
        create_d_washsale_detail_report(@d_washsale_report.id,wash.id, 99)
      end #each
    end #transaction

    respond_to do |format|
      @time_now = Time.now
      @shop = MShop.find(current_user.m_shop_id)
      @year = params[:sale_date][0,4]
      @month = params[:sale_date][4,2]
      @this_month = @year + @month
      @last_month = get_last_month(@year, @month)
      @d_washsale_report_last = get_d_washsale_report(@last_month,@m_shop_id)
      format.html { render action: "index", notice: 'D wash sale was successfully updated.' }
    end
  end

  def show_error
    @sale_date = Array.new
    @wash_cd   = params[:wash_cd]
    p "***** wash_cd = #{params[:wash_cd]} *****"
    @d_wash_sales = get_d_wash_sales_month(params[:sale_date],params[:shop_id])
    @d_wash_sales.each do |wash_sale|
      @d_washsale_item = get_d_washsale_item(wash_sale.id,@wash_cd,99) 
          if @d_washsale_item
            unless @d_washsale_item.error_money == 0
              p "***** error_money = #{@d_washsale_item.error_money} *****"
              p "***** wash_sale.sale_date = #{wash_sale.sale_date} *****"
              @sale_date << wash_sale.sale_date
            end #unless
          end
    end #each
    @m_washe   = get_m_washe(@wash_cd)

    render :layout => 'modal'
  end
  
private
  def create_d_washsale_detail_report(d_washsale_report_id,wash_id, wash_no)
    d_washsale_detail_report = get_d_washsale_detail_report(d_washsale_report_id,wash_id,wash_no)
    if d_washsale_detail_report == nil
      d_washsale_detail_report = DWashsaleDetailReport.new
      d_washsale_detail_report.d_washsale_report_id = d_washsale_report_id
      d_washsale_detail_report.m_wash_id = wash_id
      d_washsale_detail_report.wash_no = wash_no
      d_washsale_detail_report.meter =  params["meter_#{wash_id}_#{wash_no}"] 
      d_washsale_detail_report.sale_meter =  params["sale_meter_#{wash_id}_#{wash_no}"] 
      d_washsale_detail_report.created_user_id = current_user.id
      d_washsale_detail_report.updated_user_id = current_user.id
    else
      d_washsale_detail_report.meter =  params["meter_#{wash_id}_#{wash_no}"] 
      d_washsale_detail_report.sale_meter =  params["sale_meter_#{wash_id}_#{wash_no}"] 
      d_washsale_detail_report.updated_user_id = current_user.id
    end
    d_washsale_detail_report.save!
  end
  
  def get_d_washsale_report(sale_date,m_shop_id)
    DWashsaleReport.find(:all,
        :conditions => ['sale_date = ? and m_shop_id = ?',sale_date,m_shop_id]).first
  end


    

end
