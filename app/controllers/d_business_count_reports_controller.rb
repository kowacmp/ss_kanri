# -*- coding:utf-8 -*-
include DBusinessCountReportsHelper

class DBusinessCountReportsController < ApplicationController
  def index
    search
  end

  def search
    if params[:input_ymd] == nil
      # UPDAte 2012.09.29 日付の規定値は前日
      #@input_ymd = Time.now.strftime("%Y/%m/%d")
      @input_ymd = (Time.now - 60*60*24).strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    
    @ym = @input_ymd.delete("/")[0,6]
    @start_ymd = @ym + "01"
    @end_ymd = @ym + '31'
    
    #油外のみ
    @shops = MShop.where(:deleted_flg => 0,:shop_kbn => 1).order(:shop_cd).select('id,shop_name,shop_ryaku,shop_cd')
    #@m_oiletcs = MOiletc.find(:all,:conditions => ['oiletc_cd in (1,4,6,7,13)'],:order => 'oiletc_cd')
    @m_aims = MAim.where(:aim_code => 11..15).order('aim_code')
  end

  def print
    @input_ymd = params[:input_ymd].delete("/")
#    m_oiletcs = MOiletc.where(:oiletc_cd => 11..15).order('oiletc_cd')
#    m_oiletcs = MOiletc.find(:all,:conditions => ['oiletc_cd in (1,4,6,7,13)'],:order => 'oiletc_cd')
    @m_aims = MAim.where(:aim_code => 11..15).order('aim_code')
    ym = @input_ymd[0,6]
    #油外のみ
    shops = MShop.where(:deleted_flg => 0,:shop_kbn => 1).order(:shop_cd).select('id,shop_name,shop_ryaku,shop_cd')
    m_aims = MAim.where(:aim_code => 11..15).order('aim_code')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_business_count_report.tlf')

     #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:title).value("#{params[:input_ymd]}")   
    end #evants.on
 
    report.start_new_page
 
    report.page.list(:list).header do |h|
      #i = 0
      #m_oiletcs.each do |m_oiletc|
        #i = i + 1
        #h.item(:oiletc_1).value(MOiletc.find(:all,:conditions => ['oiletc_cd = 1']).first.oiletc_ryaku)
        #h.item(:oiletc_2).value(MOiletc.find(:all,:conditions => ['oiletc_cd = 4']).first.oiletc_ryaku)
        #h.item(:oiletc_3).value(MOiletc.find(:all,:conditions => ['oiletc_cd = 6']).first.oiletc_ryaku)
        #h.item(:oiletc_4).value(MOiletc.find(:all,:conditions => ['oiletc_cd = 13']).first.oiletc_ryaku)
        #h.item(:oiletc_5).value(MOiletc.find(:all,:conditions => ['oiletc_cd = 7']).first.oiletc_ryaku)

        #2012/09/28 nishimura <<<<<<<<<<<<<<<<
        #h.item(:oiletc_1).value(MOiletc.find(:all,:conditions => ['id = 1']).first.oiletc_ryaku)
        #h.item(:oiletc_2).value(MOiletc.find(:all,:conditions => ['id = 3']).first.oiletc_ryaku)
        #h.item(:oiletc_3).value(MOiletc.find(:all,:conditions => ['id = 4']).first.oiletc_ryaku)
        #h.item(:oiletc_4).value(MOiletc.find(:all,:conditions => ['id = 13']).first.oiletc_ryaku)
        #h.item(:oiletc_5).value(MOiletc.find(:all,:conditions => ['id = 7']).first.oiletc_ryaku)
        
        h.item(:oiletc_1).value(MOiletc.find(1) ? MOiletc.find(1).oiletc_name : "")
        h.item(:oiletc_2).value(MOiletc.find(4) ? MOiletc.find(4).oiletc_name : "")
        h.item(:oiletc_3).value(MOiletc.find(6) ? MOiletc.find(6).oiletc_name : "")
        h.item(:oiletc_4).value(MOiletc.find(13) ? MOiletc.find(13).oiletc_name : "")
        h.item(:oiletc_5).value(MOiletc.find(7) ? MOiletc.find(7).oiletc_name : "")
        h.item(:oiletc_6).value(MOiletc.find(20) ? MOiletc.find(20).oiletc_name : "")
        h.item(:oiletc_7).value(MOiletc.find(21) ? MOiletc.find(21).oiletc_name : "")
        #2012/09/28 nishimura >>>>>>>>>>>>>>>>>
        
        
        tmp_ymd = @input_ymd.to_time
        h.item(:month_1).value(tmp_ymd.month)
        tmp_ymd = tmp_ymd.next_month
        h.item(:month_2).value(tmp_ymd.month)
        tmp_ymd = tmp_ymd.next_month
        h.item(:month_3).value(tmp_ymd.month)
        tmp_ymd = tmp_ymd.next_month
        h.item(:month_4).value(tmp_ymd.month)
      #end
    end
    
    # 詳細作成
    shops.each do |shop|
      report.page.list(:list).add_row do |row|
        #油外ここから
        # 2012/10/11 帳票出力時店舗名over oda
        #row.item(:shop_name).value(shop.shop_name)
        row.item(:shop_name).value(shop.shop_ryaku)
        row.item(:aim_1).value(get_d_aim_total(ym,shop.id,11)) 
        row.item(:aim_2).value(get_d_aim_total(ym,shop.id,12)) 
        row.item(:aim_3).value(get_d_aim_total(ym,shop.id,13))
        row.item(:aim_4).value(get_d_aim_total(ym,shop.id,15))  #2012/09/28 nishimura 14 => 15 
        row.item(:aim_5).value(get_d_aim_total(ym,shop.id,14))  #2012/09/28 nishimura 15 => 14  
        row.item(:aim_6).value(get_d_aim_total(ym,shop.id,9)) 
        row.item(:aim_7).value(get_d_aim_total(ym,shop.id,10)) 
         #日計
        d_result = get_result(@input_ymd,shop.id)
        row.item(:day_1).value(get_d_result_collect_get_num(d_result,1))
        row.item(:day_2).value(get_d_result_collect_get_num(d_result,4))  #2012/09/28 nishimura 3 => 4
        row.item(:day_3).value(get_d_result_collect_get_num(d_result,6))  #2012/09/28 nishimura 4 => 6
        row.item(:day_4).value(get_d_result_collect_get_num(d_result,13))
        row.item(:day_5).value(get_d_result_collect_get_num(d_result,7))
        row.item(:day_6).value(get_d_result_oiletc_daily(d_result,20))
        row.item(:day_7).value(get_d_result_oiletc_daily(d_result,21))        
        #累計
        start_ymd = get_from_and_to_ymd(@input_ymd.to_time,1)
        end_ymd   = get_from_and_to_ymd(@input_ymd.to_time,2)
        d_results = get_results(start_ymd,end_ymd,shop.id)
        row.item(:sum_1).value(get_d_result_collect(d_results,1))
        row.item(:sum_2).value(get_d_result_collect(d_results,4))  #2012/09/28 nishimura 3 => 4
        row.item(:sum_3).value(get_d_result_collect(d_results,6))  #2012/09/28 nishimura 4 => 6
        row.item(:sum_4).value(get_d_result_collect(d_results,13))
        row.item(:sum_5).value(get_d_result_collect(d_results,7))
        row.item(:sum_6).value(get_d_result_oiletc(d_results,20))
        row.item(:sum_7).value(get_d_result_oiletc(d_results,21))
        #油外ここまで
        #車検予約   
        tmp_ymd = @input_ymd.to_time     
        from_ymd = get_from_and_to_ymd(tmp_ymd,1) 
        to_ymd = get_from_and_to_ymd(tmp_ymd,2) 
        row.item(:day_8).value(get_count_d_result_reserve_day(@input_ymd,@input_ymd[0,6],shop.id))
        row.item(:sum_8).value(get_count_d_result_reserve_month(from_ymd[0,6],shop.id)) 
        
        tmp_ymd = tmp_ymd.next_month
        from_ymd = get_from_and_to_ymd(tmp_ymd,1) 
        to_ymd = get_from_and_to_ymd(tmp_ymd,2) 
        row.item(:day_9).value(get_count_d_result_reserve_day(@input_ymd,from_ymd[0,6],shop.id))
        row.item(:sum_9).value(get_count_d_result_reserve_month(from_ymd[0,6],shop.id)) 
        
        tmp_ymd = tmp_ymd.next_month
        from_ymd = get_from_and_to_ymd(tmp_ymd,1) 
        to_ymd = get_from_and_to_ymd(tmp_ymd,2) 
        row.item(:day_10).value(get_count_d_result_reserve_day(@input_ymd,from_ymd[0,6],shop.id))
        row.item(:sum_10).value(get_count_d_result_reserve_month(from_ymd[0,6],shop.id)) 
        
        tmp_ymd = tmp_ymd.next_month
        from_ymd = get_from_and_to_ymd(tmp_ymd,1) 
        to_ymd = get_from_and_to_ymd(tmp_ymd,2) 
        row.item(:day_11).value(get_count_d_result_reserve_day(@input_ymd,from_ymd[0,6],shop.id))
        row.item(:sum_11).value(get_count_d_result_reserve_month(from_ymd[0,6],shop.id)) 

        
      end #add_row
    end # shops.each
    
    #ファイル名セット     
    pdf_title = "営業件数報告書_#{@input_ymd[0,6]}.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  end

end
