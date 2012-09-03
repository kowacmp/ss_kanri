# -*- coding:utf-8 -*-
include DTankComputeReportDetailsHelper

class DTankComputeReportDetailsController < ApplicationController
  def index
    search
  end

  def search
    @time_now = Time.now
    #select_yearの開始年
    @start_year = DResult.minimum("result_date",:conditions => ['m_shop_id = ?',current_user.m_shop_id])[0,4].to_i

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

      
      @tank_id = params[:select_tank].to_i unless params[:select_tank] == nil
      @oil_id = params[:select_oil].to_i unless params[:select_oil] == nil

      
      @d_results = DResult.find(:all,
      :conditions => ['result_date between ? and ? and m_shop_id = ?',@from_ymd,@to_ymd,current_user.m_shop_id])

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
      sum_receive = 0
      sum_compute_stock = 0
      sum_decrease = 0
      last_sale_total = 0
      sum_decrease_total = 0
      tank_no = Array.new
      tank_volume = 0
      @tank_id = params[:tank_id].to_i unless params[:tank_id] == nil
      @oil_id = params[:oil_id].to_i unless params[:oil_id] == nil
      @from_ymd = params[:from_ymd]
      
      report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_tank_compute_report.tlf')


      report.layout.config.list(:list) do
         # フッターに合計をセット.
         events.on :page_footer_insert do |e|
           e.section.item(:sum_receive).value(sum_receive)
           e.section.item(:sum_compute_stock).value(sum_compute_stock)
           e.section.item(:sum_decrease).value(sum_decrease)
           e.section.item(:sum_sale_total).value(last_sale_total)
           e.section.item(:sum_decrease_total).value(sum_decrease_total)
           e.section.item(:sum_total_percentage).value(sprintf("%-8.3f",(sum_decrease_total * 1.000 / last_sale_total *1.000)*100) + '%')
         end
       end


      report.start_new_page do |page|
        page.item(:year).value(params[:from_ymd][0,4])
        page.item(:month).value(params[:from_ymd][4,2].to_i)
        unless params[:oil_id] == nil or params[:oil_id] == ""
          tanks = MTank.find(:all,:conditions => ['m_oil_id = ? and m_shop_id = ?',params[:oil_id],current_user.m_shop_id],:order => 'tank_no')
          tanks.each do |tank|
            tank_no << tank.tank_no
            tank_volume = tank_volume + tank.volume
            page.item(:tank_no).value(tank_no.join(","))
          end
          else
            tank = MTank.find(params[:tank_id])
            tank_no = tank.tank_no
            tank_volume = tank.volume
            page.item(:tank_no).value(tank_no)
          end
        page.item(:tank_volume).value(tank_volume)
        page.item(:oil_name).value(MOil.find(@oil_id).oil_name) unless params[:oil_id] == nil or params[:oil_id] == ""
        page.item(:oil_name).value(MOil.find(tank.m_oil_id).oil_name) unless params[:tank_id] == nil or params[:tank_id] == ""
        
        page.item(:user_name).value(current_user.user_name)
      end


      @d_results = DResult.find(:all,
      :conditions => ['result_date between ? and ? and m_shop_id = ?',@from_ymd,@to_ymd,current_user.m_shop_id])

      get_ymd = @from_ymd
      start_ymd = (@from_ymd[0,4].to_s + '/' + @from_ymd[4,2] + '/' + @from_ymd[6,2]).to_time
      start_day = start_ymd.end_of_month.day
      
    start_day.times do |i|
      result = DResult.find(:all,:conditions => ['result_date = ? and m_shop_id = ?',get_ymd,current_user.m_shop_id]).first
      get_ymd = (get_ymd.to_i + 1).to_s
      unless params[:oil_id] == nil or params[:oil_id] == "" # 油種の場合
        tank_compute = get_select_oil(result.id,@oil_id,current_user.m_shop_id) unless result == nil
        #p "***** tank_compute_oil = #{tank_compute}"
      end
      unless params[:tank_id] == nil or params[:tank_id] == "" #タンクの場合
       tank_compute = DTankComputeReport.find(:all,:conditions => ['d_result_id = ? and m_tank_id = ?',
         result.id,@tank_id]).first unless result == nil 
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
        row.item(:before_stock).value(tank_compute.before_stock)
        row.item(:receive).value(tank_compute.receive)
        sum_receive = sum_receive + tank_compute.receive
        row.item(:sale).value(tank_compute.sale)
        row.item(:compute_stock).value(tank_compute.compute_stock)
        sum_compute_stock = sum_compute_stock + tank_compute.compute_stock
        row.item(:after_stock).value(tank_compute.after_stock)
        row.item(:decrease).value(tank_compute.decrease)
        sum_decrease = sum_decrease + tank_compute.decrease
        row.item(:sale_total).value(tank_compute.sale_total)
        last_sale_total = tank_compute.sale_total
        row.item(:decrease_total).value(tank_compute.decrease_total)
        sum_decrease_total = sum_decrease_total + tank_compute.decrease_total
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
