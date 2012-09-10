class DBusinessCountReportsController < ApplicationController
  def index
    search
  end

  def search
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    
    @ym = @input_ymd.delete("/")[0,6]
    
    @shops = MShop.where(:deleted_flg => 0).order(:shop_cd).select('id,shop_name,shop_ryaku,shop_cd')
    @m_aims = MAim.where(:aim_code => 11..15).order('aim_code')
  end

  def print
  end

end
