include DSaleEtcsHelper

class DSaleEtcsController < ApplicationController
  layout "application",:except => [:entry_error]
  
  def index
    change_input_ymd
  end

  def entry_error
    @m_etc = get_m_etc(params[:etc_id])
    @d_sale_etc = get_d_sale_etc(params[:sale_date], params[:shop_id], params[:mode])
    @sale_date = params[:sale_date]
    @etc_id = params[:etc_id] #2012/10/05 nishimura
    @etc_cd = params[:etc_cd]
    unless @d_sale_etc == nil
      #2012/10/05 etc_cd=>etc_id nishimura
      #@d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
      @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_id],99)
    else
      @d_sale_etc_detail = DSaleEtcDetail.new
    end
    render :layout => 'modal'
  end

  def update_error
      @d_sale_etc = get_d_sale_etc(params[:sale_date], params[:shop_id], params[:mode])
      if (@d_sale_etc == nil)
        create_d_sale_etc(params[:sale_date], params[:shop_id], params[:mode])
        @d_sale_etc = get_d_sale_etc(params[:sale_date], params[:shop_id], params[:mode])
      end
      #2012/10/05 etc_cd=>etc_id nishimura
      #@d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
      @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_id],99)
      unless @d_sale_etc_detail == nil
        #データあり
        @d_sale_etc_detail.error_note = params[:error_note]
        @d_sale_etc_detail.updated_user_id = current_user.id
      else
        #データなし
        @d_sale_etc_detail = DSaleEtcDetail.new
        @d_sale_etc_detail.d_sale_etc_id = @d_sale_etc.id
        #2012/10/05 etc_cd=>etc_id nishimura
        #@d_sale_etc_detail.m_etc_id = params[:etc_cd]
        @d_sale_etc_detail.m_etc_id = params[:etc_id]
        @d_sale_etc_detail.etc_no = 99
        @d_sale_etc_detail.error_note = params[:error_note]
        @d_sale_etc_detail.created_user_id = current_user.id
        @d_sale_etc_detail.updated_user_id = current_user.id
      end
      @d_sale_etc_detail.save
              
      respond_to do |format|
        @m_etc = get_m_etc(params[:etc_id])
        @d_sale_etc = get_d_sale_etc(params[:sale_date], params[:shop_id], params[:mode])
        @sale_date = params[:sale_date]
        @shop_id = params[:shop_id]
        @mode = params[:mode]
        @etc_id = params[:etc_id] #2012/10/05 nishimura
        @etc_cd = params[:etc_cd]
        #2012/10/05 etc_cd=>etc_id nishimura
        #@d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_cd],99)
        @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,params[:etc_id],99)
        #format.html { render action: "entry_error",:layout => 'modal', notice: 'D wash sale was successfully updated.' }
      end
  end
  
  def change_input_ymd
    #@m_etcs = get_m_etcs
    #@shop = MShop.find(current_user.m_shop_id)
    #@input_ymd = Time.now.strftime("%Y/%m/%d")
    #@input_ymd_s = Time.now.strftime("%Y%m%d")
    #@input_ymd_mae_s = get_zenkai_date1(@input_ymd_s)
    #@d_sale_etc_today     = get_d_sale_etc(@input_ymd_s)
    #unless @d_sale_etc_today == nil
    #  @d_sale_etc_details_today =get_d_sale_etc_details(@d_sale_etc_today.id)
    #end
    
    @m_etcs = get_m_etcs
    @mode   = params[:mode]
    
    if @mode == 'list'
      @shop_id = params[:m_shop_id]
      @shop = MShop.find(params[:m_shop_id])
    else
      @shop_id = current_user.m_shop_id
      @shop = MShop.find(current_user.m_shop_id)   
    end
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    
    @shop_kbn             = params[:shop_kbn]
    @input_ymd_s          = @input_ymd.delete("/")
    @input_ymd_mae_s      = get_zenkai_date1(@input_ymd,@shop_id,@mode)
    @d_sale_etc_today     = get_d_sale_etc(@input_ymd_s,@shop_id,@mode)
    unless @d_sale_etc_today == nil
      @d_sale_etc_details_today = get_d_sale_etc_details(@d_sale_etc_today.id)
    end
    @d_sale_etc_mae       = get_d_sale_etc(@input_ymd_mae_s,@shop_id,@mode)
  end
  
 
  def update
    @mode      = params[:mode]
    @shop_id   = params[:shop_id]
    @sale_date = params[:sale_date]
    DSaleEtcDetail.transaction do
      @d_sale_etc = get_d_sale_etc(@sale_date,@shop_id,@mode)
      @d_sale_etc_mae = get_d_sale_etc(@sale_date,@shop_id,@mode)
      if (@sale_date == nil) or (@sale_date == "") or (@d_sale_etc.nil?)
        create_d_sale_etc(@sale_date,@shop_id,@mode)
      end
      @d_sale_etc = get_d_sale_etc(@sale_date,@shop_id,@mode) 

      @m_etcs = get_m_etcs
      #メーター更新
      @m_etcs.each do |etc| #each
        @price = etc.price
        
        sum_uriage = 0
        #@d_sale_etc_mae = get_d_sale_etc(get_zenkai_date1(@sale_date,@shop_id,@mode),@shop_id,@mode)

        etc.max_num.times do |i| #times
          
         #2012/10/05 他売上毎にデータ取得 nishimura <<<
         @d_sale_etc_mae = get_d_sale_etc(get_etc_zenkai_date(@sale_date,@shop_id,etc.id,i+1,@mode),@shop_id,@mode)
         #2012/10/05 他売上毎にデータ取得 nishimura >>>
          
          
          #if params["meter_#{etc.etc_cd.to_s}_#{i+1}"].nil? then
          if params["meter_#{etc.id.to_s}_#{i+1}"].nil? then
            v1 = 0
          else
            #v1 = params["meter_#{etc.etc_cd.to_s}_#{i+1}"].to_i
            v1 = params["meter_#{etc.id.to_s}_#{i+1}"].to_i
          end 
          v2 = 0
          if not(@d_sale_etc_mae.nil?) then
            if etc.etc_class == 0 then
               #2012/10/05 etc_cd=>id nishimura
               #v2 = get_d_sale_etc_detail(@d_sale_etc_mae.id,etc.etc_cd,(i+1)).meter
               v2 = get_d_sale_etc_detail(@d_sale_etc_mae.id,etc.id,(i+1)) ? 
                      get_d_sale_etc_detail(@d_sale_etc_mae.id,etc.id,(i+1)).meter : 0
            else
               v2 = 0
            end 
           end
           v1 = 0 if v1.nil?
           v2 = 0 if v2.nil?
           if v1 < v2 then
             @uriage = v1 * @price
             sum_uriage += @uriage
           else
             @uriage = (v1 - v2) * @price
             sum_uriage += @uriage 
           end  
          
         @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,etc.id,(i+1))
         unless @d_sale_etc_detail == nil #unless1
           
           #データあり
           #unless @d_sale_etc_detail.meter == params["meter_#{etc.etc_cd.to_s}_#{i+1}"] #unless2
           unless @d_sale_etc_detail.meter == params["meter_#{etc.id.to_s}_#{i+1}"] #unless2
             #2012/10/06 不具合修正 oda
             #update_d_sale_etc_detail(etc.etc_cd,i+1)
             update_d_sale_etc_detail(etc.id,i+1)
           end #unless2
         else
           #データなし
           #2012/10/06 不具合修正 oda
           #2012/10/05 id追加 nishimura
           #create_d_sale_etc_detail(@d_sale_etc.id,etc.etc_cd,(i+1))
           #create_d_sale_etc_detail(@d_sale_etc.id,etc.id,etc.etc_cd,(i+1))
           create_d_sale_etc_detail(@d_sale_etc.id,etc.id,etc.id,(i+1))
         end #unless1

         #unless @d_sale_etc_mae == nil
         #  sum_uriage = sum_uriage + 
         #    (@d_sale_etc_detail.meter - get_d_sale_etc_detail(@d_sale_etc_mae.id,etc.etc_cd,(i+1)).meter )
         #else
         #  sum_uriage = sum_uriage + @d_sale_etc_detail.meter
         #end
                 
        end #times
        
        #誤差更新
        @d_sale_etc_detail = get_d_sale_etc_detail(@d_sale_etc.id,etc.id,99)
        @d_sale_etc_mae    = get_d_sale_etc(get_zenkai_date1(@sale_date,@shop_id,@mode),@shop_id,@mode)
         unless @d_sale_etc_detail == nil #unless1
           #データあり
           #2012/10/06 不具合修正 oda
           #unless @d_sale_etc_detail.meter == params["meter_#{etc.etc_cd.to_s}_99"] #unless2
           unless @d_sale_etc_detail.meter == params["meter_#{etc.id.to_s}_99"] #unless2
             
             #sum_meter = get_sum_meter(@d_sale_etc.id,etc.id)
             #if  @d_sale_etc_mae == nil
             #  sum_meter_mae = 0
             #else
             #sum_meter_mae = get_sum_meter(@d_sale_etc_mae.id,etc.id) 
             #end
             #update_d_sale_etc_detail(etc.etc_cd,99,sum_meter,sum_meter_mae)
           
            #2012/10/06 不具合修正 oda
             #@d_sale_etc_detail.meter = params["meter_#{etc.etc_cd.to_s}_99"].to_i
             @d_sale_etc_detail.meter = params["meter_#{etc.id.to_s}_99"].to_i
             # UPDATE 2012.19.27 誤差 = 現金売上高 - 計算上売上高
             #@d_sale_etc_detail.error_money = sum_uriage - @d_sale_etc_detail.meter
             @d_sale_etc_detail.error_money = @d_sale_etc_detail.meter - sum_uriage
             if @d_sale_etc_detail.etc_no == 99 then
               @d_sale_etc_detail.uriage = 0
             else
               @d_sale_etc_detail.uriage = @uriage
             end
             @d_sale_etc_detail.updated_user_id = current_user.id
             @d_sale_etc_detail.save!
           
           end #unless2
         else
           #データなし
           #2012/10/06 不具合修正 oda
           #2012/10/05 id追加 nishimura
           #create_d_sale_etc_detail(@d_sale_etc.id,etc.etc_cd,99,sum_uriage)
           #create_d_sale_etc_detail(@d_sale_etc.id,etc.id,etc.etc_cd,99,sum_uriage)
           #2012/10/09 etc_cdは必要ないが引数のを合わせるため同じコードを渡す
           create_d_sale_etc_detail(@d_sale_etc.id,etc.id,etc.id,99,sum_uriage)
         end #unless1
      end #each
    end #transaction

    respond_to do |format|
      unless params[:shop_kbn] == nil
        @shop_kbn = params[:shop_kbn]
      end
      @m_etcs = get_m_etcs
      if @mode == 'list'
        @shop = MShop.find(@shop_id)
      else
        @shop = MShop.find(current_user.m_shop_id)        
      end
      
      @input_ymd = params[:sale_date].to_time.strftime("%Y/%m/%d")
      @input_ymd_s = params[:sale_date]
      @input_ymd_mae_s = get_zenkai_date1(@input_ymd_s,@shop_id,@mode)
      @d_sale_etc_today     = get_d_sale_etc(@input_ymd_s,@shop_id,@mode)
      @d_sale_etc_mae = get_d_sale_etc(@input_ymd_mae_s,@shop_id,@mode)
      @sale_date = params[:sale_date]
      @shop_id = params[:shop_id]
      @mode = params[:mode]
      format.html { render action: "index", notice: 'D sale etc was successfully updated.' }
    end
  end
  
private 
  def create_d_sale_etc(sale_date,shop_id,mode)
    @d_sale_etc = DSaleEtc.new
    @d_sale_etc.sale_date = sale_date
    if mode == 'list'
      @d_sale_etc.m_shop_id = shop_id
    else
      @d_sale_etc.m_shop_id = current_user.m_shop_id      
    end
    @d_sale_etc.kakutei_flg = 0
    @d_sale_etc.created_user_id = current_user.id
    @d_sale_etc.updated_user_id = current_user.id
    @d_sale_etc.save!
  end
  
  #2012/10/05 id追加 nishimura
  #def create_d_sale_etc_detail(d_sale_etc_id,etc_cd,etc_no,sum_uriage=0)
  def create_d_sale_etc_detail(d_sale_etc_id,etc_id,etc_cd,etc_no,sum_uriage=0)
    #2012/10/05 入力値>0の場合のみ登録 nishimura
    #if params["meter_#{etc_cd}_#{etc_no}"].to_i > 0 or etc_no == 99
    if params["meter_#{etc_cd}_#{etc_no}"].to_i > 0 or etc_no == 99
      @d_sale_etc_detail = DSaleEtcDetail.new
      @d_sale_etc_detail.d_sale_etc_id = d_sale_etc_id
      
      #2012/10/05 etc_cd=>etc_id nishimura
      #@d_sale_etc_detail.m_etc_id = etc_cd
      @d_sale_etc_detail.m_etc_id = etc_id
      @d_sale_etc_detail.etc_no = etc_no
      @d_sale_etc_detail.meter = params["meter_#{etc_cd}_#{etc_no}"].to_i
      if @d_sale_etc_detail.etc_no == 99      
         # UPDATE 2012.19.27 誤差 = 現金売上高 - 計算上売上高
         #@d_sale_etc_detail.error_money = sum_uriage - @d_sale_etc_detail.meter
          @d_sale_etc_detail.error_money = @d_sale_etc_detail.meter - sum_uriage
      end
      @d_sale_etc_detail.created_user_id = current_user.id
      @d_sale_etc_detail.updated_user_id = current_user.id
      if @d_sale_etc_detail.etc_no == 99 then
        @d_sale_etc_detail.uriage = 0
      else
        @d_sale_etc_detail.uriage = @uriage
      end
      @d_sale_etc_detail.save!
    end
  end
  
  def update_d_sale_etc_detail(etc_cd,etc_no,sum_meter=0,sum_meter_mae=0)
    #2012/10/05 入力値>0の場合のみ登録 nishimura
    if params["meter_#{etc_cd}_#{etc_no}"].to_i > 0 or etc_no == 99
      @d_sale_etc_detail.meter = params["meter_#{etc_cd}_#{etc_no}"].to_i
      if etc_no == 99
        # UPDATE 2012.19.27 誤差 = 現金売上高 - 計算上売上高
        #@d_sale_etc_detail.error_money =  (sum_meter - sum_meter_mae) - @d_sale_etc_detail.meter
        @d_sale_etc_detail.error_money =  @d_sale_etc_detail.meter - (sum_meter - sum_meter_mae)
      end
      @d_sale_etc_detail.updated_user_id = current_user.id
      if @d_sale_etc_detail.etc_no == 99 then
        @d_sale_etc_detail.uriage = 0
      else
        @d_sale_etc_detail.uriage = @uriage
      end
      @d_sale_etc_detail.save!
    else
      #入力値>0の場合レコード削除
      @d_sale_etc_detail.destroy
    end
  end
end