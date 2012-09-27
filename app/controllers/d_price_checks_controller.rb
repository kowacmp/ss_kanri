# -*- coding:utf-8 -*-
class DPriceChecksController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DPriceCheckEtc.minimum("research_day")
    if @start_year == nil
      @start_year = @time_now.year.to_i
    else
      @start_year = @start_year[0,4].to_i
    end    
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
        
        @etc_shops = MEtcShop.where(:m_shop_id => current_user.m_shop_id).order('access_group,id')
        @etc_shops.each do |etc_shop|
          price_check_etc = DPriceCheckEtc.new
          price_check_etc.m_etc_shop_id = etc_shop.id
          price_check_etc.research_day  = @research_day
          price_check_etc.research_time = @research_time
          price_check_etc.created_user_id = current_user.id
          price_check_etc.updated_user_id = current_user.id
          price_check_etc.save!
        end
    
        
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

  def print
    @research_day  = params[:research_day]
    @research_time = params[:research_time]
    price_check = DPriceCheck.where(:research_day => @research_day,:research_time => @research_time,
      :m_shop_id => current_user.m_shop_id).first
  
    etc_shops = MEtcShop.where(:m_shop_id => current_user.m_shop_id).order('access_group,id')
    
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_price_check_report.tlf')

     #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:year).value(@research_day[0,4].to_i)
      e.page.item(:month).value(@research_day[4,2].to_i)
      e.page.item(:day).value(@research_day[6,2].to_i)
      e.page.item(:hour).value(@research_time.to_i)
      e.page.item(:shop_name).value(current_user.m_shop.shop_ryaku)
      e.page.item(:rg_price1).value(price_check.rg_price1)
      e.page.item(:rg_price2).value(price_check.rg_price2)
      e.page.item(:rg_price3).value(price_check.rg_price3)
      e.page.item(:rg_price4).value(price_check.rg_price4)
      e.page.item(:rg_price5).value(price_check.rg_price5)
      e.page.item(:rg_price6).value(price_check.rg_price6)      
      e.page.item(:hg_price1).value(price_check.hg_price1)
      e.page.item(:hg_price2).value(price_check.hg_price2)
      e.page.item(:hg_price3).value(price_check.hg_price3)
      e.page.item(:hg_price4).value(price_check.hg_price4)
      e.page.item(:hg_price5).value(price_check.hg_price5)
      e.page.item(:hg_price6).value(price_check.hg_price6)
      e.page.item(:kg_price1).value(price_check.kg_price1)
      e.page.item(:kg_price2).value(price_check.kg_price2)
      e.page.item(:kg_price3).value(price_check.kg_price3)
      e.page.item(:kg_price4).value(price_check.kg_price4)
      e.page.item(:kg_price5).value(price_check.kg_price5)
      e.page.item(:kg_price6).value(price_check.kg_price6)
      e.page.item(:tg_price1).value(price_check.tg_price1)
      e.page.item(:tg_price2).value(price_check.tg_price2)
      e.page.item(:tg_price3).value(price_check.tg_price3)
      e.page.item(:tg_price4).value(price_check.tg_price4)
      e.page.item(:tg_price5).value(price_check.tg_price5)
      e.page.item(:tg_price6).value(price_check.tg_price6)      
      #e.page.item(:note1).value(price_check.note1)
      #e.page.item(:note2).value(price_check.note2)
      #e.page.item(:note3).value(price_check.note3)
      #e.page.item(:note4).value(price_check.note4)
      #e.page.item(:note5).value(price_check.note5)
      #e.page.item(:note6).value(price_check.note6)
    end #evants.on
 
    report.start_new_page
 
    # 詳細作成
    etc_shops.each do |etc_shop|
      price_check_etc = DPriceCheckEtc.where(:research_day => @research_day,
          :research_time => @research_time,:m_etc_shop_id => etc_shop.id).first
     unless price_check_etc == nil
      report.page.list(:list).add_row do |row|
        #油外ここから
        row.item(:rg_price1).value(price_check_etc.rg_price1)
        row.item(:rg_price2).value(price_check_etc.rg_price2)
        row.item(:rg_price3).value(price_check_etc.rg_price3)
        row.item(:rg_price4).value(price_check_etc.rg_price4)
        row.item(:rg_price5).value(price_check_etc.rg_price5)
        row.item(:hg_price1).value(price_check_etc.hg_price1)
        row.item(:hg_price2).value(price_check_etc.hg_price2)
        row.item(:hg_price3).value(price_check_etc.hg_price3)
        row.item(:hg_price4).value(price_check_etc.hg_price4)
        row.item(:hg_price5).value(price_check_etc.hg_price5)
        row.item(:kg_price1).value(price_check_etc.kg_price1)
        row.item(:kg_price2).value(price_check_etc.kg_price2)
        row.item(:kg_price3).value(price_check_etc.kg_price3)
        row.item(:kg_price4).value(price_check_etc.kg_price4)
        row.item(:kg_price5).value(price_check_etc.kg_price5)
        row.item(:tg_price1).value(price_check_etc.tg_price1)
        row.item(:tg_price2).value(price_check_etc.tg_price2)
        row.item(:tg_price3).value(price_check_etc.tg_price3)
        row.item(:tg_price4).value(price_check_etc.tg_price4)
        row.item(:tg_price5).value(price_check_etc.tg_price5)
        row.item(:note).value(price_check_etc.note)
      end #add_row
     end # unless
    end # times

    #ファイル名セット     
    pdf_title = "価格調査表.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  end
end
