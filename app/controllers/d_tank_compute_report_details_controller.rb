# -*- coding:utf-8 -*-
include DTankComputeReportDetailsHelper
include DResultsHelper
class DTankComputeReportDetailsController < ApplicationController
  def index
    search
  end

  def search
    @mode = params[:mode]
    if params[:mode] == 'manager'
      @shop_id = params[:shop_id]
    else
      @shop_id = current_user.m_shop_id
    end    
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DResult.minimum("result_date",:conditions => ['m_shop_id = ?',@shop_id])[0,4].to_i
    
      if params[:date] == nil or params[:date] == ''
        @year = @time_now.year.to_s
        @month = format_month(@time_now.month)
        @shop_kbn = 0
      else
        if (params[:result_date]) == nil || (params[:result_date]) == ""
          @year = params[:date][:year].to_s
          @month = format_month(params[:date][:month])
          @shop_kbn = params[:shop_kbn]
          #2012/11/12 表示対象年月　上書き
          @time_now = Time.mktime(@year.to_i,@month.to_i,1)
        else
          @year  = params[:result_date][0,4]
          @month = params[:result_date][4,2]
          @shop_kbn = params[:shop_kbn]
          #2012/11/12 表示対象年月　上書き
          @time_now = Time.mktime(@year.to_i,@month.to_i,1)
        end
      end
      @this_month = @year + @month
      @from_ymd = @this_month + '01'
      @to_ymd = @this_month + '31'
      @last_month_last_day = (@from_ymd[0,4] + "/" + @from_ymd[4,2] + "/" + @from_ymd[6,2]).to_time.yesterday
      @dr_lastday = DResult.find(:all,
          :conditions => ['result_date = ? and m_shop_id = ?',@last_month_last_day.strftime("%Y%m%d"),@shop_id]).first

      
      @tank_id = params[:select_tank].to_i unless params[:select_tank] == nil
      @oil_id = params[:select_oil].to_i unless params[:select_oil] == nil
     if  params[:select_tank] == nil && params[:select_oil] == nil
       @oil_id = 1
     end
#      p "*** oil_id = #{@oil_id} ***"
        @d_results = DResult.find(:all,
          :conditions => ['result_date between ? and ? and m_shop_id = ?',@from_ymd,@to_ymd,@shop_id])
          

  end

  def change_radio
    @shop_id = params[:shop_id].to_i
    @rbtn = params[:rbtn].to_i
  end

  def change_oil
    @oil_id = params[:oil_id]
    @shop_id = params[:shop_id]
  end
  
  def print
    @mode = params[:mode]
    if params[:mode] == 'manager'
      @shop_id = params[:shop_id]
    else
      @shop_id = current_user.m_shop_id
    end   
    
      sum_receive        = 0
      sum_compute_stock  = 0
      sum_decrease       = 0
      last_sale_total    = 0
      sum_decrease_total = 0
      sum_sale           = 0
      tank_no            = Array.new
      tank_volume = 0
      @tank_id = params[:tank_id].to_i unless params[:tank_id] == nil
      @oil_id = params[:oil_id].to_i unless params[:oil_id] == nil
      @from_ymd = params[:from_ymd]
      @to_ymd = params[:to_ymd]
      
      last_month_last_day = (@from_ymd[0,4] + "/" + @from_ymd[4,2] + "/" + @from_ymd[6,2]).to_time.yesterday
      dr_lastday = DResult.find(:all,
          :conditions => ['result_date = ? and m_shop_id = ?',last_month_last_day.strftime("%Y%m%d"),@shop_id]).first

      unless params[:oil_id] == nil or params[:oil_id] == "" # 油種の場合
        tank_compute_last = get_select_oil(dr_lastday.id,@oil_id,@shop_id) unless dr_lastday == nil
      end
      unless params[:tank_id] == nil or params[:tank_id] == "" #タンクの場合
       tank_compute_last = get_select_tank(dr_lastday.id,@tank_id,@shop_id) unless dr_lastday == nil 
      end

      report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_tank_compute_report.tlf')


      report.layout.config.list(:list) do
         # フッターに合計をセット.
         events.on :page_footer_insert do |e|
           e.section.item(:sum_receive).value(sum_receive)
           #2012/11/20 合計項目非表示 oda
           #e.section.item(:sum_sale).value(sum_sale)
           #e.section.item(:sum_compute_stock).value(sum_compute_stock)
           #e.section.item(:sum_decrease).value(sum_decrease)
           e.section.item(:sum_sale_total).value(last_sale_total)
           e.section.item(:sum_decrease_total).value(sum_decrease_total)
           e.section.item(:sum_total_percentage).value(sprintf("%-8.3f",(sum_decrease_total * 1.000 / last_sale_total *1.000)*100) + '%')
         end
       end


      report.start_new_page do |page|
        page.item(:year).value(params[:from_ymd][0,4])
        page.item(:month).value(params[:from_ymd][4,2].to_i)
        unless params[:oil_id] == nil or params[:oil_id] == ""
          tanks = MTank.find(:all,:conditions => ['m_oil_id = ? and m_shop_id = ? deleted_flg = 0',params[:oil_id],@shop_id],:order => 'tank_no')
          tanks.each do |tank|
            tank_no << tank.tank_no
            tank_volume = tank_volume + tank.volume
            page.item(:tank_no).value(tank_no.join(","))
          end
        else
          tank_no = get_tank_ids_tank(params[:tank_id],@shop_id,1)
          tank_volume = get_tank_ids_tank(params[:tank_id],@shop_id,2)
          page.item(:tank_no).value(tank_no)
        end
        page.item(:tank_volume).value(tank_volume)
        page.item(:oil_name).value(MOil.find(@oil_id).oil_name) unless params[:oil_id] == nil or params[:oil_id] == ""
        unless params[:tank_id] == nil or params[:tank_id] == ""
          tank = MTank.find(params[:tank_id]) 
          page.item(:oil_name).value(MOil.find(tank.m_oil_id).oil_name)
        end
        #2012/11/20 照会一覧より印刷時は、記録責任者はSS名 oda
        if params[:mode] == 'manager'
          @m_shop = MShop.find(@shop_id)
          page.item(:user_name).value(@m_shop.shop_ryaku)
        else
          page.item(:user_name).value(current_user.user_name)
        end   

        unless tank_compute_last == nil
          page.item(:receive_last).value(tank_compute_last.receive)
          page.item(:sale_last).value(tank_compute_last.sale)
          page.item(:after_stock_last).value(tank_compute_last.after_stock)
        end
      end


      @d_results = DResult.find(:all,
      :conditions => ['result_date between ? and ? and m_shop_id = ?',@from_ymd,@to_ymd,@shop_id])

      get_ymd = @from_ymd
      start_ymd = (@from_ymd[0,4].to_s + '/' + @from_ymd[4,2] + '/' + @from_ymd[6,2]).to_time
      start_day = start_ymd.end_of_month.day
      
    start_day.times do |i|
      result = DResult.find(:all,:conditions => ['result_date = ? and m_shop_id = ?',get_ymd,@shop_id]).first
      get_ymd = (get_ymd.to_i + 1).to_s
      unless params[:oil_id] == nil or params[:oil_id] == "" # 油種の場合
        tank_compute = get_select_oil(result.id,@oil_id,@shop_id) unless result == nil
        #p "***** tank_compute_oil = #{tank_compute}"
      end
      unless params[:tank_id] == nil or params[:tank_id] == "" #タンクの場合
       tank_compute = get_select_tank(result.id,@tank_id,@shop_id) unless result == nil 
         #p "***** tank_compute_tank = #{tank_compute}"
      end
      
      report.page.list(:list).add_row do |row|
        row.item(:day).value(i+1)
        row.item(:wday).value(day_of_the_week(start_ymd.wday))
        start_ymd = start_ymd.tomorrow
        unless tank_compute == nil
          if tank_compute.inspect_flg > 0
            row.item(:inspect_flg).value("○")
          end 
        #前日営業終了後の実在庫量
        row.item(:before_stock).value(tank_compute.before_stock)
        #ローリーからの受入数量
        row.item(:receive).value(tank_compute.receive)
        sum_receive = sum_receive + tank_compute.receive
        #計量機からの販売数量
        row.item(:sale).value(tank_compute.sale)
        #2012/11/20 合計項目非表示 oda
        #2012/11/15 計量機からの販売数量
        #sum_sale = sum_sale + tank_compute.sale
        #計算在庫量
        row.item(:compute_stock).value(tank_compute.compute_stock)
        #2012/11/20 合計項目非表示 oda
        #2012/11/12 最終日の計算在庫量を取得
        #sum_compute_stock = sum_compute_stock + tank_compute.compute_stock
        #sum_compute_stock = tank_compute.compute_stock
        #当日営業終了後の実在庫量
        row.item(:after_stock).value(tank_compute.after_stock)
        #本日の増減
        row.item(:decrease).value(tank_compute.decrease)
        #2012/11/20 合計項目非表示 oda
        #sum_decrease = sum_decrease + tank_compute.decrease
        #計量機からの販売数量
        row.item(:sale_total).value(tank_compute.sale_total)
        last_sale_total = tank_compute.sale_total
        #増減累計
        row.item(:decrease_total).value(tank_compute.decrease_total)
        #2012/11/12 最終日の増減累計を取得
        #sum_decrease_total = sum_decrease_total + tank_compute.decrease_total
        sum_decrease_total = tank_compute.decrease_total
        row.item(:total_percentage).value(sprintf("%-8.3f",(tank_compute.decrease_total * 1.000 / tank_compute.sale_total * 1.000)*100) + '%')

        end #unless   
    
      end
    end

      #タイトルセット
      
      pdf_title = "地下タンク集計表（タンク）_#{@from_ymd[0,6]}.pdf"   unless params[:tank_id] == nil
      pdf_title = "地下タンク集計表（油種）_#{@from_ymd[0,6]}.pdf"  unless params[:oil_id] == nil
      ua = request.env["HTTP_USER_AGENT"]
      pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
          
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  #end
  end

end
