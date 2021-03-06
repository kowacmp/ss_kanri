# -*- coding:utf-8 -*-

#include DResultReportsHelper

class DResultReportsController < ApplicationController
  def index
    search 
  end

  def search
    
    if params[:input_ymd] == nil
      # UPDATE 2012.09.29 日付の規定値は前日
      #@input_ymd = Time.now.strftime("%Y/%m/%d")
      @input_ymd = (Time.now - 60*60*24).strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    
    #@input_ymd_s = @input_ymd.delete("/")
    
    @input_ymd_s = @input_ymd.delete("/")
    @input_ymd_s = @input_ymd_s[0,4] + @input_ymd_s[4,2] + "01"
    @input_ymd_e = @input_ymd.delete("/")
    
    @day_e = @input_ymd_e[6,2].to_i
    @month_last_day = Date.new(@input_ymd_e[0,4].to_i,@input_ymd_e[4,2].to_i).end_of_month.day.to_i
    
    @shop_info = MShop.find(current_user.m_shop_id)
    
    if params[:select_kbn] == nil
      if @shop_info.shop_kbn == 0
        @select_kbn = 2
      else
        @select_kbn = 0
      end
    else
      @select_kbn = params[:select_kbn].to_i
    end
    
    if @select_kbn == 0 or @select_kbn == 1
      where_sql_a = " and a2.shop_kbn = 1 "
      where_sql_b = " and b2.shop_kbn = 1 "
      where_sql_c = " and c1.shop_kbn = 1 "
    else
      where_sql_a = " and a2.shop_kbn = 0 "
      where_sql_b = " and b2.shop_kbn = 0 "
      where_sql_c = " and c1.shop_kbn = 0 "
    end
    
    
    select_sql =  " select * from "
    select_sql << " (select count(*) as mikakutei "
    select_sql << " from d_results a1 "
    select_sql << " left join (select * from m_shops) a2 on a1.m_shop_id = a2.id "
    select_sql << " where a1.result_date= '#{@input_ymd_e}' and a1.kakutei_flg = 0 and a2.deleted_flg = 0 #{where_sql_a}) a,"
    
    select_sql << " (select count(*) as kakutei "
    select_sql << " from d_results b1 "
    select_sql << " left join (select * from m_shops) b2 on b1.m_shop_id = b2.id "
    select_sql << " where b1.result_date= '#{@input_ymd_e}' and b1.kakutei_flg = 1 and b2.deleted_flg = 0 #{where_sql_b}) b,"
    
    select_sql << " (select count(*) as shop_count "
    select_sql << " from m_shops c1 "
    select_sql << " where c1.deleted_flg = 0 #{where_sql_c}) c "
    
    @kakutei_flg_count = DResult.find_by_sql("#{select_sql}").first
    
    #ラベル取得
    label_names_get(@select_kbn)
    
    #対象データを取得
    @m_shops = result_datas_get(@input_ymd_s, @input_ymd_e, @select_kbn, @shop_info)
    
  end
  
  def print
    @input_ymd_s = params[:input_ymd_s]
    @input_ymd_e = params[:input_ymd_e]
    @select_kbn = params[:select_kbn].to_i
    @shop_info = MShop.find(current_user.m_shop_id)
    
    #ラベル取得
    label_names_get(@select_kbn)
    
    #対象データを取得
    datas = result_datas_get(@input_ymd_s, @input_ymd_e, @select_kbn, @shop_info)
    
    if @select_kbn == 0
      print_result_1_report(datas,@input_ymd_e)
    elsif @select_kbn == 1
      print_result_2_report(datas,@input_ymd_e)
    elsif @select_kbn == 2
      print_result_self_1_report(datas,@input_ymd_e)
    elsif @select_kbn == 3
      print_result_self_2_report(datas,@input_ymd_e)
    else
      print_result_1_report(datas,@input_ymd_e)
    end

  end

  private
  #油外型実績表1
  def print_result_1_report(datas,input_ymd_e)
    
    mo_gas_total = 0
    r_mo_gas_total = 0
    keiyu_total = 0
    r_keiyu_total = 0
    touyu_total = 0
    r_touyu_total = 0
    koua_total = 0
    r_koua_total = 0
    buyou_total = 0
    r_buyou_total = 0
    tokusei_total = 0
    r_tokusei_total = 0
    sensya_total = 0
    r_sensya_total = 0
    koutin_total = 0
    r_koutin_total = 0
    taiya_total = 0
    r_taiya_total = 0
    arari_total = 0
    r_arari_total = 0
    
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_result_1_report.tlf')
    #2012/12/27 本社以外は日計/累計無
    if @shop_info.id == 1
      report.layout.config.list(:list) do
        # フッターに合計をセット.
        events.on :footer_insert do |e|
          e.section.item(:mo_gas_total).value(mo_gas_total.round(1))
          e.section.item(:r_mo_gas_total).value(r_mo_gas_total.round(1))
          e.section.item(:keiyu_total).value(keiyu_total.round(1))
          e.section.item(:r_keiyu_total).value(r_keiyu_total.round(1))
          e.section.item(:touyu_total).value(touyu_total.round(1))
          e.section.item(:r_touyu_total).value(r_touyu_total.round(1))
          e.section.item(:koua_total).value(koua_total.round(2))
          e.section.item(:r_koua_total).value(r_koua_total.round(2))
          e.section.item(:buyou_total).value(buyou_total)
          e.section.item(:r_buyou_total).value(r_buyou_total)
          e.section.item(:tokusei_total).value(tokusei_total)
          e.section.item(:r_tokusei_total).value(r_tokusei_total)
          e.section.item(:sensya_total).value(sensya_total)
          e.section.item(:r_sensya_total).value(r_sensya_total)
          e.section.item(:koutin_total).value(koutin_total)
          e.section.item(:r_koutin_total).value(r_koutin_total)
          e.section.item(:taiya_total).value(taiya_total)
          e.section.item(:r_taiya_total).value(r_taiya_total)
          e.section.item(:arari_total).value(arari_total)
          e.section.item(:r_arari_total).value(r_arari_total)
        end
      end
    end

    taisyo_ymd = input_ymd_e[0,4] + "-" + input_ymd_e[4,2] + "-" + input_ymd_e[6,2] 

    #ページ番号、タイトル、作成日セット  
    report.events.on :page_create do |e|
      e.page.item(:title).value("#{@title_label}実績表1")
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:taisyo_ymd).value(taisyo_ymd)
      #print_ymd = params[:input_ymd_s][0,4] + '年' + params[:input_ymd_s][4,2] + '月' + params[:input_ymd_s][6,2] + '日'
      #e.page.item(:title).value("")
    end #evants.on
    
    #report.start_new_page
    report.start_new_page do |page|
        page.item(:keiyu_label).value(@keiyu_label)
        page.item(:r_keiyu_label).value("R" + @keiyu_label)
        page.item(:touyu_label).value(@touyu_label)
        page.item(:r_touyu_label).value("R" + @touyu_label)
        page.item(:koua_label).value(@koua_label)
        page.item(:r_koua_label).value("R" + @koua_label)
        page.item(:buyou_label).value(@buyou_label)
        page.item(:r_buyou_label).value("R" + @buyou_label)
        page.item(:tokusei_label).value(@tokusei_label)
        page.item(:r_tokusei_label).value("R" + @tokusei_label)
        page.item(:sensya_label).value(@sensya_label)
        page.item(:r_sensya_label).value("R" + @sensya_label)
        page.item(:koutin_label).value(@koutin_label)
        page.item(:r_koutin_label).value("R" + @koutin_label)
        page.item(:taiya_label).value(@taiya_label)
        page.item(:r_taiya_label).value("R" + @taiya_label)
    end


    # 詳細作成
    datas.each do |data|
    # Set header datas.
      report.page.list(:list).add_row do |row|
        #row.item(:shop).value(data.shop_cd.to_s + ' ' + data.shop_ryaku) 
        row.item(:shop).value(data.shop_ryaku) 
                
        row.item(:mo_gas).value(data.mo_gas)
          mo_gas_total = mo_gas_total + data.mo_gas.to_f.round(1)
        row.item(:r_mo_gas).value(data.r_mo_gas)
          r_mo_gas_total = r_mo_gas_total + data.r_mo_gas.to_f.round(1)
        row.item(:keiyu).value(data.keiyu)
          keiyu_total = keiyu_total + data.keiyu.to_f.round(1)
        row.item(:r_keiyu).value(data.r_keiyu)
          r_keiyu_total = r_keiyu_total + data.r_keiyu.to_f.round(1)
        row.item(:touyu).value(data.touyu)
          touyu_total = touyu_total + data.touyu.to_f.round(1)
        row.item(:r_touyu).value(data.r_touyu)
          r_touyu_total = r_touyu_total + data.r_touyu.to_f.round(1)
        row.item(:koua).value(data.koua)
          koua_total = koua_total + data.koua.to_f.round(2)
        row.item(:r_koua).value(data.r_koua)
          r_koua_total = r_koua_total + data.r_koua.to_f.round(2)
        row.item(:buyou).value(data.buyou)
          buyou_total = buyou_total + data.buyou.to_i
        row.item(:r_buyou).value(data.r_buyou)
          r_buyou_total = r_buyou_total + data.r_buyou.to_i
        row.item(:tokusei).value(data.tokusei)
          tokusei_total = tokusei_total + data.tokusei.to_i
        row.item(:r_tokusei).value(data.r_tokusei)
          r_tokusei_total = r_tokusei_total + data.r_tokusei.to_i
        row.item(:sensya).value(data.sensya)
          sensya_total = sensya_total + data.sensya.to_i
        row.item(:r_sensya).value(data.r_sensya)
          r_sensya_total = r_sensya_total + data.r_sensya.to_i
        row.item(:koutin).value(data.koutin)
          koutin_total = koutin_total + data.koutin.to_i
        row.item(:r_koutin).value(data.r_koutin)
          r_koutin_total = r_koutin_total + data.r_koutin.to_i
        row.item(:taiya).value(data.taiya)
          taiya_total = taiya_total + data.taiya.to_i
        row.item(:r_taiya).value(data.r_taiya)
          r_taiya_total = r_taiya_total + data.r_taiya.to_i
        row.item(:arari).value(data.arari)
          arari_total = arari_total + data.arari.to_i
        row.item(:r_arari).value(data.r_arari)
          r_arari_total = r_arari_total + data.r_arari.to_i
      end #add_row
    end # datas.each
  
  
    #タイトルセット
    pdf_title = "#{@title_label}実績表1.pdf"
    
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'    
  end
  #油外型実績表2
  def print_result_2_report(datas,input_ymd_e)
    @day_e = input_ymd_e[6,2].to_i
    @month_last_day = Date.new(input_ymd_e[0,4].to_i,input_ymd_e[4,2].to_i).end_of_month.day.to_i
    
    r_chousei_total = 0
    syaken_total = 0
    r_syaken_total = 0
    kyuyu_purika_total = 0
    r_kyuyu_purika_total = 0
    sensya_purika_total = 0
    r_sensya_purika_total = 0
    sp_total = 0
    r_sp_total = 0
    sc_total = 0
    r_sc_total = 0
    taiyaw_total = 0
    r_taiyaw_total = 0
    sp_plus_total = 0
    r_sp_plus_total = 0
    atf_total = 0
    r_atf_total = 0
    kousen_total = 0
    r_kousen_total = 0
    bt_total = 0
    r_bt_total = 0
    bankin_total = 0
    r_bankin_total = 0
    waiper_total = 0
    r_waiper_total = 0
    mobil1_total = 0
    r_mobil1_total = 0
    
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_result_2_report.tlf')

    #2012/12/27 本社以外は日計/累計無
    if @shop_info.id == 1
      report.layout.config.list(:list) do
        # フッターに合計をセット.
        events.on :footer_insert do |e|
          e.section.item(:r_chousei_total).value(r_chousei_total)
          e.section.item(:syaken_total).value(syaken_total)
          e.section.item(:r_syaken_total).value(r_syaken_total)
          e.section.item(:kyuyu_purika_total).value(kyuyu_purika_total)
          e.section.item(:r_kyuyu_purika_total).value(r_kyuyu_purika_total)
          e.section.item(:sensya_purika_total).value(sensya_purika_total)
          e.section.item(:r_sensya_purika_total).value(r_sensya_purika_total)
          e.section.item(:sp_total).value(sp_total)
          e.section.item(:r_sp_total).value(r_sp_total)
          e.section.item(:sc_total).value(sc_total)
          e.section.item(:r_sc_total).value(r_sc_total)
          e.section.item(:taiyaw_total).value(taiyaw_total)
          e.section.item(:r_taiyaw_total).value(r_taiyaw_total)
          e.section.item(:sp_plus_total).value(sp_plus_total)
          e.section.item(:r_sp_plus_total).value(r_sp_plus_total)
          e.section.item(:atf_total).value(atf_total.round(2))
          e.section.item(:r_atf_total).value(r_atf_total.round(2))
          e.section.item(:kousen_total).value(kousen_total)
          e.section.item(:r_kousen_total).value(r_kousen_total)
          e.section.item(:bt_total).value(bt_total)
          e.section.item(:r_bt_total).value(r_bt_total)
          e.section.item(:bankin_total).value(bankin_total)
          e.section.item(:r_bankin_total).value(r_bankin_total)
          e.section.item(:waiper_total).value(waiper_total)
          e.section.item(:r_waiper_total).value(r_waiper_total)
          e.section.item(:mobil1_total).value(mobil1_total.round(2))
          e.section.item(:r_mobil1_total).value(r_mobil1_total.round(2))
        end
      end
    end

    taisyo_ymd = input_ymd_e[0,4] + "-" + input_ymd_e[4,2] + "-" + input_ymd_e[6,2] 

    #ページ番号、タイトル、作成日セット  
    report.events.on :page_create do |e|
      e.page.item(:title).value("#{@title_label}実績表2")
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:taisyo_ymd).value(taisyo_ymd)
      #print_ymd = params[:input_ymd_s][0,4] + '年' + params[:input_ymd_s][4,2] + '月' + params[:input_ymd_s][6,2] + '日'
      #e.page.item(:title).value("")
    end #evants.on
    
    #report.start_new_page
    report.start_new_page do |page|
        page.item(:chousei_label).value(@chousei_label)
        page.item(:syaken_label).value(@syaken_label)
        page.item(:kyuyu_purika_label).value(@kyuyu_purika_label)
        page.item(:sensya_purika_label).value(@sensya_purika_label)
        page.item(:sp_label).value(@sp_label)
        page.item(:sc_label).value(@sc_label)
        page.item(:taiyaw_label).value(@taiyaw_label)
        page.item(:sp_plus_label).value(@sp_plus_label)
        page.item(:atf_label).value(@atf_label)
        page.item(:kousen_label).value(@kousen_label)
        page.item(:bt_label).value(@bt_label)
        page.item(:bankin_label).value(@bankin_label)
        page.item(:waiper_label).value(@waiper_label)
        page.item(:mobil1_label).value(@mobil1_label)
    end


    # 詳細作成
    datas.each do |data|
    # Set header datas.
      report.page.list(:list).add_row do |row|
        #row.item(:shop).value(data.shop_cd.to_s + ' ' + data.shop_ryaku) 
        row.item(:shop).value(data.shop_ryaku) 
        row.item(:r_chousei).value(data.r_chousei)
          r_chousei_total = r_chousei_total + data.r_chousei.to_i
        #row.item(:oiletc_aim).value(data.oiletc_aim)
        if data.oiletc_aim
          row.item(:oiletc_aim).value((data.oiletc_aim.to_f / 10000).truncate)
        else
          row.item(:oiletc_aim).value("")
        end
        
        if data.r_arari
          #@oiletc_pace = (data.r_arari.to_f / @day_e * @month_last_day).round(0)
          @oiletc_pace = (data.r_arari.to_f / @day_e * @month_last_day / 10000).truncate
        else
          @oiletc_pace = ""
        end
        #row.item(:oiletc_pace).value(data.oiletc_pace)
        row.item(:oiletc_pace).value(@oiletc_pace)
        row.item(:syaken_aim).value(data.syaken_aim)  
        row.item(:syaken).value(data.syaken)
          syaken_total = syaken_total + data.syaken.to_i
        row.item(:r_syaken).value(data.r_syaken)
          r_syaken_total = r_syaken_total + data.r_syaken.to_i
        row.item(:kyuyu_purika).value(data.kyuyu_purika)
          kyuyu_purika_total = kyuyu_purika_total + data.kyuyu_purika.to_i
        row.item(:r_kyuyu_purika).value(data.r_kyuyu_purika)
          r_kyuyu_purika_total = r_kyuyu_purika_total + data.r_kyuyu_purika.to_i
        row.item(:sensya_purika).value(data.sensya_purika)
          sensya_purika_total = sensya_purika_total + data.sensya_purika.to_i
        row.item(:r_sensya_purika).value(data.r_sensya_purika)
          r_sensya_purika_total = r_sensya_purika_total + data.r_sensya_purika.to_i
        row.item(:sp).value(data.sp)
          sp_total = sp_total + data.sp.to_i
        row.item(:r_sp).value(data.r_sp)
          r_sp_total = r_sp_total + data.r_sp.to_i
        row.item(:sc).value(data.sc)
          sc_total = sc_total + data.sc.to_i
        row.item(:r_sc).value(data.r_sc)
          r_sc_total = r_sc_total + data.r_sc.to_i
        row.item(:taiyaw).value(data.taiyaw)
          taiyaw_total = taiyaw_total + data.taiyaw.to_i
        row.item(:r_taiyaw).value(data.r_taiyaw)
          r_taiyaw_total = r_taiyaw_total + data.r_taiyaw.to_i
        row.item(:sp_plus).value(data.sp_plus)
          sp_plus_total = sp_plus_total + data.sp_plus.to_i
        row.item(:r_sp_plus).value(data.r_sp_plus)
          r_sp_plus_total = r_sp_plus_total + data.r_sp_plus.to_i
        row.item(:atf).value(data.atf)
          atf_total = atf_total + data.atf.to_f.round(2)
        row.item(:r_atf).value(data.r_atf)
          r_atf_total = r_atf_total + data.r_atf.to_f.round(2)
        row.item(:kousen).value(data.kousen)
          kousen_total = kousen_total + data.kousen.to_i
        row.item(:r_kousen).value(data.r_kousen)
          r_kousen_total = r_kousen_total + data.r_kousen.to_i
        row.item(:bt).value(data.bt)
          bt_total = bt_total + data.bt.to_i
        row.item(:r_bt).value(data.r_bt)
          r_bt_total = r_bt_total + data.r_bt.to_i
        row.item(:bankin).value(data.bankin)
          bankin_total = bankin_total + data.bankin.to_i
        row.item(:r_bankin).value(data.r_bankin)
          r_bankin_total = r_bankin_total + data.r_bankin.to_i
        row.item(:waiper).value(data.waiper)
          waiper_total = waiper_total + data.waiper.to_i
        row.item(:r_waiper).value(data.r_waiper)
          r_waiper_total = r_waiper_total + data.r_waiper.to_i
        row.item(:mobil1).value(data.mobil1)
          mobil1_total = mobil1_total + data.mobil1.to_f.round(2)
        row.item(:r_mobil1).value(data.r_mobil1)
          r_mobil1_total = r_mobil1_total + data.r_mobil1.to_f.round(2)
      end #add_row
    end # datas.each
  
  
    #タイトルセット
    pdf_title = "#{@title_label}実績表2.pdf"
    
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'    
  end
  #洗車型実績表1
  def print_result_self_1_report(datas,input_ymd_e)
#2012/12/26 集計表示
    #モーガス
    mo_gas_total = 0
    r_mo_gas_total = 0
    #軽油
    keiyu_total = 0
    r_keiyu_total = 0
    #灯油
    touyu_total = 0
    r_touyu_total = 0
    #GP
    kyuyu_purika_total = 0
    r_kyuyu_purika_total = 0
    #CB
    cb_total = 0
    r_cb_total = 0

    
    @day_e = input_ymd_e[6,2].to_i
    @month_last_day = Date.new(input_ymd_e[0,4].to_i,input_ymd_e[4,2].to_i).end_of_month.day.to_i
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_result_self_1_report.tlf')
    #2012/12/26 集計表示
    #2012/12/27 本社以外は日計/累計無
    if @shop_info.id == 1
      report.layout.config.list(:list) do
        # フッターに合計をセット.
        events.on :footer_insert do |e|
          e.section.item(:mo_gas_total).value(mo_gas_total.round(1))
          e.section.item(:r_mo_gas_total).value(r_mo_gas_total.round(1))
          e.section.item(:keiyu_total).value(keiyu_total.round(1))
          e.section.item(:r_keiyu_total).value(r_keiyu_total.round(1))
          e.section.item(:touyu_total).value(touyu_total.round(1))
          e.section.item(:r_touyu_total).value(r_touyu_total.round(1))
          e.section.item(:kyuyu_purika_total).value(kyuyu_purika_total)
          e.section.item(:r_kyuyu_purika_total).value(r_kyuyu_purika_total)
          e.section.item(:cb_total).value(cb_total)
          e.section.item(:r_cb_total).value(r_cb_total)
        end
      end
    end

    taisyo_ymd = input_ymd_e[0,4] + "-" + input_ymd_e[4,2] + "-" + input_ymd_e[6,2] 

    #ページ番号、タイトル、作成日セット  
    report.events.on :page_create do |e|
      e.page.item(:title).value("#{@title_label}実績表1")
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:taisyo_ymd).value(taisyo_ymd)
      #print_ymd = params[:input_ymd_s][0,4] + '年' + params[:input_ymd_s][4,2] + '月' + params[:input_ymd_s][6,2] + '日'
      #e.page.item(:title).value("")
    end #evants.on
    
    #report.start_new_page
    report.start_new_page do |page|
        page.item(:keiyu_label).value(@keiyu_label)
        page.item(:r_keiyu_label).value("R" + @keiyu_label)
        page.item(:keiyu_pace_label).value(@keiyu_label + "ペース")
        page.item(:keiyu_aim_label).value(@keiyu_label + "目標")
        page.item(:touyu_label).value(@touyu_label)
        page.item(:r_touyu_label).value("R" + @touyu_label)
        page.item(:touyu_pace_label).value(@touyu_label + "ペース")
        page.item(:touyu_aim_label).value(@touyu_label + "目標")
        
        page.item(:kyuyu_purika_aim_label).value(@kyuyu_purika_label + "目標")
        page.item(:kyuyu_purika_label).value(@kyuyu_purika_label)
        page.item(:r_kyuyu_purika_label).value("R" + @kyuyu_purika_label)
        page.item(:kyuyu_purika_pace_label).value(@kyuyu_purika_label + "ペース")
        
        page.item(:cb_label).value(@cb_label)
        page.item(:r_cb_label).value("R" + @cb_label)
    end


    # 詳細作成
    datas.each do |data|
    # Set header datas.
      report.page.list(:list).add_row do |row|
        #row.item(:shop).value(data.shop_cd.to_s + ' ' + data.shop_ryaku) 
        row.item(:shop).value(data.shop_ryaku) 

        row.item(:mo_gas).value(data.mo_gas)
        row.item(:r_mo_gas).value(data.r_mo_gas)
        if data.r_mo_gas
          @mo_gas_pace = (data.r_mo_gas.to_f / @day_e * @month_last_day).round(0)
        else
          @mo_gas_pace = ""
        end
        row.item(:mo_gas_pace).value(@mo_gas_pace)
        
        #if data.hg_aim != nil or data.rg_aim != nil
        #  mo_gas_aim = data.hg_aim.to_i + data.hg_aim.to_i
        #end
        #row.item(:mo_gas_aim).value(mo_gas_aim)
        row.item(:mo_gas_aim).value(data.mo_gas_aim)
        
        row.item(:keiyu).value(data.keiyu)
        row.item(:r_keiyu).value(data.r_keiyu)
        
        if data.r_keiyu
          @keiyu_pace = (data.r_keiyu.to_f / @day_e * @month_last_day).round(0)
        else
          @keiyu_pace = ""
        end
        row.item(:keiyu_pace).value(@keiyu_pace)
        row.item(:keiyu_aim).value(data.keiyu_aim)
        row.item(:touyu).value(data.touyu)
        row.item(:r_touyu).value(data.r_touyu)
        
        if data.r_touyu
          @touyu_pace = (data.r_touyu.to_f / @day_e * @month_last_day).round(0)
        else
          @touyu_pace = ""
        end
        row.item(:touyu_pace).value(@touyu_pace)
        row.item(:touyu_aim).value(data.touyu_aim)
        
        #row.item(:kyuyu_purika_aim).value(data.kyuyu_purika_aim)
        if data.kyuyu_purika_aim
          row.item(:kyuyu_purika_aim).value((data.kyuyu_purika_aim.to_f / 10000).truncate)
        else
          row.item(:kyuyu_purika_aim).value("")
        end
        
        row.item(:kyuyu_purika).value(data.kyuyu_purika)
        row.item(:r_kyuyu_purika).value(data.r_kyuyu_purika)
        
        if data.r_kyuyu_purika
          @kyuyu_purika_pace = (data.r_kyuyu_purika.to_f / @day_e * @month_last_day).round(0)
        else
          @kyuyu_purika_pace = ""
        end
        row.item(:kyuyu_purika_pace).value(@kyuyu_purika_pace)
        
        row.item(:cb).value(data.cb)
        row.item(:r_cb).value(data.r_cb)
        #2012/12/26 集計表示
        mo_gas_total = mo_gas_total + data.mo_gas.to_f.round(1)
        r_mo_gas_total = r_mo_gas_total + data.r_mo_gas.to_f.round(1)
        keiyu_total = keiyu_total + data.keiyu.to_f.round(1)
        r_keiyu_total = r_keiyu_total + data.r_keiyu.to_f.round(1)
        touyu_total = touyu_total + data.touyu.to_f.round(1)
        r_touyu_total = r_touyu_total + data.r_touyu.to_f.round(1)
        kyuyu_purika_total = kyuyu_purika_total + data.kyuyu_purika.to_i
        r_kyuyu_purika_total = r_kyuyu_purika_total + data.r_kyuyu_purika.to_i
        cb_total = cb_total + data.cb.to_i
        r_cb_total = r_cb_total + data.r_cb.to_i
      end #add_row
    end # datas.each
  
  
    #タイトルセット
    pdf_title = "#{@title_label}実績表1.pdf"
    
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'    
  end
  #油外型実績表2
  def print_result_self_2_report(datas,input_ymd_e)
#2012/12/26 集計表示
#洗車
sensya_total = 0
r_sensya_total = 0
#洗車ﾌﾟﾘｶ
sensya_purika_total = 0
r_sensya_purika_total = 0
#ﾑｰﾄﾝﾊﾟｽ
muton_total = 0
r_muton_total = 0
#SPﾌﾟﾗｽ
sp_plus_total = 0
r_sp_plus_total = 0
#ﾀｲﾔW
taiyaw_total = 0
r_taiyaw_total = 0
#SC
sc_total = 0
r_sc_total = 0
#SP
sp_total = 0
r_sp_total = 0
#洗用品
r_wash_item_total = 0
#ｽﾛｯﾄ
r_game_total = 0
#ﾍﾙｽ
r_health_total = 0
#ﾈｯﾄ
r_net_total = 0
#充電器
r_charge_total = 0
#ｵｿﾞﾝ
r_ozone_total = 0


    @day_e = input_ymd_e[6,2].to_i
    @month_last_day = Date.new(input_ymd_e[0,4].to_i,input_ymd_e[4,2].to_i).end_of_month.day.to_i
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_result_self_2_report.tlf')
    #2012/12/26 集計表示
    #2012/12/27 本社以外は日計/累計無
    if @shop_info.id == 1
      report.layout.config.list(:list) do
        # フッターに合計をセット.
        events.on :footer_insert do |e|
          e.section.item(:sensya_total).value(sensya_total)
          e.section.item(:r_sensya_total).value(r_sensya_total)
          e.section.item(:sensya_purika_total).value(sensya_purika_total)
          e.section.item(:r_sensya_purika_total).value(r_sensya_purika_total)
          e.section.item(:muton_total).value(muton_total)
          e.section.item(:r_muton_total).value(r_muton_total)
          e.section.item(:sp_plus_total).value(sp_plus_total)
          e.section.item(:r_sp_plus_total).value(r_sp_plus_total)
          e.section.item(:taiyaw_total).value(taiyaw_total)
          e.section.item(:r_taiyaw_total).value(r_taiyaw_total)
          e.section.item(:sc_total).value(sc_total)
          e.section.item(:r_sc_total).value(r_sc_total)
          e.section.item(:sp_total).value(sp_total)
          e.section.item(:r_sp_total).value(r_sp_total)
          e.section.item(:r_wash_item_total).value(r_wash_item_total)
          e.section.item(:r_game_total).value(r_game_total)
          e.section.item(:r_health_total).value(r_health_total)
          e.section.item(:r_net_total).value(r_net_total)
          e.section.item(:r_charge_total).value(r_charge_total)
          e.section.item(:r_ozone_total).value(r_ozone_total)
        end
      end
    end

    taisyo_ymd = input_ymd_e[0,4] + "-" + input_ymd_e[4,2] + "-" + input_ymd_e[6,2] 

    #ページ番号、タイトル、作成日セット  
    report.events.on :page_create do |e|
      e.page.item(:title).value("#{@title_label}実績表2")
      e.page.item(:page).value(e.page.no)
      e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:taisyo_ymd).value(taisyo_ymd)
    end #evants.on
    
    #report.start_new_page
    report.start_new_page do |page|
        page.item(:sensya_label).value(@sensya_label)
        page.item(:sensya_purika_label).value(@sensya_purika_label)
        page.item(:muton_label).value(@muton_label)
        page.item(:sp_plus_label).value(@sp_plus_label)
        page.item(:taiyaw_label).value(@taiyaw_label)
        page.item(:sc_label).value(@sc_label)
        page.item(:sp_label).value(@sp_label)
        
        page.item(:r_wash_item_label).value("R" + @wash_item_label)
        page.item(:r_game_label).value("R" + @game_label)
        page.item(:r_health_label).value("R" + @health_label)
        page.item(:r_net_label).value("R" + @net_label)
        page.item(:r_charge_label).value("R" + @charge_label)
        page.item(:r_ozone_label).value("R" + @ozone_label)
    end

    # 詳細作成
    datas.each do |data|
    # Set header datas.
      report.page.list(:list).add_row do |row|
        #row.item(:shop).value(data.shop_cd.to_s + ' ' + data.shop_ryaku) 
        row.item(:shop).value(data.shop_ryaku) 
        
        row.item(:sensya).value(data.sensya)
        row.item(:r_sensya).value(data.r_sensya)
        row.item(:sensya_aim).value(data.sensya_aim)
        
        if data.r_sensya
          @sensya_pace = (data.r_sensya.to_f / @day_e * @month_last_day).round(0)
        else
          @sensya_pace = ""
        end
        row.item(:sensya_pace).value(@sensya_pace)
        
        row.item(:sensya_purika).value(data.sensya_purika)
        row.item(:r_sensya_purika).value(data.r_sensya_purika)
        row.item(:sensya_purika_aim).value(data.sensya_purika_aim)
        
        if data.r_sensya_purika
          @sensya_purika_pace = (data.r_sensya_purika.to_f / @day_e * @month_last_day).round(0)
        else
          @sensya_purika_pace = ""
        end
        row.item(:sensya_purika_pace).value(@sensya_purika_pace)
        
        #row.item(:muton).value(data.muton)
        row.item(:muton).value(data.muton_aim)
        row.item(:r_muton).value(data.r_muton)
        #row.item(:sp_plus).value(data.sp_plus)
        row.item(:sp_plus).value(data.sp_plus_aim)
        row.item(:r_sp_plus).value(data.r_sp_plus)
        #row.item(:taiyaw).value(data.taiyaw)
        row.item(:taiyaw).value(data.taiyaw_aim)
        row.item(:r_taiyaw).value(data.r_taiyaw)
        #row.item(:sc).value(data.sc)
        row.item(:sc).value(data.sc_aim)
        row.item(:r_sc).value(data.r_sc)
        #row.item(:sp).value(data.sp)
        row.item(:sp).value(data.sp_aim)
        row.item(:r_sp).value(data.r_sp)
        
        row.item(:r_wash_item).value(data.r_wash_item)
        row.item(:r_game).value(data.r_game)
        row.item(:r_health).value(data.r_health)
        row.item(:r_net).value(data.r_net)
        row.item(:r_charge).value(data.r_charge)
        row.item(:r_ozone).value(data.r_ozone)
        
        #2012/12/26 集計表示
        sensya_total = sensya_total + data.sensya.to_i
        sensya_purika_total = sensya_purika_total + data.sensya_purika.to_i
        muton_total = muton_total + data.muton_aim.to_i
        sp_plus_total = sp_plus_total + data.sp_plus_aim.to_i
        taiyaw_total = taiyaw_total + data.taiyaw_aim.to_i
        sc_total = sc_total + data.sc_aim.to_i
        sp_total = sp_total + data.sp_aim.to_i
        
        r_sensya_total = r_sensya_total + data.r_sensya.to_i
        r_sensya_purika_total = r_sensya_purika_total + data.r_sensya_purika.to_i
        r_muton_total = r_muton_total + data.r_muton.to_i
        r_sp_plus_total = r_sp_plus_total + data.r_sp_plus.to_i
        r_taiyaw_total = r_taiyaw_total + data.r_taiyaw.to_i
        r_sc_total = r_sc_total + data.r_sc.to_i
        r_sp_total = r_sp_total + data.r_sp.to_i
        r_wash_item_total = r_wash_item_total + data.r_wash_item.to_i
        r_game_total = r_game_total + data.r_game.to_i
        r_health_total = r_health_total + data.r_health.to_i
        r_net_total = r_net_total + data.r_net.to_i
        r_charge_total = r_charge_total + data.r_charge.to_i
        r_ozone_total = r_ozone_total + data.r_ozone.to_i

      end #add_row
    end # datas.each
  
  
    #タイトルセット
    pdf_title = "#{@title_label}実績表2.pdf"
    
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'    
  end
  
  #ラベル取得
  def label_names_get(select_kbn)
    
    if select_kbn == 0
      @title_label = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
      
      @keiyu_label = MOil.find(3) ? MOil.find(3).oil_name : "軽油"
      @touyu_label = MOil.find(4) ? MOil.find(4).oil_name : "灯油"
      
      @koua_label = MOiletc.find(1) ? MOiletc.find(1).oiletc_ryaku : "高A"
      @buyou_label = MOiletc.find(2) ? MOiletc.find(2).oiletc_ryaku : "部用"
      @tokusei_label = MOiletc.find(3) ? MOiletc.find(3).oiletc_ryaku : "特製"
      @sensya_label = MOiletc.find(4) ? MOiletc.find(4).oiletc_ryaku : "洗車"
      @koutin_label = MOiletc.find(5) ? MOiletc.find(5).oiletc_ryaku : "工賃"
      @taiya_label = MOiletc.find(6) ? MOiletc.find(6).oiletc_ryaku : "タイヤ"
    elsif select_kbn == 1
      @title_label = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
      
      @chousei_label = MOiletc.find(28) ? MOiletc.find(28).oiletc_ryaku : "調整"
      @syaken_label = MOiletc.find(13) ? MOiletc.find(13).oiletc_ryaku : "車検"
      @kyuyu_purika_label = MOiletc.find(8) ? MOiletc.find(8).oiletc_ryaku : "GP"
      @sensya_purika_label = MOiletc.find(11) ? MOiletc.find(11).oiletc_ryaku : "洗車PPC"
      @sp_label = MOiletc.find(9) ? MOiletc.find(9).oiletc_ryaku : "SP"
      @sc_label = MOiletc.find(23) ? MOiletc.find(23).oiletc_ryaku : "SC"
      @taiyaw_label = MOiletc.find(27) ? MOiletc.find(27).oiletc_ryaku : "タイヤW"
      @sp_plus_label = MOiletc.find(26) ? MOiletc.find(26).oiletc_ryaku : "SPプラス"
      @atf_label = MOiletc.find(14) ? MOiletc.find(14).oiletc_ryaku : "ATF"
      @kousen_label = MOiletc.find(15) ? MOiletc.find(15).oiletc_ryaku : "高洗"
      @bt_label = MOiletc.find(17) ? MOiletc.find(17).oiletc_ryaku : "BT"
      @bankin_label = MOiletc.find(7) ? MOiletc.find(7).oiletc_ryaku : "板金"
      @waiper_label = MOiletc.find(18) ? MOiletc.find(18).oiletc_ryaku : "ワイパー"
      @mobil1_label = MOiletc.find(19) ? MOiletc.find(19).oiletc_ryaku : "M-1"
    elsif select_kbn == 2
      @title_label = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
      
      @keiyu_label = MOil.find(3) ? MOil.find(3).oil_name : "軽油"
      @touyu_label = MOil.find(4) ? MOil.find(4).oil_name : "灯油"
      
      @kyuyu_purika_label = MOiletc.find(8) ? MOiletc.find(8).oiletc_ryaku : "GP"
      @cb_label = MOiletc.find(24) ? MOiletc.find(24).oiletc_ryaku : "CB"
      #2014/05/12 add
      @type_err_label = MOiletc.find(42) ? MOiletc.find(42).oiletc_ryaku : "入力ミス"
    elsif select_kbn == 3
      @title_label = MCode.find_by_kbn_and_code('shop_kbn','0') ? MCode.find_by_kbn_and_code('shop_kbn','0').code_name : "洗車型"
      
      @sensya_label = MOiletc.find(4) ? MOiletc.find(4).oiletc_ryaku : "洗車"
      @sensya_purika_label = MOiletc.find(11) ? MOiletc.find(11).oiletc_ryaku : "洗車PPC"
      @muton_label = MOiletc.find(22) ? MOiletc.find(22).oiletc_ryaku : "ムートンパス"
      @sp_plus_label = MOiletc.find(26) ? MOiletc.find(26).oiletc_ryaku : "SPプラス"
      @taiyaw_label = MOiletc.find(27) ? MOiletc.find(27).oiletc_ryaku : "タイヤW"
      @sc_label = MOiletc.find(23) ? MOiletc.find(23).oiletc_ryaku : "SC"
      @sp_label = MOiletc.find(9) ? MOiletc.find(9).oiletc_ryaku : "SP"
      
      #2012/09/24 nishimura マスタ統合による修正
      #@wash_item_label = MEtc.find(10) ? MEtc.find(10).etc_ryaku : "洗車用品"
      #@game_label = MEtc.find(12) ? MEtc.find(12).etc_ryaku : "スロット"
      #@health_label = MEtc.find(11) ? MEtc.find(11).etc_ryaku : "ヘルス"
      #@net_label = MEtc.find(14) ? MEtc.find(14).etc_ryaku : "ネット"
      #@charge_label = MEtc.find(13) ? MEtc.find(13).etc_ryaku : "充電器"
      #@ozone_label = MEtc.find(15) ? MEtc.find(15).etc_ryaku : "脱臭機"
      @wash_item_label = MOiletc.find(35) ? MOiletc.find(35).oiletc_ryaku : "洗車用品"
      @game_label = MOiletc.find(36) ? MOiletc.find(36).oiletc_ryaku : "スロット"
      @health_label = MOiletc.find(37) ? MOiletc.find(37).oiletc_ryaku : "ヘルス"
      @net_label = MOiletc.find(38) ? MOiletc.find(38).oiletc_ryaku : "ネット"
      @charge_label = MOiletc.find(39) ? MOiletc.find(39).oiletc_ryaku : "充電器"
      @ozone_label = MOiletc.find(40) ? MOiletc.find(40).oiletc_ryaku : "脱臭機"
      #@spare_label = "予備"
    else
      @title_label = MCode.find_by_kbn_and_code('shop_kbn','1') ? MCode.find_by_kbn_and_code('shop_kbn','1').code_name : "油外型"
      
      @keiyu_label = MOil.find(3) ? MOil.find(3).oil_name : "軽油"
      @touyu_label = MOil.find(4) ? MOil.find(4).oil_name : "灯油"
      
      @koua_label = MOiletc.find(1) ? MOiletc.find(1).oiletc_ryaku : "高A"
      @buyou_label = MOiletc.find(2) ? MOiletc.find(2).oiletc_ryaku : "部用"
      @tokusei_label = MOiletc.find(3) ? MOiletc.find(3).oiletc_ryaku : "特製"
      @sensya_label = MOiletc.find(4) ? MOiletc.find(4).oiletc_ryaku : "洗車"
      @koutin_label = MOiletc.find(5) ? MOiletc.find(5).oiletc_ryaku : "工賃"
      @taiya_label = MOiletc.find(6) ? MOiletc.find(6).oiletc_ryaku : "タイヤ"
    end
    
    
  end
  
  
  #データ取得SQL実行
  def result_datas_get(input_ymd_s, input_ymd_e, select_kbn, shop_info)
    
    input_day = input_ymd_e[6,2].to_i
    if input_day == 0
      input_day = 1
    end
    
    input_month = input_ymd_e[0,6]
    
    
    if select_kbn == 0
      #油外型実績表1
      select_sql = "select a.*, b.*, c.*, d.*"
    
      select_sql << " from (select id, shop_cd, shop_name,shop_ryaku from m_shops where deleted_flg = 0 and shop_kbn = 1) a "

      select_sql << " left join (select id ,m_shop_id"
      select_sql <<              " from d_results where result_date = '#{input_ymd_e}') b on a.id = b.m_shop_id" 
      
      select_sql << " left join (select d_result_id,mo_gas,keiyu,touyu,koua,buyou,tokusei, "
      #select_sql <<                   " sensya,koutin,taiya,arari"
      select_sql <<                   " sensya,koutin,taiya,trunc(arari,0) as arari"
      select_sql <<            " from d_result_reports) c on b.id = c.d_result_id"
      
      select_sql << " left join (select d1.m_shop_id,"
      select_sql <<       "sum(d2.mo_gas) as r_mo_gas, sum(d2.keiyu)   as r_keiyu,"
      select_sql <<       "sum(d2.touyu)  as r_touyu,  sum(d2.koua)    as r_koua,"
      select_sql <<       "sum(d2.buyou)  as r_buyou,  sum(d2.tokusei) as r_tokusei,"
      select_sql <<       "sum(d2.sensya) as r_sensya, sum(d2.koutin)  as r_koutin,"
      #select_sql <<       "sum(d2.taiya)  as r_taiya,  sum(d2.arari)   as r_arari"
      select_sql <<       "sum(d2.taiya)  as r_taiya,  sum(trunc(d2.arari,0))   as r_arari"
      select_sql <<            " from d_results d1"
      select_sql <<            " left join (select * from d_result_reports) d2 on d1.id = d2.d_result_id"
      select_sql <<            " where d1.result_date >= '#{input_ymd_s}' and d1.result_date <= '#{input_ymd_e}' "
      select_sql <<      " group by d1.m_shop_id"
      select_sql <<      " ) d on a.id = d.m_shop_id "
      
    elsif select_kbn == 1
      #油外型実績表2
      select_sql = "select a.*, b.*, c.*, d.*, e.*, f.*"
    
      select_sql << " from (select id, shop_cd, shop_name,shop_ryaku from m_shops where deleted_flg = 0 and shop_kbn = 1) a "
      
      select_sql << " left join (select id ,m_shop_id"
      select_sql <<              " from d_results where result_date = '#{input_ymd_e}') b on a.id = b.m_shop_id" 
      
      select_sql << " left join (select d_result_id,chousei,oiletc_pace,syaken,kyuyu_purika,sensya_purika,sp,sc, "
      select_sql <<                   " taiyaw,sp_plus,atf,kousen,bt,bankin,waiper,mobil1"
      select_sql <<            " from d_result_reports) c on b.id = c.d_result_id"
      
      select_sql << " left join (select d1.m_shop_id,"
      select_sql <<       "sum(d2.chousei) as r_chousei,sum(d2.syaken) as r_syaken, sum(d2.kyuyu_purika) as r_kyuyu_purika,"
      select_sql <<       "sum(d2.sensya_purika) as r_sensya_purika, sum(d2.sp) as r_sp,"
      select_sql <<       "sum(d2.sc) as r_sc, sum(d2.taiyaw) as r_taiyaw,"
      select_sql <<       "sum(d2.sp_plus) as r_sp_plus, sum(d2.atf) as r_atf,"
      select_sql <<       "sum(d2.kousen) as r_kousen, sum(d2.bt) as r_bt,"
      select_sql <<       "sum(d2.bankin) as r_bankin, sum(d2.waiper) as r_waiper, sum(d2.mobil1) as r_mobil1,"
      select_sql <<       "sum(trunc(d2.arari,0))   as r_arari"
      select_sql <<            " from d_results d1"
      select_sql <<            " left join (select * from d_result_reports) d2 on d1.id = d2.d_result_id"
      select_sql <<            " where d1.result_date >= '#{input_ymd_s}' and d1.result_date <= '#{input_ymd_e}' "
      select_sql <<      " group by d1.m_shop_id"
      select_sql <<      " ) d on a.id = d.m_shop_id "
      
      #油外売上
      #select_sql << " left join (select e1.m_shop_id,e1.aim_value#{input_day} as oiletc_aim from d_aims e1"
      select_sql << " left join (select e1.m_shop_id,e1.aim_total as oiletc_aim from d_aims e1"
      select_sql <<            " left join m_aims e2 on e1.m_aim_id = e2.id"
      select_sql << " where e1.date = '#{input_month}' and e2.id = 1 ) e on a.id = e.m_shop_id "
      #車検
      select_sql << " left join (select f1.m_shop_id,f1.aim_total as syaken_aim from d_aims f1"
      select_sql <<            " left join m_aims f2 on f1.m_aim_id = f2.id"
      #select_sql << " where f1.date = '#{input_month}' and f2.id = 15 ) f on a.id = f.m_shop_id "
      select_sql << " where f1.date = '#{input_month}' and f2.id = 27 ) f on a.id = f.m_shop_id "
      
    elsif select_kbn == 2
      #洗車型実績表1
      #select_sql = "select a.*, b.*, c.*, d.*, e.*, f.*, g.*, h.*, i.*"
      select_sql = "select a.*, b.*, c.*, d.*, e.*, g.*, h.*, i.*"

      select_sql << " from (select id, shop_cd, shop_name,shop_ryaku from m_shops where deleted_flg = 0 and shop_kbn = 0) a"  
      
      select_sql << " left join (select id ,m_shop_id"
      select_sql <<              " from d_results where result_date = '#{input_ymd_e}') b on a.id = b.m_shop_id" 
      
      select_sql << " left join (select d_result_id,mo_gas,keiyu,touyu,kyuyu_purika,cb,type_err "
      select_sql <<            " from d_result_self_reports) c on b.id = c.d_result_id"
      
      select_sql << " left join (select d1.m_shop_id,"
      select_sql <<       "sum(d2.mo_gas) as r_mo_gas, sum(d2.keiyu) as r_keiyu,"
      select_sql <<       "sum(d2.touyu) as r_touyu, sum(d2.kyuyu_purika) as r_kyuyu_purika, "
      select_sql <<       "sum(d2.cb) as r_cb ,sum(d2.type_err) as r_type_err"
      select_sql <<            " from d_results d1"
      select_sql <<            " left join (select * from d_result_self_reports) d2 on d1.id = d2.d_result_id"
      select_sql <<            " where d1.result_date >= '#{input_ymd_s}' and d1.result_date <= '#{input_ymd_e}' "
      select_sql <<      " group by d1.m_shop_id"
      select_sql <<      " ) d on a.id = d.m_shop_id "
      
      
      #モーガス
      select_sql << " left join (select e1.m_shop_id,e1.aim_total as mo_gas_aim from d_aims e1"
      select_sql <<            " left join m_aims e2 on e1.m_aim_id = e2.id"
      select_sql << " where e1.date = '#{input_month}' and e2.id = 16 ) e on a.id = e.m_shop_id "
      #ハイオク
      #select_sql << " left join (select e1.m_shop_id,e1.aim_total as hg_aim from d_aims e1"
      #select_sql <<            " left join m_aims e2 on e1.m_aim_id = e2.id"
      #select_sql << " where e1.date = '#{input_month}' and e2.aim_code = 3 ) e on a.id = e.m_shop_id "
      #レギュラー
      #select_sql << " left join (select f1.m_shop_id,f1.aim_total as rg_aim from d_aims f1"
      #select_sql <<            " left join m_aims f2 on f1.m_aim_id = f2.id"
      #select_sql << " where f1.date = '#{input_month}' and f2.aim_code = 4 ) f on a.id = f.m_shop_id "
      #軽油
      select_sql << " left join (select g1.m_shop_id,g1.aim_total as keiyu_aim from d_aims g1"
      select_sql <<            " left join m_aims g2 on g1.m_aim_id = g2.id"
      select_sql << " where g1.date = '#{input_month}' and g2.id = 5 ) g on a.id = g.m_shop_id "
      #灯油
      select_sql << " left join (select h1.m_shop_id,h1.aim_total as touyu_aim from d_aims h1"
      select_sql <<            " left join m_aims h2 on h1.m_aim_id = h2.id"
      select_sql << " where h1.date = '#{input_month}' and h2.id = 6 ) h on a.id = h.m_shop_id "
      #ガソリンプリカ
      select_sql << " left join (select i1.m_shop_id,i1.aim_total as kyuyu_purika_aim from d_aims i1"
      select_sql <<            " left join m_aims i2 on i1.m_aim_id = i2.id"
      select_sql << " where i1.date = '#{input_month}' and i2.id = 7 ) i on a.id = i.m_shop_id "
      
    elsif select_kbn == 3
      #洗車型実績表2
      #select_sql = "select a.*, b.*, c.*, d.*, e.*, f.*"
      select_sql = "select a.*, b.*, c.*, d.*, e.*, f.*, g.*, h.*, i.*, j.*, k.*"
    
      select_sql << " from (select id, shop_cd, shop_name,shop_ryaku from m_shops where deleted_flg = 0 and shop_kbn = 0) a"  
      
      select_sql << " left join (select id ,m_shop_id"
      select_sql <<              " from d_results where result_date = '#{input_ymd_e}') b on a.id = b.m_shop_id" 
      
      select_sql << " left join (select d_result_id,sensya,sensya_purika_sale as sensya_purika,muton, "
      select_sql <<                   " sp_plus,taiyaw,sp,sc "
      select_sql <<            " from d_result_self_reports) c on b.id = c.d_result_id"
      
      select_sql << " left join (select d1.m_shop_id,"
      select_sql <<       "sum(d2.sensya) as r_sensya,"
      select_sql <<       "sum(d2.sensya_purika_sale) as r_sensya_purika, sum(d2.muton) as r_muton,"
      select_sql <<       "sum(d2.sp_plus) as r_sp_plus, sum(d2.taiyaw) as r_taiyaw,"
      select_sql <<       "sum(d2.sp) as r_sp, sum(d2.sc) as r_sc,"
      select_sql <<       "sum(d2.wash_item) as r_wash_item, sum(d2.game) as r_game,"
      select_sql <<       "sum(d2.health) as r_health, sum(d2.net) as r_net, "
      select_sql <<       "sum(d2.charge) as r_charge, sum(d2.ozone) as r_ozone"
      select_sql <<            " from d_results d1"
      select_sql <<            " left join (select * from d_result_self_reports) d2 on d1.id = d2.d_result_id"
      select_sql <<            " where d1.result_date >= '#{input_ymd_s}' and d1.result_date <= '#{input_ymd_e}' "
      select_sql <<      " group by d1.m_shop_id"
      select_sql <<      " ) d on a.id = d.m_shop_id "
      
      #洗車売上
      #select_sql << " left join (select e1.m_shop_id,e1.aim_value#{input_day} as sensya_aim from d_aims e1"
      select_sql << " left join (select e1.m_shop_id,e1.aim_total as sensya_aim from d_aims e1"
      select_sql <<            " left join m_aims e2 on e1.m_aim_id = e2.id"
      select_sql << " where e1.date = '#{input_month}' and e2.id = 2 ) e on a.id = e.m_shop_id "
      #洗車プリカ
      select_sql << " left join (select f1.m_shop_id,f1.aim_total as sensya_purika_aim from d_aims f1"
      select_sql <<            " left join m_aims f2 on f1.m_aim_id = f2.id"
      select_sql << " where f1.date = '#{input_month}' and f2.id = 8 ) f on a.id = f.m_shop_id "
      
      #ムートンパス
      select_sql << " left join (select g1.m_shop_id,g1.aim_total as muton_aim from d_aims g1"
      select_sql <<            " left join m_aims g2 on g1.m_aim_id = g2.id"
      select_sql << " where g1.date = '#{input_month}' and g2.id = 17 ) g on a.id = g.m_shop_id "
      #スピードパスプラス
      select_sql << " left join (select h1.m_shop_id,h1.aim_total as sp_plus_aim from d_aims h1"
      select_sql <<            " left join m_aims h2 on h1.m_aim_id = h2.id"
      select_sql << " where h1.date = '#{input_month}' and h2.id = 18 ) h on a.id = h.m_shop_id "
      #タイヤW
      select_sql << " left join (select i1.m_shop_id,i1.aim_total as taiyaw_aim from d_aims i1"
      select_sql <<            " left join m_aims i2 on i1.m_aim_id = i2.id"
      select_sql << " where i1.date = '#{input_month}' and i2.id = 19 ) i on a.id = i.m_shop_id "
      #SC
      select_sql << " left join (select j1.m_shop_id,j1.aim_total as sc_aim from d_aims j1"
      select_sql <<            " left join m_aims j2 on j1.m_aim_id = j2.id"
      select_sql << " where j1.date = '#{input_month}' and j2.id = 20 ) j on a.id = j.m_shop_id "
      #SP
      select_sql << " left join (select k1.m_shop_id,k1.aim_total as sp_aim from d_aims k1"
      select_sql <<            " left join m_aims k2 on k1.m_aim_id = k2.id"
      select_sql << " where k1.date = '#{input_month}' and k2.id = 21 ) k on a.id = k.m_shop_id "
      
    else
      
      select_sql = "select a.*, b.*, c.*, d.*"
    
      select_sql << " from (select id, shop_cd, shop_name,shop_ryaku from m_shops where deleted_flg = 0 and shop_kbn = 1) a "

      select_sql << " left join (select id ,m_shop_id"
      select_sql <<              " from d_results where result_date = '#{input_ymd_e}') b on a.id = b.m_shop_id" 
      
      select_sql << " left join (select d_result_id,mo_gas,keiyu,touyu,koua,buyou,tokusei, "
      #select_sql <<                   " sensya,koutin,taiya,arari"
      select_sql <<                   " sensya,koutin,taiya,trunc(arari,0) as arari"
      select_sql <<            " from d_result_reports) c on b.id = c.d_result_id"
      
      select_sql << " left join (select d1.m_shop_id,"
      select_sql <<       "sum(d2.mo_gas) as r_mo_gas, sum(d2.keiyu)   as r_keiyu,"
      select_sql <<       "sum(d2.touyu)  as r_touyu,  sum(d2.koua)    as r_koua,"
      select_sql <<       "sum(d2.buyou)  as r_buyou,  sum(d2.tokusei) as r_tokusei,"
      select_sql <<       "sum(d2.sensya) as r_sensya, sum(d2.koutin)  as r_koutin,"
      #select_sql <<       "sum(d2.taiya)  as r_taiya,  sum(d2.arari)   as r_arari"
      select_sql <<       "sum(d2.taiya)  as r_taiya,  sum(trunc(d2.arari,0))   as r_arari"
      select_sql <<            " from d_results d1"
      select_sql <<            " left join (select * from d_result_reports) d2 on d1.id = d2.d_result_id"
      select_sql <<            " where d1.result_date >= '#{input_ymd_s}' and d1.result_date <= '#{input_ymd_e}' "
      select_sql <<      " group by d1.m_shop_id"
      select_sql <<      " ) d on a.id = d.m_shop_id "
    end
    
    condition_sql = ""
    
    p select_sql
    
    return MShop.find_by_sql("#{select_sql} #{condition_sql} order by a.shop_cd" )
    
  end

end
