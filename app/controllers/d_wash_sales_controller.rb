include DWashSalesHelper

class DWashSalesController < ApplicationController
  layout "application",:except => [:entry_error]
  
  def index
    change_input_ymd
  end

  def change_input_ymd
    @m_washes = get_m_washes
    @shop = MShop.find(current_user.m_shops_id)
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
    @input_ymd = params[:input_ymd]
    end
    @input_ymd_s = @input_ymd.delete("/")
    @input_ymd_mae_s = get_zenkai_date(@input_ymd)
    @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
    @d_wash_sale_mae = get_d_wash_sale(@input_ymd_mae_s)
  end
  
  def entry_error
    @m_washe = get_m_washe(params[:wash_cd])
    @d_wash_sale = get_d_wash_sale(params[:sale_date])
    @sale_date = params[:sale_date]
    @wash_cd = params[:wash_cd]
    unless @d_wash_sale == nil
      @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,params[:wash_cd],99)
    else
      @d_washsale_item = DWashsaleItem.new
    end
    render :layout => 'modal'
  end

  def update_error
      @d_wash_sale = get_d_wash_sale(params[:sale_date])
      if (@d_wash_sale == nil)
        create_d_wash_sale(params[:sale_date])
        @d_wash_sale = get_d_wash_sale(params[:sale_date])
      end
      @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,params[:wash_cd],99)
      unless @d_washsale_item == nil
        #データあり
        @d_washsale_item.error_note = params[:error_note]
        @d_washsale_item.updated_user_id = current_user.id
      else
        #データなし
        @d_washsale_item = DWashsaleItem.new
        @d_washsale_item.d_wash_sale_id = @d_wash_sale.id
        @d_washsale_item.m_wash_id = params[:wash_cd]
        @d_washsale_item.wash_no = 99
        @d_washsale_item.error_note = params[:error_note]
        @d_washsale_item.created_user_id = current_user.id
        @d_washsale_item.updated_user_id = current_user.id
      end
      @d_washsale_item.save
              
      respond_to do |format|
        @m_washe = get_m_washe(params[:wash_cd])
        @d_wash_sale = get_d_wash_sale(params[:sale_date])
        @sale_date = params[:sale_date]
        @wash_cd = params[:wash_cd]
        @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,params[:wash_cd],99)
        #format.html { render action: "entry_error",:layout => 'modal', notice: 'D wash sale was successfully updated.' }
      end
  end
  
  def update
    DWashsaleItem.transaction do
      @d_wash_sale = get_d_wash_sale(params[:sale_date])
      @d_wash_sale_mae = get_d_wash_sale(params[:sale_date])
      if (@d_wash_sale == nil)
        create_d_wash_sale(params[:sale_date])
      end
      @d_wash_sale = get_d_wash_sale(params[:sale_date]) 
      
      @m_washes = get_m_washes
      #メーター更新
      @m_washes.each do |wash| #each
        sum_uriage = 0
        @d_wash_sale_mae = get_d_wash_sale(get_zenkai_date(params[:sale_date]))

        wash.max_num.times do |i| #times
         @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,wash.id,(i+1))
         unless @d_washsale_item == nil #unless1
           #データあり
           unless @d_washsale_item.meter == params["meter_#{wash.wash_cd.to_s}_#{i+1}"] #unless2
             update_d_washsale_item(wash.wash_cd,i+1)
           end #unless2
         else
           #データなし
           create_d_washsale_item(@d_wash_sale.id,wash.wash_cd,(i+1))
         end #unless1

         unless @d_wash_sale_mae == nil
           sum_uriage = sum_uriage + 
             (@d_washsale_item.meter - get_d_washsale_item(@d_wash_sale_mae.id,wash.wash_cd,(i+1)).meter )
         else
           sum_uriage = sum_uriage + @d_washsale_item.meter
         end
        end #times
        
        #誤差更新
        @d_washsale_item = get_d_washsale_item(@d_wash_sale.id,wash.id,99)
        @d_wash_sale_mae = get_d_wash_sale(get_zenkai_date(params[:sale_date]))
         unless @d_washsale_item == nil #unless1
           #データあり
           unless @d_washsale_item.meter == params["meter_#{wash.wash_cd.to_s}_99"] #unless2
             
             sum_meter = get_sum_meter(@d_wash_sale.id,wash.id)
             if  @d_wash_sale_mae == nil
               sum_meter_mae = 0
             else
             sum_meter_mae = get_sum_meter(@d_wash_sale_mae.id,wash.id) 
             end
             update_d_washsale_item(wash.wash_cd,99,sum_meter,sum_meter_mae)
           end #unless2
         else
           #データなし
           create_d_washsale_item(@d_wash_sale.id,wash.wash_cd,99,sum_uriage)
         end #unless1
      end #each
    end #transaction

    respond_to do |format|
      @m_washes = get_m_washes
      @shop = MShop.find(current_user.m_shops_id)
      @input_ymd = params[:sale_date].to_time.strftime("%Y/%m/%d")
      @input_ymd_s = params[:sale_date]
      @input_ymd_mae_s = get_zenkai_date(@input_ymd_s)
      @d_wash_sale_today     = get_d_wash_sale(@input_ymd_s)
      @d_wash_sale_mae = get_d_wash_sale(@input_ymd_mae_s)
      format.html { render action: "index", notice: 'D wash sale was successfully updated.' }
    end
  end
  
private 
  def create_d_wash_sale(sale_date)
    @d_wash_sale = DWashSale.new
    @d_wash_sale.sale_date = sale_date
    @d_wash_sale.m_shop_id = current_user.m_shops_id
    @d_wash_sale.kakutei_flg = 0
    @d_wash_sale.created_user_id = current_user.id
    @d_wash_sale.updated_user_id = current_user.id
    @d_wash_sale.save!
  end
  
  def create_d_washsale_item(d_wash_sale_id,wash_cd,wash_no,sum_uriage=0)
    @d_washsale_item = DWashsaleItem.new
    @d_washsale_item.d_wash_sale_id = d_wash_sale_id
    @d_washsale_item.m_wash_id = wash_cd
    @d_washsale_item.wash_no = wash_no
    @d_washsale_item.meter = params["meter_#{wash_cd}_#{wash_no}"]     
    if @d_washsale_item.wash_no == 99      
       @d_washsale_item.error_money = sum_uriage - @d_washsale_item.meter
    end
    @d_washsale_item.created_user_id = current_user.id
    @d_washsale_item.updated_user_id = current_user.id
    @d_washsale_item.save!
  end
  
  def update_d_washsale_item(wash_cd,wash_no,sum_meter=0,sum_meter_mae=0)
    @d_washsale_item.meter = params["meter_#{wash_cd}_#{wash_no}"]
    if wash_no == 99
      @d_washsale_item.error_money =  (sum_meter - sum_meter_mae) - @d_washsale_item.meter
    end
    @d_washsale_item.updated_user_id = current_user.id
    @d_washsale_item.save!
  end
end