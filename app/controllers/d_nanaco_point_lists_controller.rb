# -*- coding:utf-8 -*-
include DNanacoPointListsHelper
  
class DNanacoPointListsController < ApplicationController
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
    sp1 = Hash.new
    sp2 = Hash.new
    sum_sp1 = 0
    sum_sp2 = 0


    nanaco_datas = Array::new
    @num = Date.parse(@to_ymd) - Date.parse(@from_ymd)
    for i in 0..@num.to_i
      result_date = (Date.parse(@from_ymd) + i).strftime("%Y%m%d")
      nanaco_point_data = get_nanaco_point(result_date,@shop_kbn)
      nanaco_point_data.each_with_index do |nanaco,idx|
       if i == 0
         nanaco_datas[idx] = Hash::new
       end
       nanaco_datas[idx][i] = nanaco
      end
    end
    
    shops = MShop.find(:all,:conditions => ['shop_kbn = ?', @shop_kbn],:order => 'shop_cd')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_nanaco_point_list.tlf')

    #ページ番号、タイトル、作成日セット  
      #title1 = "#{@from_ymd[0,4]}／#{@from_ymd[4,2]}"
      title1 = "#{@start_ymd}～#{@end_ymd}"
      if @shop_kbn == 0
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
        title2 = "ナナコポイント管理表（#{shop_kbn_name}）"
      elsif @shop_kbn == 1
        shop_kbn_name = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
        title2 = "ナナコポイント管理表（#{shop_kbn_name}）"
      else
        title2 = ""
      end
      

    #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:title1).value(title1)
      e.page.item(:title2).value(title2)
      @num = Date.parse(@to_ymd) - Date.parse(@from_ymd)
      for i in 0..@num.to_i
        e.page.item("d_#{i+1}").value((Date.parse(@from_ymd) + i).strftime("%m/%d"))
      end      
    end #evants.on
    
    report.start_new_page
 
    # 詳細作成
    nanaco_datas.each_with_index do |nanaco,idx|
      result_date = @from_ymd
      p1_sum_col = 0
      p2_sum_col = 0
      report.page.list(:list).add_row do |row|
      @num = Date.parse(@to_ymd) - Date.parse(@from_ymd)
      row.item(:shop_name).value(nanaco[0].shop_ryaku) 
        for i in 0..@num.to_i
          #row.item(:shop_name).value(nanaco[0].shop_ryaku) 
          unless nanaco[i] == nil
            row.item("p1_#{i+1}").value(nanaco[i].nanacopoint_num.to_i)
            p1_sum_col = p1_sum_col + nanaco[i].nanacopoint_num.to_i
            row.item("p2_#{i+1}").value(nanaco[i].nanacopoint.to_i)
            p2_sum_col = p2_sum_col + nanaco[i].nanacopoint.to_i
          end
        end #for
        row.item(:p1_sum).value(p1_sum_col)
        row.item(:p2_sum).value(p2_sum_col)
      end #add_row
    end # nanaco_datas.each_with_index
    
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
