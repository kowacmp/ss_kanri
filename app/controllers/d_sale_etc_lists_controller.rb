include DSaleEtcListsHelper

class DSaleEtcListsController < ApplicationController
  def index
    search
  end

  def update
    @input_ymd   = params[:input_ymd]
    @input_ymd_s = @input_ymd.delete("/")
    #@d_wash_sales = get_d_wash_sales(@input_ymd_s)
    @d_sale_etcs = get_d_sale_etcs(@input_ymd_s)
    @wday = @input_ymd.to_time.wday
    
    #@d_wash_sales.each do |d_wash_sale|
    @d_sale_etcs.each do | d_sale_etc |
      unless params[:cbox] == nil
        if params[:cbox].include?(d_sale_etc.id.to_s)
          d_sale_etc.kakutei_flg = 1
        else
          d_sale_etc.kakutei_flg = 0
        end
      else
        d_sale_etc.kakutei_flg = 0
      end
      d_sale_etc.updated_user_id = current_user.id
      d_sale_etc.save!
    end
    
    respond_to do |format|
     @shop_kbn = params[:shop_kbn]
     @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
      format.html { render action: "index",:input_ymd => @input_ymd,:shop_kbn => @shop_kbn,
        notice: 'D wash sale was successfully updated.' }
    end
  end

  def search
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
      @shop_kbn = 0
    else
      @input_ymd = params[:input_ymd]      
      @shop_kbn = params[:shop_kbn]
    end
    
    @wday = @input_ymd.to_time.wday

    @input_ymd_s = @input_ymd.delete("/")
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
  end

  # INSERT 2012.10.03 AJAXでLOCKをかける
  def lock
    
    sale_etc = DSaleEtc.find(params[:id])
    if params[:kakutei_flg].to_s == "checked" then
      sale_etc.kakutei_flg = 1
    else
      sale_etc.kakutei_flg = 0
    end
    sale_etc.updated_user_id = current_user.id
    sale_etc.save!
    
    head :ok
  end

  # INSERT 2012.10.03 AJAXでLOCKをかける
  def lock_all
    
    ids = params[:ids].to_s.split(",")
    for id in ids
      sale_etc = DSaleEtc.find(id)
      if params[:kakutei_flg].to_s == "checked" then
        sale_etc.kakutei_flg = 1
      else
        sale_etc.kakutei_flg = 0
      end
      sale_etc.updated_user_id = current_user.id
      sale_etc.save!
    end
    
    head :ok
  end

end
