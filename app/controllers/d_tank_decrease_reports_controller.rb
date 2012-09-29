# -*- coding:utf-8 -*-

include DTankDecreaseReportsHelper

class DTankDecreaseReportsController < ApplicationController
  def index
    search 
  end

  def search
    @rbtn = params[:rbtn]
    if params[:input_ymd] == nil
      # UPDATE 2012.09.29 日付の規定値を前日にする
      #@input_ymd = Time.now.strftime("%Y/%m/%d")
      @input_ymd = (Time.now - 60*60*24).strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    @input_ymd_s = @input_ymd.delete("/")
    
    @groups = MShopGroup.find(:all,[:conditions => 'deleted_flg = 0',:order => 'group_cd'])
    
  end
  
  def print
    oil1_sum = 0
    oil2_sum = 0
    oil3_sum = 0
    oil4_sum = 0
    @rbtn = params[:rbtn].to_i
    @input_ymd_s = params[:input_ymd_s]
    old_group_name = ''
    #list_cnt = 0
    datas = MShop.find_by_sql(['select b.m_shop_group_id,a.group_name,b.shop_cd,shop_name,shop_ryaku ,d.*
                                from m_shop_groups a 
                                left join m_shops b
                                  on a.id = b.m_shop_group_id
                                  and b.shop_kbn <> 9
                                left join d_results c
                                  on c.result_date = ?
                                  and b.id = c.m_shop_id
                                left join d_tank_decrease_reports d
                                  on c.id = d.d_result_id
                                order by b.m_shop_group_id,b.shop_cd',params[:input_ymd_s]])

report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_tank_decrease_report.tlf')

report.layout.config.list(:list) do
  # フッターに合計をセット.
  events.on :footer_insert do |e|
    e.section.item(:oil1_sum).value(oil1_sum)
    e.section.item(:oil2_sum).value(oil2_sum)
    e.section.item(:oil3_sum).value(oil3_sum)
    e.section.item(:oil4_sum).value(oil4_sum)
  end
end

    #ページ番号、タイトル、作成日セット  
    report.events.on :page_create do |e|
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      print_ymd = params[:input_ymd_s][0,4] + '年' + params[:input_ymd_s][4,2] + '月' + params[:input_ymd_s][6,2] + '日'
      if @rbtn == 1
        e.page.item(:title).value("#{print_ymd} SS別地下タンク過不足表（日計）")
      elsif @rbtn == 2
        e.page.item(:title).value("#{print_ymd}集計 SS別地下タンク過不足表（累計）")
      else
        e.page.item(:title).value("")
      end
    end #evants.on
    
    report.start_new_page


    # 詳細作成
    datas.each do |data|
    # Set header datas.
      report.page.list(:list).add_row do |row|
        unless old_group_name == data.group_name
          row.item(:group_name).value(data.group_name)
        else
          row.item(:group_name).value("") 
        end
        old_group_name = data.group_name
        row.item(:shop_name).value(data.shop_ryaku) 
        if @rbtn == 1
          row.item(:oil1).value(data.oil1_num)
          row.item(:oil2).value(data.oil2_num)
          row.item(:oil3).value(data.oil3_num)
          row.item(:oil4).value(data.oil4_num)
          row.item(:percent).value(data.oil_percent)
          oil1_sum = oil1_sum + data.oil1_num.to_i
          oil2_sum = oil2_sum + data.oil2_num.to_i
          oil3_sum = oil3_sum + data.oil3_num.to_i
          oil4_sum = oil4_sum + data.oil4_num.to_i
        elsif @rbtn == 2
          row.item(:oil1).value(data.oil1_num_total)
          row.item(:oil2).value(data.oil2_num_total)
          row.item(:oil3).value(data.oil3_num_total)
          row.item(:oil4).value(data.oil4_num_total)
          row.item(:percent).value(data.oil_percent_total)
          oil1_sum = oil1_sum + data.oil1_num_total.to_i
          oil2_sum = oil2_sum + data.oil2_num_total.to_i
          oil3_sum = oil3_sum + data.oil3_num_total.to_i
          oil4_sum = oil4_sum + data.oil4_num_total.to_i
        else
          row.item(:oil1).value(0)
          row.item(:oil2).value(0)
          row.item(:oil3).value(0)
          row.item(:oil4).value(0)
          row.item(:percent).value(0)
          oil1_sum = 0
          oil2_sum = 0
          oil3_sum = 0
          oil4_sum = 0
        end
      end #add_row
    end # datas.each

    #タイトルセット
    if @rbtn == 1
      pdf_title = "SS別地下タンク過不足表（日計）_#{@input_ymd_s}.pdf"
    else
      pdf_title = "SS別地下タンク過不足表（累計）_#{@input_ymd_s}.pdf"
    end
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  end

  private

end
