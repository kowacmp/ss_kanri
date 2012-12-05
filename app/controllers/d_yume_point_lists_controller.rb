# -*- coding:utf-8 -*-
include DYumePointListsHelper
  
class DYumePointListsController < ApplicationController
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
    sum_sp1 = 0
    sum_sp2 = 0
    #2012/10/11 支払額追加
    sp3 = Hash.new
    sum_sp3 = 0
    
    #2012/11/07 add
    shop_kbn_footer = 0
    sum_sp2_2 = 0
    sum_sp3_2 = 0
    
    start_ymd = (@from_ymd[0,4].to_s + '/' + @from_ymd[4,2] + '/' + @from_ymd[6,2]).to_time
    start_day = start_ymd.end_of_month.day

    shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_yume_point_list.tlf')

    report.layout.config.list(:list) do
    # フッターに合計をセット.
      result_date = @from_ymd
      events.on :footer_insert do |e|
        start_day.times do |i|
          e.section.item("sp1_#{i+1}").value(sp1[i+1])
          e.section.item("sp2_#{i+1}").value(sp2[i+1])
          #2012/10/11 支払額追加
          e.section.item("sp3_#{i+1}").value(sp3[i+1])
        end # times
        e.section.item(:sp1_sum).value(sum_sp1)
        e.section.item(:sp2_sum).value(sum_sp2)
        #2012/10/11 支払額追加
        e.section.item(:sp3_sum).value(sum_sp3)
        
        #2012/11/07 add
        shop_kbn_name1 = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
        shop_kbn_name2 = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
        #s1：油外　s2：洗車
        e.section.item(:s1_label).value("支払額(#{shop_kbn_name2})")
        e.section.item(:s2_label).value("支払額(#{shop_kbn_name1})")
        #2012/12/05 総合計追加
        e.section.item(:all_label).value("総合計")
        if shop_kbn_footer == 0
          e.section.item(:s1_sum).value(sum_sp2_2 + sum_sp3_2)
          e.section.item(:s2_sum).value(sum_sp2 + sum_sp3)
          #2012/12/05 総合計追加
          e.section.item(:all_sum).value(sum_sp2 + sum_sp3 + sum_sp2_2 + sum_sp3_2)
        else
          e.section.item(:s1_sum).value(sum_sp2 + sum_sp3)
          e.section.item(:s2_sum).value(sum_sp2_2 + sum_sp3_2)
         #2012/12/05 総合計追加
          e.section.item(:all_sum).value(sum_sp2 + sum_sp3 + sum_sp2_2 + sum_sp3_2)
        end
        
      end #events.on
    end #list


    #ページ番号、タイトル、作成日セット  
      title1 = "#{@from_ymd[0,4]}／#{@from_ymd[4,2]}"
      if @shop_kbn == 0
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
        title2 = "夢ポイント管理表（#{shop_kbn_name}）"
      elsif @shop_kbn == 1
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
        title2 = "夢ポイント管理表（#{shop_kbn_name}）"
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
      p1_sum_col = 0
      p2_sum_col = 0
      #2012/10/11 支払額追加
      p3_sum_col = 0
    # Set header datas.
      report.page.list(:list).add_row do |row|
        start_day.times do |i|
          yume_points = get_yume_point(result_date,shop.id)
          result_date = (result_date.to_i + 1).to_s
          row.item(:shop_name).value(shop.shop_ryaku) 
          unless yume_points == nil
            row.item("p1_#{i+1}").value(yume_points.yumepoint_num.to_i)
            p1_sum_col = p1_sum_col + yume_points.yumepoint_num.to_i
            #2012/10/11 支払額追加
            row.item("p2_#{i+1}").value(yume_points.yumepoint.to_i)
            p2_sum_col = p2_sum_col + yume_points.yumepoint.to_i
            #row.item("p3_#{i+1}").value(yume_points.pay_money.to_i)
            #p3_sum_col = p3_sum_col + yume_points.pay_money.to_i
          end
        end #start_day.times
        row.item(:p1_sum).value(p1_sum_col)
        #2012/10/11 支払額追加
        row.item(:p2_sum).value(p2_sum_col)
        #row.item(:p3_sum).value(p3_sum_col)
      end #add_row
    end # shops.each

    #フッター用合計データ作成
    result_date = @from_ymd
    start_day.times do |i|
      sum_point = sum_rows_yume_points(result_date,@shop_kbn)
      #result_date = (result_date.to_i + 1).to_s  #2012/11/07 loopの最後に移動
      sp1[i+1] = sum_point.yumepoint_num.to_i
      #2012/10/11 支払額追加
      sp2[i+1] = sum_point.yumepoint.to_i
      sp3[i+1] = sum_point.pay_money.to_i
      sum_sp1 = sum_sp1 + sum_point.yumepoint_num.to_i unless sum_point == nil
      #2012/10/11 支払額追加
      sum_sp2 = sum_sp2 + sum_point.yumepoint.to_i unless sum_point == nil
      sum_sp3 = sum_sp3 + sum_point.pay_money.to_i unless sum_point == nil 
      
      #2012/11/07 add
      #別区分のデータ取得
      if @shop_kbn == 0
        shop_kbn_footer = @shop_kbn
        sum_point_2 = sum_rows_yume_points(result_date,1)
      else
        shop_kbn_footer = @shop_kbn
        sum_point_2 = sum_rows_yume_points(result_date,0)
      end
      sum_sp2_2 = sum_sp2_2 + sum_point_2.yumepoint.to_i unless sum_point_2 == nil
      sum_sp3_2 = sum_sp3_2 + sum_point_2.pay_money.to_i unless sum_point_2 == nil 
      
      result_date = (result_date.to_i + 1).to_s
      
    end

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
