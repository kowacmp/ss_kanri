# -*- coding:utf-8 -*-
include DBankMoneyListsHelper
  
class DBankMoneyListsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    
    if params[:start_ymd] == nil or params[:start_ymd] == ""
      @start_ymd   = (Time.now).prev_month.strftime("%Y/%m/%d")
    else
      @start_ymd = params[:start_ymd]
    end
    if params[:end_ymd] == nil or params[:end_ymd] == ""
      @end_ymd = (Time.now - 60*60*24).strftime("%Y/%m/%d")
    else
      @end_ymd   = params[:end_ymd]     
    end

    if params[:start_ymd] == nil or params[:start_ymd] == ''
      @shop_kbn = 0
    else
      @shop_kbn = params[:shop_kbn]
    end

    @from_ymd = @start_ymd.delete("/")
    @to_ymd = @end_ymd.delete("/")
      
    @shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    @num = Date.parse(@to_ymd) - Date.parse(@from_ymd)
    if @from_ymd > @to_ymd
      respond_to do |format|
        format.js { render :text => "alert('対象日の範囲を確認してください。');" }
      end 
      return 
    end
    if @num >= 31
      respond_to do |format|
        format.js { render :text => "alert('対象日の範囲は３１日以内です。');" }
      end 
      return 
    end

  end

  def print
    @shop_kbn = params[:shop_kbn].to_i
    @from_ymd = params[:from_ymd]
    @to_ymd   = params[:to_ymd]
    @start_ymd = params[:start_ymd]
    @end_ymd   = params[:end_ymd]
    
    @num = Date.parse(@to_ymd) - Date.parse(@from_ymd)
    
    sp1 = Hash.new
    sp2 = Hash.new
    
    start_ymd = (@from_ymd[0,4].to_s + '/' + @from_ymd[4,2] + '/' + @from_ymd[6,2]).to_time
    start_day = start_ymd.end_of_month.day

    shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_bank_money_list.tlf')

    #ページ番号、タイトル、作成日セット  
      #title1 = "#{@from_ymd[0,4]}／#{@from_ymd[4,2]}"
      title1 = "#{@start_ymd}～#{@end_ymd}"
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
      #start_day.times do |i|
      #  e.page.item("d_#{i+1}").value(i+1)
      #end      
      for i in 0..@num.to_i
        e.page.item("d_#{i+1}").value((Date.parse(@from_ymd) + i).strftime("%m/%d"))
      end
    end #evants.on
    
    report.start_new_page
 
    # 詳細作成
    shops.each do |shop|
      #result_date = @from_ymd
      report.page.list(:list).add_row do |row|
        #start_day.times do |i|
        for i in 0..@num.to_i
          result_date = (Date.parse(@from_ymd) + i).strftime("%Y%m%d")
          bank_moneys = get_bank_money(result_date,shop.id)
          #result_date = (result_date.to_i + 1).to_s
          row.item(:shop_name).value(shop.shop_ryaku) 
          unless bank_moneys == nil
            row.item("p1_#{i+1}").value(bank_moneys.to_i)
          end
        end #start_day.times
      end #add_row
    end # shops.each


    #ファイル名セット     
    #pdf_title = "#{title2}_#{@from_ymd[0,6]}.pdf"
    pdf_title = "#{title2}_#{@from_ymd}_#{@to_ymd}.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
                               
  end #def print

end
