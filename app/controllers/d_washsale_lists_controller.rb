include DWashSalesHelper

class DWashsaleListsController < ApplicationController
  def index
    search
  end

  def update
    @input_ymd   = params[:input_ymd]
    @input_ymd_s = @input_ymd.delete("/")
    @d_wash_sales = get_d_wash_sales(@input_ymd_s)
    
    @d_wash_sales.each do |d_wash_sale|
      if params[:cbox].include?(d_wash_sale.id.to_s)
        d_wash_sale.kakutei_flg = 1
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

    @input_ymd_s = @input_ymd.delete("/")
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
  end

end
