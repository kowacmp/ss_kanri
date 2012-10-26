# -*- coding:utf-8 -*-
class DPriceCheckReportsController < ApplicationController
  include DPriceCheckReportsHelper
  
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
    
    if params[:shop_kbn] == nil
      @shop_kbn = 0
    else
      @shop_kbn = params[:shop_kbn]
    end
    
    if params[:price_kbn] == nil
      @price_kbn = 0
    else
      @price_kbn = params[:price_kbn]
    end
    
    ymd = @input_ymd.delete("/")[0,8]
    
    select_sql = "select a.*,b.* "
    select_sql << " from m_shops a " 
    select_sql << " left join ( select x.* from "
    select_sql << "            (select * from d_price_checks where research_day = '#{ymd}') x, "
    select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks "
    select_sql << "             group by m_shop_id,research_day) y "
    select_sql << "             where x.m_shop_id = y.m_shop_id and x.research_day = y.research_day and x.research_time = y.max_time "
    select_sql << "            ) b on a.id = b.m_shop_id "
    
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn} "
    
    @shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.price_sort")
    
  end

  def print
    @input_ymd = params[:input_ymd]
    
    if params[:shop_kbn] == nil
      @shop_kbn = 0
    else
      @shop_kbn = params[:shop_kbn]
    end
    
    if params[:price_kbn] == nil
      @price_kbn = 0
    else
      @price_kbn = params[:price_kbn]
    end
    
    ymd = @input_ymd.delete("/")[0,8]
    
    select_sql = "select a.*,b.* "
    select_sql << " from m_shops a " 
    select_sql << " left join ( select x.* from "
    select_sql << "            (select * from d_price_checks where research_day = '#{ymd}') x, "
    select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks "
    select_sql << "             group by m_shop_id,research_day) y "
    select_sql << "             where x.m_shop_id = y.m_shop_id and x.research_day = y.research_day and x.research_time = y.max_time "
    select_sql << "            ) b on a.id = b.m_shop_id "
    
    condition_sql = " where a.deleted_flg = 0 and a.shop_kbn = #{@shop_kbn} "
    
    shops = MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.price_sort")
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_price_check_report.tlf')

    taisyo_ymd = ymd[0,4].to_i.to_s + "年" + ymd[4,2].to_i.to_s + "月" + ymd[6,2].to_i.to_s + "日" 

     #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      #e.page.item(:page).value(e.page.no)
      #e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:taisyo_ymd).value(taisyo_ymd)
      #e.page.item(:title).value("価格調査表")
    end #evants.on
 
    report.start_new_page
    

    if @price_kbn.to_i == 0
    
      # 詳細作成
      shops.each do |shop|
        report.page.list(:list).add_row do |row|
          
          row.item(:shop_name).value(shop.shop_ryaku)
          
          #レギュラー
          if shop.dis1_1_rg.to_s != "" and shop.dis1_2_rg.to_s != "" and shop.dis1_1_rg.to_i != 888 and shop.dis1_2_rg.to_i != 888
            row.item(:dis1_rg).value(shop.dis1_1_rg.to_s + "/" + shop.dis1_2_rg.to_s)
          else
            row.item(:dis1_rg).value(price_888_print(shop.dis1_1_rg.to_s) + price_888_print(shop.dis1_2_rg.to_s))
          end
          #row.item(:dis1_1_rg).value(shop.dis1_1_rg)
          #row.item(:dis1_2_rg).value(shop.dis1_2_rg)
          row.item(:dis1_3_rg).value(price_888_print(shop.dis1_3_rg))
          
          if shop.dis1_3_rg.to_i != 888
            row.item(:dis1_4_rg).value(shop.dis1_4_rg)
          else
            row.item(:dis1_4_rg).value("")
          end
          
          if shop.dis1_3_rg.to_i != 0 and shop.dis1_3_rg.to_i != 888
            row.item(:dis1_3_rg_p).value(shop.dis1_3_rg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_rg_p).value("")
          end
          #ハイオク
          if shop.dis1_1_hg.to_s != "" and shop.dis1_2_hg.to_s != "" and shop.dis1_1_hg.to_i != 888 and shop.dis1_2_hg.to_i != 888
            row.item(:dis1_hg).value(shop.dis1_1_hg.to_s + "/" + shop.dis1_2_hg.to_s)
          else
            row.item(:dis1_hg).value(price_888_print(shop.dis1_1_hg.to_s) + price_888_print(shop.dis1_2_hg.to_s))
          end
          #row.item(:dis1_1_hg).value(shop.dis1_1_hg)
          #row.item(:dis1_2_hg).value(shop.dis1_2_hg)
          row.item(:dis1_3_hg).value(price_888_print(shop.dis1_3_hg))
          
          if shop.dis1_3_hg.to_i != 888
            row.item(:dis1_4_hg).value(shop.dis1_4_hg)
          else
            row.item(:dis1_4_hg).value("")
          end
          
          if shop.dis1_3_hg.to_i != 0 and shop.dis1_3_hg.to_i != 888
            row.item(:dis1_3_hg_p).value(shop.dis1_3_hg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_hg_p).value("")
          end
          #軽油
          if shop.dis1_1_kg.to_s != "" and shop.dis1_2_kg.to_s != "" and shop.dis1_1_kg.to_i != 888 and shop.dis1_2_kg.to_i != 888
            row.item(:dis1_kg).value(shop.dis1_1_kg.to_s + "/" + shop.dis1_2_kg.to_s)
          else
            row.item(:dis1_kg).value(price_888_print(shop.dis1_1_kg.to_s) + price_888_print(shop.dis1_2_kg.to_s))
          end
          #row.item(:dis1_1_kg).value(shop.dis1_1_kg)
          #row.item(:dis1_2_kg).value(shop.dis1_2_kg)
          row.item(:dis1_3_kg).value(price_888_print(shop.dis1_3_kg))
          
          if shop.dis1_3_kg.to_i != 888
            row.item(:dis1_4_kg).value(shop.dis1_4_kg)
          else
            row.item(:dis1_4_kg).value("")
          end
          
          if shop.dis1_3_kg.to_i != 0 and shop.dis1_3_kg.to_i != 888
            row.item(:dis1_3_kg_p).value(shop.dis1_3_kg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_kg_p).value("")
          end
          #灯油
          #if shop.dis1_1_tg and shop.dis1_2_tg and shop.dis1_1_tg.to_i != 888 and shop.dis1_2_tg.to_i != 888
          #  row.item(:dis1_tg).value(shop.dis1_1_tg.to_s + "/" + shop.dis1_2_tg.to_s)
          #else
          #  row.item(:dis1_tg).value(price_888_print(shop.dis1_1_tg.to_s) + price_888_print(shop.dis1_2_tg.to_s))
          #end
          row.item(:dis1_tg).value(price_888_print(shop.dis1_2_tg.to_s))
          #row.item(:dis1_1_tg).value(shop.dis1_1_tg)
          #row.item(:dis1_2_tg).value(shop.dis1_2_tg)
          row.item(:dis1_3_tg).value(price_888_print(shop.dis1_3_tg))
          
          if shop.dis1_3_tg.to_i != 888
            row.item(:dis1_4_tg).value(shop.dis1_4_tg)
          else
            row.item(:dis1_4_tg).value("")
          end
          
          if shop.dis1_3_tg.to_i != 0 and shop.dis1_3_tg.to_i != 888
            row.item(:dis1_3_tg_p).value(shop.dis1_3_tg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_tg_p).value("")
          end
          if shop.dis1_3_tg.to_i != 0 and shop.dis1_3_tg.to_i != 888
            row.item(:dis1_3_tg_l).value((shop.dis1_3_tg.to_f/18).round(1))
          else
            row.item(:dis1_3_tg_l).value("")
          end
          
          row.item(:game).value(shop.game)
          
          #row.item(:minus_name1).value(shop.minus_name1)
          #row.item(:minus_name2).value(shop.minus_name2)
          #row.item(:minus_name3).value(shop.minus_name3)
          if shop.minus_gak1.to_i < 0
            row.item(:minus_name1).value(shop.minus_name1.to_s + "△" + (shop.minus_gak1.to_i * (-1)).to_s)
          else
            row.item(:minus_name1).value(shop.minus_name1.to_s + " " + shop.minus_gak1.to_s)
          end
          if shop.minus_gak2.to_i < 0
            row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
          else
            row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
          end
          if shop.minus_gak3.to_i < 0
            row.item(:minus_name3).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
          else
            row.item(:minus_name3).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
          end
          
        end #add_row
      end # shops.each
      pdf_title = "価格表(通常時)_#{ymd}.pdf"
    else
    
      # 詳細作成
      shops.each do |shop|
        report.page.list(:list).add_row do |row|
          
          row.item(:shop_name).value(shop.shop_ryaku)
          
          #レギュラー
          if shop.dis2_1_rg.to_s != "" and shop.dis2_2_rg.to_s != "" and shop.dis2_1_rg.to_i != 888 and shop.dis2_2_rg.to_i != 888
            row.item(:dis1_rg).value(shop.dis2_1_rg.to_s + "/" + shop.dis2_2_rg.to_s)
          else
            row.item(:dis1_rg).value(price_888_print(shop.dis2_1_rg.to_s) + price_888_print(shop.dis2_2_rg.to_s))
          end
          #row.item(:dis2_1_rg).value(shop.dis2_1_rg)
          #row.item(:dis2_2_rg).value(shop.dis2_2_rg)
          row.item(:dis1_3_rg).value(price_888_print(shop.dis2_3_rg))
          
          if shop.dis2_3_rg.to_i != 888
            row.item(:dis1_4_rg).value(get_zeinuki_print(shop.dis2_3_rg))
          else
            row.item(:dis1_4_rg).value("")
          end
          
          if shop.dis2_3_rg.to_i != 0 and shop.dis2_3_rg.to_i != 888
            row.item(:dis1_3_rg_p).value(shop.dis2_3_rg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_rg_p).value("")
          end
          #ハイオク
          if shop.dis2_1_hg.to_s != "" and shop.dis2_2_hg.to_s != "" and shop.dis2_1_hg.to_i != 888 and shop.dis2_2_hg.to_i != 888
            row.item(:dis1_hg).value(shop.dis2_1_hg.to_s + "/" + shop.dis2_2_hg.to_s)
          else
            row.item(:dis1_hg).value(price_888_print(shop.dis2_1_hg.to_s) + price_888_print(shop.dis2_2_hg.to_s))
          end
          #row.item(:dis2_1_hg).value(shop.dis2_1_hg)
          #row.item(:dis2_2_hg).value(shop.dis2_2_hg)
          row.item(:dis1_3_hg).value(price_888_print(shop.dis2_3_hg))
          
          if shop.dis2_3_hg.to_i != 888
            row.item(:dis1_4_hg).value(get_zeinuki_print(shop.dis2_3_hg))
          else
            row.item(:dis1_4_hg).value("")
          end
          
          if shop.dis2_3_hg.to_i != 0 and shop.dis2_3_hg.to_i != 888
            row.item(:dis1_3_hg_p).value(shop.dis2_3_hg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_hg_p).value("")
          end
          #軽油
          if shop.dis2_1_kg.to_s != "" and shop.dis2_2_kg.to_s != "" and shop.dis2_1_kg.to_i != 888 and shop.dis2_2_kg.to_i != 888
            row.item(:dis1_kg).value(shop.dis2_1_kg.to_s + "/" + shop.dis2_2_kg.to_s)
          else
            row.item(:dis1_kg).value(price_888_print(shop.dis2_1_kg.to_s) + price_888_print(shop.dis2_2_kg.to_s))
          end
          #row.item(:dis2_1_kg).value(shop.dis2_1_kg)
          #row.item(:dis2_2_kg).value(shop.dis2_2_kg)
          row.item(:dis1_3_kg).value(price_888_print(shop.dis2_3_kg))
          
          if shop.dis2_3_kg.to_i != 888
            row.item(:dis1_4_kg).value(get_zeinuki_kg_print(shop.dis2_3_kg))
          else
            row.item(:dis1_4_kg).value("")
          end
          
          if shop.dis2_3_kg.to_i != 0 and shop.dis2_3_kg.to_i != 888
            row.item(:dis1_3_kg_p).value(shop.dis2_3_kg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_kg_p).value("")
          end
          #灯油
          #if shop.dis2_1_tg and shop.dis2_2_tg and shop.dis2_1_tg.to_i != 888 and shop.dis2_2_tg.to_i != 888
          #  row.item(:dis1_tg).value(shop.dis2_1_tg.to_s + "/" + shop.dis2_2_tg.to_s)
          #else
          #  row.item(:dis1_tg).value(price_888_print(shop.dis2_1_tg.to_s) + price_888_print(shop.dis2_2_tg.to_s))
          #end
          row.item(:dis1_tg).value(price_888_print(shop.dis2_2_tg.to_s))
          #row.item(:dis2_1_tg).value(shop.dis2_1_tg)
          #row.item(:dis2_2_tg).value(shop.dis2_2_tg)
          row.item(:dis1_3_tg).value(price_888_print(shop.dis2_3_tg))
          
          if shop.dis2_3_tg.to_i != 888
            row.item(:dis1_4_tg).value(get_zeinuki_print(shop.dis2_3_tg))
          else
            row.item(:dis1_4_tg).value("")
          end
          
          if shop.dis2_3_tg.to_i != 0 and shop.dis2_3_tg.to_i != 888
            row.item(:dis1_3_tg_p).value(shop.dis2_3_tg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_tg_p).value("")
          end
          if shop.dis2_3_tg.to_i != 0 and shop.dis2_3_tg.to_i != 888
            row.item(:dis1_3_tg_l).value((shop.dis2_3_tg.to_f/18).round(1))
          else
            row.item(:dis1_3_tg_l).value("")
          end
          
          row.item(:game).value(shop.game)
          
          #row.item(:minus_name1).value(shop.minus_name1)
          #row.item(:minus_name2).value(shop.minus_name2)
          #row.item(:minus_name3).value(shop.minus_name3)
          if shop.minus_gak1.to_i < 0
            row.item(:minus_name1).value(shop.minus_name1.to_s + "△" + (shop.minus_gak1.to_i * (-1)).to_s)
          else
            row.item(:minus_name1).value(shop.minus_name1.to_s + " " + shop.minus_gak1.to_s)
          end
          if shop.minus_gak2.to_i < 0
            row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
          else
            row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
          end
          if shop.minus_gak3.to_i < 0
            row.item(:minus_name3).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
          else
            row.item(:minus_name3).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
          end
          
        end #add_row
      end # shops.each
      pdf_title = "価格表(特売時)_#{ymd}.pdf"
    end
    
    
    
    #ファイル名セット     
    #pdf_title = "価格表.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  end

end
