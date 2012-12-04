# -*- coding:utf-8 -*-
class DDutyOutputsController < ApplicationController

  def index
    
    # 年月表示用データを作成
    @years = Array.new()
    min_year = DDuty.minimum(:duty_nengetu).to_s[0..3].to_i
    max_year = DDuty.maximum(:duty_nengetu).to_s[0..3].to_i
    for year in min_year..max_year
      @years.push [year, year]
    end
    @months = Array.new()
    for month in 1..12
      @months.push [month, month]
    end
    
  end

  def show
    
    # パラメータを受けとる
    @year      = params[:d_duty_output][:year].to_i
    @month     = params[:d_duty_output][:month].to_i
    @m_shop_id = params[:d_duty_output][:m_shop_id].to_i
    
    # 対象店舗の人件費項目名称マスタ取得
    @m_cost_name = MCostName.find(:first, :conditions => ["m_shop_id=?", @m_shop_id])
    
    # 勤怠データ読み込み
    sql = "
      select 
         d_duties.user_id               --ユーザID
        ,users.account                  --社員コード
        ,users.user_name                --ユーザ名
        ,m_info_costs.general_price
        ,m_info_costs.general_overtime
        ,m_info_costs.night_price
        ,m_info_costs.night_overtime
        ,m_info_costs.time_price1
        ,m_info_costs.time_price2
        ,m_info_costs.time_price3
        ,m_info_costs.time_price4
        ,m_info_costs.time_price5
        ,m_info_costs.time_price6
        ,m_info_costs.day_price1
        ,m_info_costs.day_price2
        ,count(d_duties.id) as day                        --出勤日数
        ,sum(d_duties.day_work_time) as day_work_time     --日勤
        ,sum(d_duties.day_over_time) as day_over_time     --残業
        ,sum(d_duties.night_work_time) as night_work_time --深夜
        ,sum(d_duties.night_over_time) as night_over_time --深夜残業
        ,sum(d_duties.time1_money) as time1_money         --時間1金額
        ,sum(d_duties.time2_money) as time2_money         --時間2金額
        ,sum(d_duties.time3_money) as time3_money         --時間3金額
        ,sum(d_duties.time4_money) as time4_money         --時間4金額
        ,sum(d_duties.time5_money) as time5_money         --時間5金額
        ,sum(d_duties.time6_money) as time6_money         --時間6金額
        ,sum(d_duties.day1_money)  as day1_money          --日数1金額
        ,sum(d_duties.day2_money)  as day2_money          --日数2金額
        ,sum(d_duties.get_money1)  as get_money1          --手当1
        ,sum(d_duties.get_money2)  as get_money2          --手当2
        ,sum(d_duties.get_money3)  as get_money3          --手当3
        ,sum(d_duties.get_money4)  as get_money4          --手当4
      from 
                 (d_duties inner join users on d_duties.user_id = users.id)
       left join  m_info_costs on d_duties.user_id = m_info_costs.user_id
      where
             d_duties.duty_nengetu = :duty_nengetu
         and d_duties.m_shop_id    = :m_shop_id
         and users.user_class not in (0, 2)
      group by 
         d_duties.user_id               --ユーザID
        ,users.account                  --社員コード
        ,users.user_name                --ユーザ名
        ,m_info_costs.general_price
        ,m_info_costs.general_overtime
        ,m_info_costs.night_price
        ,m_info_costs.night_overtime
        ,m_info_costs.time_price1
        ,m_info_costs.time_price2
        ,m_info_costs.time_price3
        ,m_info_costs.time_price4
        ,m_info_costs.time_price5
        ,m_info_costs.time_price6
        ,m_info_costs.day_price1
        ,m_info_costs.day_price2
      order by
        users.account
    "
    
    @d_duties = DDuty.find_by_sql([sql, 
                                    {:duty_nengetu => @year.to_s + sprintf("%02d", @month.to_i), 
                                     :m_shop_id => @m_shop_id}])
    
   
  end

  def print
    
    show()
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_salary_list.tlf')

    #ページ番号、タイトル、作成日セット  
    title1 = "#{@year}年#{@month}月"
    title2 = "#{MShop.find(@m_shop_id).shop_ryaku}"

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
     report.start_new_page do |page|
        page.item(:hour_name1).value(@m_cost_name.hour_name1)
        page.item(:hour_name2).value(@m_cost_name.hour_name2)
        page.item(:hour_name3).value(@m_cost_name.hour_name3)
        page.item(:hour_name4).value(@m_cost_name.hour_name4)
        page.item(:hour_name5).value(@m_cost_name.hour_name5)
        page.item(:hour_name6).value(@m_cost_name.hour_name6)
        page.item(:day_name1).value(@m_cost_name.day_name1)
        page.item(:day_name2).value(@m_cost_name.day_name2)
        page.item(:name1).value(@m_cost_name.input_name1)
        page.item(:name2).value(@m_cost_name.input_name2)
        page.item(:name3).value(@m_cost_name.input_name3)
        page.item(:name4).value(@m_cost_name.input_name4)
    end
    # 詳細作成
    @d_duties.each do |d_duty|
    # Set header datas.
      report.page.list(:list).add_row do |row|
          #社員ｺｰﾄﾞ
          row.item(:u_code).value(shop.shop_ryaku) 
          #氏名
          row.item(:u_name).value(d_duty.user_name) 
          #出勤日数
          row.item(:d_cnt).value(d_duty.day) 
          #時間1
          row.item(:d_time1).value(d_duty.day_work_time) 
          #単価1
          row.item(:g_price1).value(d_duty.general_price) 
          #金額1
          row.item(:g_money1).value(get_general_money(d_duty)) 
          #時間2
          row.item(:d_time2).value(d_duty.day_over_time) 
          #単価2
          row.item(:g_price2).value(d_duty.general_overtime) 
          #金額2
          row.item(:g_money2).value(get_general_overtime_money(d_duty))
          #時間3
          row.item(:d_time3).value(d_duty.night_work_time) 
          #単価3
          row.item(:g_price3).value(d_duty.night_price) 
          #金額3
          row.item(:g_money3).value(get_night_money(d_duty)) 
          #時間4
          row.item(:d_time4).value(d_duty.night_over_time) 
          #単価4
          row.item(:g_price4).value(d_duty.night_overtime) 
          #金額4
          row.item(:g_money4).value(get_night_overtime_money(d_duty)) 
          #時間手当1
          row.item(:t_price1).value(d_duty.time_price1) 
          #時間手当1金額
          row.item(:t_money1).value(d_duty.time1_money) 
          #時間手当2
          row.item(:t_price2).value(d_duty.time_price2) 
          #時間手当2金額
          row.item(:t_money2).value(d_duty.time2_money) 
          #時間手当3
          row.item(:t_price3).value(d_duty.time_price3) 
          #時間手当3金額
          row.item(:t_money3).value(d_duty.time3_money) 
          #時間手当4
          row.item(:t_price4).value(d_duty.time_price4) 
          #時間手当4金額
          row.item(:t_money4).value(d_duty.time4_money) 
          #時間手当5
          row.item(:t_price5).value(d_duty.time_price5) 
          #時間手当5金額
          row.item(:t_money5).value(d_duty.time5_money) 
          #時間手当6
          row.item(:t_price6).value(d_duty.time_price6) 
          #時間手当6金額
          row.item(:t_money6).value(d_duty.time6_money) 
          #日数手当1
          row.item(:d_price1).value(d_duty.day_price1) 
          #日数手当1金額
          row.item(:d_money1).value(d_duty.day1_money) 
          #日数手当2
          row.item(:d_price2).value(d_duty.day_price2) 
          #時間手当2金額
          row.item(:d_money2).value(d_duty.day2_money) 
          #月間手当金額1
          row.item(:m_money1).value(d_duty.get_money1) 
          #月間手当金額2
          row.item(:m_money2).value(d_duty.get_money2) 
          #月間手当金額3
          row.item(:m_money3).value(d_duty.get_money3) 
          #月間手当金額4
          row.item(:m_money4).value(d_duty.get_money4) 
          #支払金額
          row.item(:sum_money).value(get_shiharai_gak(d_duty)) 
      end #add_row
    end # shops.each
    
    report.layout.config.list(:list) do
    # フッターに合計をセット.
      events.on :footer_insert do |e|
        #時間1
        e.section.item(:d_time1_sum).value(get_day_work_times(@d_duties))
        #金額1
        e.section.item(:g_money1_sum).value(get_general_moneys(@d_duties))
        #時間2
        e.section.item(:d_time2_sum).value(get_day_over_times(@d_duties))
        #金額2
        e.section.item(:g_money2_sum).value(get_general_overtime_moneys(@d_duties))
        #時間3
        e.section.item(:d_time3_sum).value(get_night_work_times(@d_duties))
        #金額3
        e.section.item(:g_money3_sum).value(get_night_moneys(@d_duties)) 
        #時間4
        e.section.item(:t_money4_sum).value(gget_night_overtimes(@d_duties))
        #金額4
        e.section.item(:g_money4_sum).value(get_night_overtime_moneys(@d_duties)) 
        #時間手当1金額
        e.section.item(:t_money1_sum).value(get_time1_moneys(@d_duties)) 
        #時間手当2金額
        e.section.item(:t_money2_sum).value(get_time2_moneys(@d_duties)) 
        #時間手当3金額
        e.section.item(:t_money3_sum).value(get_time3_moneys(@d_duties)) 
        #時間手当4金額
        e.section.item(:t_money4_sum).value(get_time4_moneys(@d_duties)) 
        #時間手当5金額
        e.section.item(:t_money5_sum).value(get_time5_moneys(@d_duties)) 
        #時間手当6金額
        e.section.item(:t_money6_sum).value(get_time6_moneys(@d_duties)) 
        #日数手当1金額
        e.section.item(:d_money1_sum).value(get_day1_money(@d_duties)) 
        #日数手当2金額
        e.section.item(:d_money2_sum).value(get_day2_money(@d_duties)) 
        #月間手当金額1
        e.section.item(:m_money1_sum).value(get_moneys1(@d_duties)) 
        #月間手当金額2
        e.section.item(:m_money2_sum).value(get_moneys2(@d_duties)) 
        #月間手当金額3
        e.section.item(:m_money3_sum).value(get_moneys3(@d_duties)) 
        #月間手当金額4
        e.section.item(:m_money4_sum).value(get_moneys4(@d_duties)) 
        #支払金額
        e.section.item(:all_money).value(get_shiharai_gaks(@d_duties)) 
     end #events.on
    end #list
    #ファイル名セット     
    pdf_title = "給与内訳リスト_#{@year}年#{@month}月_title2.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
                               
  end #def print

end
