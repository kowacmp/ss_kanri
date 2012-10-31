# -*- coding:utf-8 -*-
class DPriceCheckReportsController < ApplicationController
  include DPriceCheckReportsHelper
  
  def index
    search
  end

  def search
    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
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
    
    select_sql = "select a.*,b.*, "
    select_sql << " c.code_name1 as dis1_2_code_name,d.code_name1 as dis2_2_code_name " 
    select_sql << " from m_shops a " 
    select_sql << " left join ( select x.* from "
    select_sql << "            (select * from d_price_checks) x, "
    
    select_sql << "            (select a.m_shop_id,b.research_day,b.max_time from "
    select_sql << "            (select m_shop_id,max(research_day) as max_day from d_price_checks where research_day <= '#{ymd}' group by m_shop_id) a, "
    select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks group by m_shop_id,research_day) b "
    select_sql << "            where a.m_shop_id = b.m_shop_id and a.max_day = b.research_day) y  "
    #select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks "
    #select_sql << "             group by m_shop_id,research_day) y "
    select_sql << "             where x.m_shop_id = y.m_shop_id and x.research_day = y.research_day and x.research_time = y.max_time "
    select_sql << "            ) b on a.id = b.m_shop_id "
    select_sql << " left join (select * from m_codes where kbn='oil_panel') c on b.dis1_2_code = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='oil_panel') d on b.dis2_2_code = cast(d.code as integer) "
    
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
    
    select_sql = "select a.*,b.*, "
    select_sql << " c.code_name1 as dis1_2_code_name,d.code_name1 as dis2_2_code_name "
    select_sql << " from m_shops a " 
    select_sql << " left join ( select x.* from "
    select_sql << "            (select * from d_price_checks) x, "
    
    select_sql << "            (select a.m_shop_id,b.research_day,b.max_time from "
    select_sql << "            (select m_shop_id,max(research_day) as max_day from d_price_checks where research_day <= '#{ymd}' group by m_shop_id) a, "
    select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks group by m_shop_id,research_day) b "
    select_sql << "            where a.m_shop_id = b.m_shop_id and a.max_day = b.research_day) y  "
    #select_sql << "            (select m_shop_id,research_day,max(research_time) as max_time from d_price_checks "
    #select_sql << "             group by m_shop_id,research_day) y "
    select_sql << "             where x.m_shop_id = y.m_shop_id and x.research_day = y.research_day and x.research_time = y.max_time "
    select_sql << "            ) b on a.id = b.m_shop_id "
    select_sql << " left join (select * from m_codes where kbn='oil_panel') c on b.dis1_2_code = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='oil_panel') d on b.dis2_2_code = cast(d.code as integer) "
    
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
    
    record_idx = 0

    if @price_kbn.to_i == 0
      #通常時
      # 詳細作成
      shops.each do |shop|
        report.page.list(:list).add_row do |row|
          record_idx = record_idx + 1
          #偶数の場合色をつける
          if record_idx % 2 == 0
            row.item(:record_back).style(:fill, '#dbeef3') # 塗り
          end
          
          #店舗
          row.item(:shop_name).value(shop.shop_ryaku)
          
          #ハイオク
          #看板
          row.item(:dis1_1_hg).value(shop.dis1_1_hg)
          row.item(:dis1_2_hg).value(shop.dis1_2_hg)
          if shop.dis1_1_hg.to_s != "" or shop.dis1_2_hg.to_s != ""
            row.item(:dis1_hg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_hg).value(shop.dis1_3_hg)
          #現金(税込)
          row.item(:dis1_4_hg).value(shop.dis1_4_hg)
          #会員
          if shop.dis1_3_hg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_hg_k).value(shop.dis1_3_hg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_hg_k).value("")
          end
          #プリカ
          if shop.dis1_3_hg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_hg_p).value(shop.dis1_3_hg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_hg_p).value("")
          end
          
          #レギュラー
          #看板
          row.item(:dis1_1_rg).value(shop.dis1_1_rg)
          row.item(:dis1_2_rg).value(shop.dis1_2_rg)
          if shop.dis1_1_rg.to_s != "" or shop.dis1_2_rg.to_s != ""
            row.item(:dis1_rg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_rg).value(shop.dis1_3_rg)
          #現金(税込)
          row.item(:dis1_4_rg).value(shop.dis1_4_rg)
          #会員
          if shop.dis1_3_rg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_rg_k).value(shop.dis1_3_rg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_rg_k).value("")
          end
          #プリカ
          if shop.dis1_3_rg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_rg_p).value(shop.dis1_3_rg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_rg_p).value("")
          end
          
          #軽油
          #看板
          row.item(:dis1_1_kg).value(shop.dis1_1_kg)
          row.item(:dis1_2_kg).value(shop.dis1_2_kg)
          if shop.dis1_1_kg.to_s != "" or shop.dis1_2_kg.to_s != ""
            row.item(:dis1_kg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_kg).value(shop.dis1_3_kg)
          #現金(税込)
          row.item(:dis1_4_kg).value(shop.dis1_4_kg)
          #会員
          if shop.dis1_3_kg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_kg_k).value(shop.dis1_3_kg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_kg_k).value("")
          end
          #プリカ
          if shop.dis1_3_kg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_kg_p).value(shop.dis1_3_kg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_kg_p).value("")
          end
          
          #灯油
          #看板
          row.item(:dis1_tg).value(shop.dis1_2_tg)
          #現金(税込)18L
          row.item(:dis1_3_tg).value(shop.dis1_3_tg)
          #現金(税抜)
          row.item(:dis1_4_tg).value(shop.dis1_4_tg)
          #会員
          if shop.dis1_3_tg.to_i != 0 and shop.minus_gak3.to_i != 0
            #row.item(:dis1_3_tg_p).value(shop.dis1_3_tg.to_i + shop.minus_gak3.to_i)
            row.item(:dis1_3_tg_k).value(shop.dis1_3_tg.to_i + (shop.minus_gak3.to_i * 18))
          else
            row.item(:dis1_3_tg_k).value("")
          end
          #プリカ
          if shop.dis1_3_tg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_tg_p).value(shop.dis1_3_tg.to_i + (shop.minus_gak2.to_i * 18))
          else
            row.item(:dis1_3_tg_p).value("")
          end
          #現金(税込)1L
          if shop.dis1_3_tg.to_i != 0
            row.item(:dis1_3_tg_l).value((shop.dis1_3_tg.to_f/18).round(1))
          else
            row.item(:dis1_3_tg_l).value("")
          end
          
          #当り確率
          row.item(:game).value(shop.game)
          
          #特売
          if shop.minus_gak1.to_i < 0
            row.item(:minus_name1).value(shop.minus_name1.to_s + "△" + (shop.minus_gak1.to_i * (-1)).to_s)
          else
            row.item(:minus_name1).value(shop.minus_name1.to_s + " " + shop.minus_gak1.to_s)
          end
          
          #プリカ/会員
          if @shop_kbn.to_i == 0
            #洗車
            if shop.minus_gak2.to_i != 0 
              if shop.minus_gak2.to_i < 0
                row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
              end
            elsif shop.minus_gak3.to_i != 0 
              if shop.minus_gak3.to_i < 0
                row.item(:minus_name2).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
              end
            else
              row.item(:minus_name2).value("")
            end
          else
            #油外
            if shop.minus_gak3.to_i != 0 
              if shop.minus_gak3.to_i < 0
                row.item(:minus_name2).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
              end
            elsif shop.minus_gak2.to_i != 0 
              if shop.minus_gak2.to_i < 0
                row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
              end
            else
              row.item(:minus_name2).value("")
            end
          end
          
          #備考
          row.item(:minus_name4).value(shop.minus_name4)
          #下看
          row.item(:dis1_2_code_name).value(shop.dis1_2_code_name)
          
        end #add_row
      end # shops.each
      pdf_title = "SS価格表(通常時)_#{ymd}.pdf"
    else
      #特売時
      # 詳細作成
      shops.each do |shop|
        report.page.list(:list).add_row do |row|
          record_idx = record_idx + 1
          #偶数の場合色をつける
          if record_idx % 2 == 0
            row.item(:record_back).style(:fill, '#dbeef3') # 塗り
          end
          
          #店舗
          row.item(:shop_name).value(shop.shop_ryaku)
          
          #ハイオク
          #看板
          row.item(:dis1_1_hg).value(shop.dis2_1_hg)
          row.item(:dis1_2_hg).value(shop.dis2_2_hg)
          if shop.dis2_1_hg.to_s != "" or shop.dis2_2_hg.to_s != ""
            row.item(:dis1_hg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_hg).value(shop.dis2_3_hg)
          #現金(税込)
          row.item(:dis1_4_hg).value(get_zeinuki_print(shop.dis2_3_hg))
          #会員
          if shop.dis2_3_hg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_hg_k).value(shop.dis2_3_hg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_hg_k).value("")
          end
          #プリカ
          if shop.dis2_3_hg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_hg_p).value(shop.dis2_3_hg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_hg_p).value("")
          end
          
          #レギュラー
          #看板
          row.item(:dis1_1_rg).value(shop.dis2_1_rg)
          row.item(:dis1_2_rg).value(shop.dis2_2_rg)
          if shop.dis2_1_rg.to_s != "" or shop.dis2_2_rg.to_s != ""
            row.item(:dis1_rg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_rg).value(shop.dis2_3_rg)
          #現金(税込)
          row.item(:dis1_4_rg).value(get_zeinuki_print(shop.dis2_3_rg))
          #会員
          if shop.dis2_3_rg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_rg_k).value(shop.dis2_3_rg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_rg_k).value("")
          end
          #プリカ
          if shop.dis2_3_rg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_rg_p).value(shop.dis2_3_rg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_rg_p).value("")
          end
          
          #軽油
          #看板
          row.item(:dis1_1_kg).value(shop.dis2_1_kg)
          row.item(:dis1_2_kg).value(shop.dis2_2_kg)
          if shop.dis2_1_kg.to_s != "" or shop.dis2_2_kg.to_s != ""
            row.item(:dis1_kg).value("/")
          end
          #現金(税抜)
          row.item(:dis1_3_kg).value(shop.dis2_3_kg)
          #現金(税込)
          row.item(:dis1_4_kg).value(get_zeinuki_kg_print(shop.dis2_3_kg))
          #会員
          if shop.dis2_3_kg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_kg_k).value(shop.dis2_3_kg.to_i + shop.minus_gak3.to_i)
          else
            row.item(:dis1_3_kg_k).value("")
          end
          #プリカ
          if shop.dis2_3_kg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_kg_p).value(shop.dis2_3_kg.to_i + shop.minus_gak2.to_i)
          else
            row.item(:dis1_3_kg_p).value("")
          end
          
          #灯油
          #看板
          row.item(:dis1_tg).value(shop.dis2_2_tg)
          #現金(税込)18L
          row.item(:dis1_3_tg).value(shop.dis2_3_tg)
          #現金(税抜)
          row.item(:dis1_4_tg).value(get_zeinuki_print(shop.dis2_3_tg.to_f/18))
          #会員
          if shop.dis2_3_tg.to_i != 0 and shop.minus_gak3.to_i != 0
            row.item(:dis1_3_tg_k).value(shop.dis2_3_tg.to_i + (shop.minus_gak3.to_i * 18))
          else
            row.item(:dis1_3_tg_k).value("")
          end
          #プリカ
          if shop.dis2_3_tg.to_i != 0 and shop.minus_gak2.to_i != 0
            row.item(:dis1_3_tg_p).value(shop.dis2_3_tg.to_i + (shop.minus_gak2.to_i * 18))
          else
            row.item(:dis1_3_tg_p).value("")
          end
          #現金(税込)1L
          if shop.dis2_3_tg.to_i != 0
            row.item(:dis1_3_tg_l).value((shop.dis2_3_tg.to_f/18).round(1))
          else
            row.item(:dis1_3_tg_l).value("")
          end
          
          #当り確率
          row.item(:game).value(shop.game)
          
          #特売
          if shop.minus_gak1.to_i < 0
            row.item(:minus_name1).value(shop.minus_name1.to_s + "△" + (shop.minus_gak1.to_i * (-1)).to_s)
          else
            row.item(:minus_name1).value(shop.minus_name1.to_s + " " + shop.minus_gak1.to_s)
          end
          
          #プリカ/会員
          if @shop_kbn.to_i == 0
            #洗車
            if shop.minus_gak2.to_i != 0 
              if shop.minus_gak2.to_i < 0
                row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
              end
            elsif shop.minus_gak3.to_i != 0 
              if shop.minus_gak3.to_i < 0
                row.item(:minus_name2).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
              end
            else
              row.item(:minus_name2).value("")
            end
          else
            #油外
            if shop.minus_gak3.to_i != 0 
              if shop.minus_gak3.to_i < 0
                row.item(:minus_name2).value(shop.minus_name3.to_s + "△" + (shop.minus_gak3.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name3.to_s + " " + shop.minus_gak3.to_s)
              end
            elsif shop.minus_gak2.to_i != 0 
              if shop.minus_gak2.to_i < 0
                row.item(:minus_name2).value(shop.minus_name2.to_s + "△" + (shop.minus_gak2.to_i * (-1)).to_s)
              else
                row.item(:minus_name2).value(shop.minus_name2.to_s + " " + shop.minus_gak2.to_s)
              end
            else
              row.item(:minus_name2).value("")
            end
          end
          
          #備考
          row.item(:minus_name4).value(shop.minus_name4)
          #下看
          row.item(:dis1_2_code_name).value(shop.dis2_2_code_name)
          
        end #add_row
      end # shops.each
      pdf_title = "SS価格表(特売時)_#{ymd}.pdf"
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
