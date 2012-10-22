class MPriceChkNamesController < ApplicationController

  def index
    
    @m_price_chk_name = MPriceChkName.find(1)

    respond_to do |format|
      format.html # index.html.erb
    end
    
  end

  def update
    
    @m_price_chk_name = MPriceChkName.find(1)
    @m_price_chk_name.attributes = params[:m_price_chk_name]
    @m_price_chk_name.save!
    
    redirect_to :action => "index"
    
  end

end
