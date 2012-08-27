class DTankDecreaseReportsController < ApplicationController
  def index
          search 
  end

  def search
    @rbtn = params[:rbtn]
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    @input_ymd_s = @input_ymd.delete("/")
    
    @groups = MShopGroup.find(:all,[:conditions => 'deleted_flg = 0',:order => 'group_cd'])
    
  end
  def print
  end

end
