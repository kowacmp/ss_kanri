class DPriceChecksController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DPriceCheckEtc.minimum("research_day")[0,4].to_i
    
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
      else
        if (params[:result_date]) == nil || (params[:result_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
        else
          @year  = params[:result_date][0,4]
          @month = params[:result_date][4,2]
        end
      end
      @this_month = @year + @month
      @from_ymd = @this_month + '01'
      @to_ymd = @this_month + '31'
      #p "*** from_ymd = #{@from_ymd} to_ymd = #{@to_ymd} ***"
      @d_price_checks = DPriceCheck.where(:research_day => @from_ymd..@to_ymd).group(
        'research_day,research_time').select(
          'research_day,research_time').order(
            'research_day,research_time')
      
     @research_day = Time.now.strftime("%Y/%m/%d")

  end

  def edit
    unless  params[:research_day].length == 8
      @research_day  = params[:research_day].delete("/")
    else
      @research_day  = params[:research_day]
    end
    if params[:date] == nil or params[:date] == ""
      @research_time = params[:research_time]
    else
      @research_time = params[:date][:hour]
    end
    @price_check = DPriceCheck.where(:research_day => @research_day,:research_time => @research_time,
      :m_shop_id => current_user.m_shop_id).first
  end

  def update
    @research_day  = params[:research_day]
    @research_time = params[:research_time].to_i

    #更新
      price_check = DPriceCheck.where(:research_day => @research_day,
          :research_time => @research_time,:m_shop_id => current_user.m_shop_id).first
      #p "price_check.id = #{price_check.id}"
      #p "price_check.id = #{price_check.id}"
      unless price_check == nil
        #更新
        price_check.rg_price1 = params["rg_price1"]
        price_check.hg_price1 = params["hg_price1"]
        price_check.kg_price1 = params["kg_price1"]
        price_check.tg_price1 = params["tg_price1"]
        price_check.rg_price2 = params["rg_price2"]
        price_check.hg_price2 = params["hg_price2"]
        price_check.kg_price2 = params["kg_price2"]
        price_check.tg_price2 = params["tg_price2"]
        price_check.rg_price3 = params["rg_price3"]
        price_check.hg_price3 = params["hg_price3"]
        price_check.kg_price3 = params["kg_price3"]
        price_check.tg_price3 = params["tg_price3"]
        price_check.rg_price4 = params["rg_price4"]
        price_check.hg_price4 = params["hg_price4"]
        price_check.kg_price4 = params["kg_price4"]
        price_check.tg_price4 = params["tg_price4"]
        price_check.rg_price5 = params["rg_price5"]
        price_check.hg_price5 = params["hg_price5"]
        price_check.kg_price5 = params["kg_price5"]
        price_check.tg_price5 = params["tg_price5"]
        price_check.rg_price6 = params["rg_price6"]
        price_check.hg_price6 = params["hg_price6"]
        price_check.kg_price6 = params["kg_price6"]
        price_check.tg_price6 = params["tg_price6"]
        price_check.updated_user_id = current_user.id
        price_check.save!
      else
        #新規
        price_check = DPriceCheck.new
        price_check.m_shop_id = current_user.m_shop_id
        price_check.research_day  = @research_day
        price_check.research_time = @research_time
        price_check.rg_price1 = params["rg_price1"]
        price_check.hg_price1 = params["hg_price1"]
        price_check.kg_price1 = params["kg_price1"]
        price_check.tg_price1 = params["tg_price1"]
        price_check.rg_price2 = params["rg_price2"]
        price_check.hg_price2 = params["hg_price2"]
        price_check.kg_price2 = params["kg_price2"]
        price_check.tg_price2 = params["tg_price2"]
        price_check.rg_price3 = params["rg_price3"]
        price_check.hg_price3 = params["hg_price3"]
        price_check.kg_price3 = params["kg_price3"]
        price_check.tg_price3 = params["tg_price3"]
        price_check.rg_price4 = params["rg_price4"]
        price_check.hg_price4 = params["hg_price4"]
        price_check.kg_price4 = params["kg_price4"]
        price_check.tg_price4 = params["tg_price4"]
        price_check.rg_price5 = params["rg_price5"]
        price_check.hg_price5 = params["hg_price5"]
        price_check.kg_price5 = params["kg_price5"]
        price_check.tg_price5 = params["tg_price5"]
        price_check.rg_price6 = params["rg_price6"]
        price_check.hg_price6 = params["hg_price6"]
        price_check.kg_price6 = params["kg_price6"]
        price_check.tg_price6 = params["tg_price6"]
        price_check.created_user_id = current_user.id
        price_check.updated_user_id = current_user.id
        price_check.save!
      end #unless

    @price_check = DPriceCheck.where(:research_day => @research_day,:research_time => @research_time,
      :m_shop_id => current_user.m_shop_id).first

    #edit
    respond_to do |format|
      format.html { render action: "edit" }
    end
  end
  
  def show
    @research_day  = params[:research_day]
    @research_time = params[:research_time]
    @price_check = DPriceCheck.where(:research_day => @research_day,:research_time => @research_time,
      :m_shop_id => current_user.m_shop_id).first
  end

end
