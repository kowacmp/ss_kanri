include DSaleEtcsHelper

class DSaleEtcsController < ApplicationController
  layout "application",:except => [:entry_error]
  
  def index
    @m_etcs = get_m_etcs
    @shop = MShop.find(current_user.m_shop_id)
    @input_ymd = Time.now.strftime("%Y/%m/%d")
    @input_ymd_s = Time.now.strftime("%Y%m%d")
    @input_ymd_mae_s = get_zenkai_date(@input_ymd_s)
    @d_sale_etc_today     = get_d_sale_etc(@input_ymd_s)
    unless @d_sale_etc_today == nil
      @d_sale_etc_details_today =get_d_sale_etc_details(@d_sale_etc_today.id)
    end
  end

  def entry_error
    @m_etc = get_m_etc(params[:etc_cd])
    @d_sale_etc = get_d_sale_etc(params[:sale_date])
    @sale_date = params[:sale_date]
    @etc_cd = params[:etc_cd]
    unless @d_sale_etc == nil
      @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
    else
      @d_sale_etc_detail = DSaleEtcDetail.new
    end
    render :layout => 'modal'
  end

  def update_error
      @d_sale_etc = get_d_sale_etc(params[:sale_date])
      if (@d_sale_etc == nil)
        create_d_sale_etc(params[:sale_date])
        @d_sale_etc = get_d_sale_etc(params[:sale_date])
      end
      @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
      unless @d_sale_etc_detail == nil
        #データあり
        @d_sale_etc_detail.error_note = params[:error_note]
        @d_sale_etc_detail.updated_user_id = current_user.id
      else
        #データなし
        @d_sale_etc_detail = DSaleEtcDetail.new
        @d_sale_etc_detail.d_sale_etc_id = @d_sale_etc.id
        @d_sale_etc_detail.m_etc_id = params[:etc_cd]
        @d_sale_etc_detail.etc_no = 99
        @d_sale_etc_detail.error_note = params[:error_note]
        @d_sale_etc_detail.created_user_id = current_user.id
        @d_sale_etc_detail.updated_user_id = current_user.id
      end
      @d_sale_etc_detail.save
              
      respond_to do |format|
        @m_etc = get_m_etc(params[:etc_cd])
        @d_sale_etc = get_d_sale_etc(params[:sale_date])
        @sale_date = params[:sale_date]
        @etc_cd = params[:etc_cd]
        @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
        #format.html { render action: "entry_error",:layout => 'modal', notice: 'D wash sale was successfully updated.' }
      end
  end
  
  def change_input_ymd
    @input_ymd = params[:input_ymd]
    @m_etcs = get_m_etcs
    @input_ymd_s = params[:input_ymd].delete("/")
    @input_ymd_mae_s = get_zenkai_date(params[:input_ymd])
    @d_sale_etc_today     = get_d_sale_etc(@input_ymd_s)
    @d_sale_etc_mae = get_d_sale_etc(@input_ymd_mae_s)
  end
  
 
  def update
    DSaleEtcDetail.transaction do
      @d_sale_etc = get_d_sale_etc(params[:sale_date])
      @d_sale_etc_mae = get_d_sale_etc(params[:sale_date])
      if (@d_sale_etc == nil)
        create_d_sale_etc(params[:sale_date])
      end
      @d_sale_etc = get_d_sale_etc(params[:sale_date]) 
      
      @m_etcs = get_m_etcs
      #メーター更新
      @m_etcs.each do |etc| #each
        sum_uriage = 0
        @d_sale_etc_mae = get_d_sale_etc(get_zenkai_date(params[:sale_date]))

        etc.max_num.times do |i| #times
         @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,etc.id,(i+1))
         unless @d_sale_etc_detail == nil #unless1
           #データあり
           unless @d_sale_etc_detail.meter == params["meter_#{etc.etc_cd.to_s}_#{i+1}"] #unless2
             update_d_sale_etc_detail(etc.etc_cd,i+1)
           end #unless2
         else
           #データなし
           create_d_sale_etc_detail(@d_sale_etc.id,etc.etc_cd,(i+1))
         end #unless1

         unless @d_sale_etc_mae == nil
           sum_uriage = sum_uriage + 
             (@d_sale_etc_detail.meter - get_d_sale_etc_detail(@d_sale_etc_mae.id,etc.etc_cd,(i+1)).meter )
         else
           sum_uriage = sum_uriage + @d_sale_etc_detail.meter
         end
        end #times
        
        #誤差更新
        @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,etc.id,99)
        @d_sale_etc_mae = get_d_sale_etc(get_zenkai_date(params[:sale_date]))
         unless @d_sale_etc_detail == nil #unless1
           #データあり
           unless @d_sale_etc_detail.meter == params["meter_#{etc.etc_cd.to_s}_99"] #unless2
             
             sum_meter = get_sum_meter(@d_sale_etc.id,etc.id)
             if  @d_sale_etc_mae == nil
               sum_meter_mae = 0
             else
             sum_meter_mae = get_sum_meter(@d_sale_etc_mae.id,etc.id) 
             end
             update_d_sale_etc_detail(etc.etc_cd,99,sum_meter,sum_meter_mae)
           end #unless2
         else
           #データなし
           create_d_sale_etc_detail(@d_sale_etc.id,etc.etc_cd,99,sum_uriage)
         end #unless1
      end #each
    end #transaction

    respond_to do |format|
      @m_etcs = get_m_etcs
      @shop = MShop.find(current_user.m_shop_id)
      @input_ymd = params[:sale_date].to_time.strftime("%Y/%m/%d")
      @input_ymd_s = params[:sale_date]
      @input_ymd_mae_s = get_zenkai_date(@input_ymd_s)
      @d_sale_etc_today     = get_d_sale_etc(@input_ymd_s)
      @d_sale_etc_mae = get_d_sale_etc(@input_ymd_mae_s)
      format.html { render action: "index", notice: 'D sale etc was successfully updated.' }
    end
  end
  
private 
  def create_d_sale_etc(sale_date)
    @d_sale_etc = DSaleEtc.new
    @d_sale_etc.sale_date = sale_date
    @d_sale_etc.m_shop_id = current_user.m_shop_id
    @d_sale_etc.kakutei_flg = 0
    @d_sale_etc.created_user_id = current_user.id
    @d_sale_etc.updated_user_id = current_user.id
    @d_sale_etc.save!
  end
  
  def create_d_sale_etc_detail(d_sale_etc_id,etc_cd,etc_no,sum_uriage=0)
    @d_sale_etc_detail = DSaleEtcDetail.new
    @d_sale_etc_detail.d_sale_etc_id = d_sale_etc_id
    @d_sale_etc_detail.m_etc_id = etc_cd
    @d_sale_etc_detail.etc_no = etc_no
    @d_sale_etc_detail.meter = params["meter_#{etc_cd}_#{etc_no}"]     
    if @d_sale_etc_detail.etc_no == 99      
       @d_sale_etc_detail.error_money = sum_uriage - @d_sale_etc_detail.meter
    end
    @d_sale_etc_detail.created_user_id = current_user.id
    @d_sale_etc_detail.updated_user_id = current_user.id
    @d_sale_etc_detail.save!
  end
  
  def update_d_sale_etc_detail(etc_cd,etc_no,sum_meter=0,sum_meter_mae=0)
    @d_sale_etc_detail.meter = params["meter_#{etc_cd}_#{etc_no}"]
    if etc_no == 99
      @d_sale_etc_detail.error_money =  (sum_meter - sum_meter_mae) - @d_sale_etc_detail.meter
    end
    @d_sale_etc_detail.updated_user_id = current_user.id
    @d_sale_etc_detail.save!
  end
end