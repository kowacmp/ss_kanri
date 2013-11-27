# -*- coding:utf-8 -*-
include DBankMoneyListsHelper
  
class DBankMoneyListsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DResult.minimum("result_date")[0,4].to_i
    
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
        @shop_kbn = 0
      else
        if (params[:result_date]) == nil || (params[:result_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
          @shop_kbn = params[:shop_kbn]
        else
          @year  = params[:result_date][0,4]
          @month = params[:result_date][4,2]
          @shop_kbn = params[:shop_kbn]
        end
      end
      @this_month = @year + @month
      @from_ymd = @this_month + '01'
      @to_ymd = @this_month + '31'
      
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    

  end

  def print
    @shop_kbn = params[:shop_kbn].to_i
    @from_ymd = params[:from_ymd]
    @to_ymd   = params[:to_ymd]
    sp1 = Hash.new
    sp2 = Hash.new
    
    start_ymd = (@from_ymd[0,4].to_s + '/' + @from_ymd[4,2] + '/' + @from_ymd[6,2]).to_time
    start_day = start_ymd.end_of_month.day

    shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_bank_money_list.tlf')

    #ページ番号、タイトル、作成日セット  
      title1 = "#{@from_ymd[0,4]}／#{@from_ymd[4,2]}"
      if @shop_kbn == 0
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
        title2 = "銀行預金一覧表（#{shop_kbn_name}）"
      elsif @shop_kbn == 1
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
        title2 = "銀行預金一覧表（#{shop_kbn_name}）"
      else
        title2 = ""
      end
      

    #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:title1).value(title1)
      e.page.item(:title2).value(title2)
      start_day.times do |i|
        e.page.item("d_#{i+1}").value(i+1)
      end      
    end #evants.on
    
    report.start_new_page
 
    # 詳細作成
    shops.each do |shop|
      result_date = @from_ymd
      report.page.list(:list).add_row do |row|
        start_day.times do |i|
          bank_moneys = get_bank_money(result_date,shop.id)
          result_date = (result_date.to_i + 1).to_s
          row.item(:shop_name).value(shop.shop_ryaku) 
          unless bank_moneys == nil
            row.item("p1_#{i+1}").value(bank_moneys.to_i)
          end
        end #start_day.times
      end #add_row
    end # shops.each


    #ファイル名セット     
    pdf_title = "#{title2}_#{@from_ymd[0,6]}.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
                               
  end #def print

end
