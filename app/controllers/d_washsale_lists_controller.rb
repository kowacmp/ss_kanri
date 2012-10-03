include DWashSalesHelper

class DWashsaleListsController < ApplicationController
  def index
    search
  end

  def update
    @input_ymd   = params[:input_ymd]
    @input_ymd_s = @input_ymd.delete("/")
    @d_wash_sales = get_d_wash_sales(@input_ymd_s)
    @wday = @input_ymd.to_time.wday
    
    @d_wash_sales.each do |d_wash_sale|
      unless params[:cbox] == nil
        if params[:cbox].include?(d_wash_sale.id.to_s)
          d_wash_sale.kakutei_flg = 1
        else
          d_wash_sale.kakutei_flg = 0
        end
      else
        d_wash_sale.kakutei_flg = 0
      end
      d_wash_sale.updated_user_id = current_user.id
      d_wash_sale.save!
    end
    
    respond_to do |format|
     @shop_kbn = params[:shop_kbn]
     @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
      format.html { render action: "index",:input_ymd => @input_ymd,:shop_kbn => @shop_kbn,
        notice: 'D wash sale was successfully updated.' }
    end
  end

  def show
    @m_washsale_plans = MWashsalePlan.find(:all,:conditions => ['m_shop_id = ?',
           params[:m_shop_id]],:order => 'm_wash_id')
    render :layout => 'modal'
  end

  def compare
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
    
    wash_sale = DWashSale.find(params[:id])
    if params[:kakutei_flg].to_s == "checked" then
      wash_sale.kakutei_flg = 1
    else
      wash_sale.kakutei_flg = 0
    end
    wash_sale.updated_user_id = current_user.id
    wash_sale.save!
    
    head :ok
  end

  # INSERT 2012.10.03 AJAXでLOCKをかける
  def lock_all
    
    ids = params[:ids].to_s.split(",")
    for id in ids
      wash_sale = DWashSale.find(id)
      if params[:kakutei_flg].to_s == "checked" then
        wash_sale.kakutei_flg = 1
      else
        wash_sale.kakutei_flg = 0
      end
      wash_sale.updated_user_id = current_user.id
      wash_sale.save!
    end
    
    head :ok
  end

end
