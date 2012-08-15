include DWashSalesHelper

class DWashSalesController < ApplicationController
  def index
    @m_washes = get_m_washes
    @shop = MShop.find(current_user.m_shops_id)
    @input_ymd = Time.now.strftime("%Y/%m/%d")
    @input_ymd_s = Time.now.strftime("%Y%m%d")
    @input_ymd_yesterday_s = 1.days.ago.strftime("%Y%m%d")
    @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
    #@d_wash_sale_yesterday = get_d_wash_sale(@input_ymd_yesterday_s)
    unless @d_wash_sale_today == nil
      @d_washsale_item_today =get_d_washsale_items(@d_wash_sale_today.id)
    end
    unless @d_wash_sale_yesterday == nil
      @d_washsale_item_yesterday = get_d_washsale_items(@d_wash_sale_yesterday.id)
    end
  end

  def entry_error
  end

  def change_input_ymd
    @input_ymd = params[:input_ymd]
    @input_ymd_yesterday = @input_ymd.to_time.yesterday.strftime("%Y%m%d")
    @m_washes = get_m_washes
    @input_ymd_s = params[:input_ymd].delete("/")
    @input_ymd_yesterday_s = @input_ymd_yesterday.to_s.delete("/")
    @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
    @d_wash_sale_yesterday = get_d_wash_sale(@input_ymd_yesterday_s)
    #respond_to do |format|
    #  format.js
    #end
  end
  
  def create
    @d_wash_sale = get_d_wash_sale(params[:sale_date])
    
    if (@d_wash_sale == nil)
      @d_wash_sale = DWashSale.new
      @d_wash_sale.sale_date = params[:sale_date]
      @d_wash_sale.m_shop_id = current_user.m_shops_id
      @d_wash_sale.kakutei_flg = 0
      @d_wash_sale.created_user_id = current_user.id
      @d_wash_sale.updated_user_id = current_user.id
      @d_wash_sale.save
      
      @d_wash_sale = get_d_wash_sale(params[:sale_date])      
      @m_washes = get_m_washes
      @m_washes.each do |wash|
        wash.max_num.times do |i|
         @d_washsale_item = DWashsaleItem.new
         @d_washsale_item.d_wash_sale_id = @d_wash_sale.id
         @d_washsale_item.m_wash_id = wash.wash_cd
         @d_washsale_item.wash_no = i+1         
         @d_washsale_item.meter = params["meter_#{wash.wash_cd.to_s}_#{i+1}"]
         #p '************************ ' + "meter_#{wash.wash_cd.to_s}_#{i+1}" + ' ************' + "#{@d_washsale_item.meter}"
         @d_washsale_item.created_user_id = current_user.id
         @d_washsale_item.updated_user_id = current_user.id
         @d_washsale_item.save
        end
      end



    end


    respond_to do |format|
      @m_washes = get_m_washes
      @shop = MShop.find(current_user.m_shops_id)
      @input_ymd = params[:sale_date].to_time.strftime("%Y/%m/%d")
      @input_ymd_s = params[:sale_date]
      @input_ymd_yesterday_s = @input_ymd.to_time.yesterday.strftime("%Y%m%d")
      @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
      @d_wash_sale_yesterday = get_d_wash_sale(1.days.ago.strftime("%Y%m%d"))

      format.html { render action: "index", notice: 'D wash sale was successfully created.' }
    end
  end
  
  def update
      @d_wash_sale = get_d_wash_sale(params[:sale_date])
      @d_washsale_items = get_d_washsale_items(@d_wash_sale.id)
      
      @m_washes = get_m_washes
      @m_washes.each do |wash|
        wash.max_num.times do |i|
         @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,wash.id,(i+1)) 
         unless @d_washsale_item == nil
           unless @d_washsale_item.meter == params["meter_#{wash.wash_cd.to_s}_#{i+1}"]
             @d_washsale_item.meter = params["meter_#{wash.wash_cd.to_s}_#{i+1}"]
             @d_washsale_item.updated_user_id = current_user.id
             @d_washsale_item.save
           end
         end
        end
      end


    respond_to do |format|
      @m_washes = get_m_washes
      @shop = MShop.find(current_user.m_shops_id)
      @input_ymd = params[:sale_date].to_time.strftime("%Y/%m/%d")
      @input_ymd_s = params[:sale_date]
      @input_ymd_yesterday_s = @input_ymd.to_time.yesterday.strftime("%Y%m%d")
      @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
      @d_wash_sale_yesterday = get_d_wash_sale(1.days.ago.strftime("%Y%m%d"))
      format.html { render action: "index", notice: 'D wash sale was successfully updated.' }
      #format.html { redirect_to action: "index", notice: 'D wash sale was successfully updated.' }
    end
  end
  
end
