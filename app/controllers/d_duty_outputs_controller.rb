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
        ,users.taisyoku_date            --退職日
        ,users.return_date              --返却日
        ,users.pay_kbn                  --支払区分
        ,m_info_costs.time_price1
        ,m_info_costs.time_price2
        ,m_info_costs.time_price3
        ,m_info_costs.time_price4
        ,m_info_costs.time_price5
        ,m_info_costs.time_price6
        ,m_info_costs.day_price1
        ,m_info_costs.day_price2
        ,count(d_duties.id) as day                        --出勤日数
        ,sum(d_duties.day_work_time) as day_work_time     --日勤時間
        ,sum(d_duties.day_over_time) as day_over_time     --残業時間
        ,sum(d_duties.night_work_time) as night_work_time --深夜時間
        ,sum(d_duties.night_over_time) as night_over_time --深夜残業時間
        ,sum(d_duties.day_work_money) as day_work_money     --日勤金額
        ,sum(d_duties.day_over_money) as day_over_money     --残業金額
        ,sum(d_duties.night_work_money) as night_work_money --深夜金額
        ,sum(d_duties.night_over_money) as night_over_money --深夜残業金額
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
          and users.user_class = 1
      group by 
         d_duties.user_id               --ユーザID
        ,users.account                  --社員コード
        ,users.user_name                --ユーザ名
        ,users.taisyoku_date
        ,users.return_date              --返却日
        ,users.pay_kbn                  --支払区分
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
    
    # 印刷データを取得( _form.html.erbよりパラメータ送信 )
    # hash_keyはレポート定義のアイテム名を合わせています
    header  = params[:header]
    footer  = params[:footer]
    details = Array.new()
    list_no = 1
    until params["list#{ list_no }"].blank?
      details.push params["list#{ list_no }"]
      list_no += 1
    end
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_salary_list.tlf')
    
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      
      e.page.values(header)

    end #evants.on
    
    report.layout.config.list(:list) do
      
      # フッターに合計をセット.
      events.on :footer_insert do |e|
        
        e.section.values(footer)
        
      end #events.on
    end #list
    
    report.start_new_page
    
    # 詳細作成
    for detail in details
      
      report.page.list(:list).add_row do |row|
          
          row.values(detail)
          
      end #add_row
      
    end # for detail in details
    
    #ファイル名セット     
    pdf_title = "給与内訳リスト_#{header[:title1]}_#{header[:title2]}.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
                               
  end #def print

end
