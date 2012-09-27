# -*- coding:utf-8 -*-
include DResultTankListsHelper

class DResultTankListsController < ApplicationController

  def index
    search
  end

  def search
    if params[:from_ymd] == nil or params[:from_ymd] == ""
      @from_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @from_ymd = params[:from_ymd]
    end
    if params[:to_ymd] == nil or params[:to_ymd] == ""
      @to_ymd   = Time.now.strftime("%Y/%m/%d")
    else
      @to_ymd   = params[:to_ymd]     
    end
    @shop_kbn = params[:shop_kbn]
    
    @m_shops = get_shops1(@shop_kbn)

    @m_oils = MOil.where('deleted_flg = 0').order('oil_cd')
 
    @from_ymd_s = @from_ymd.delete("/")
    @to_ymd_s   = @to_ymd.delete("/")

  end
  
  def csv
    require 'kconv'
    require 'csv'
    
    @from_ymd = params[:from_ymd]
    @to_ymd = params[:to_ymd]
    @shop_kbn = params[:shop_kbn]
    @from_ymd_s = @from_ymd.delete("/")
    @to_ymd_s   = @to_ymd.delete("/")
    str = "店舗コード".tosjis + ",店舗".tosjis + ",日付".tosjis
    
    @m_shops = get_shops(@shop_kbn)
    @m_oils = MOil.where('deleted_flg = 0').order('oil_cd')

    CSV.generate(output = "") do |csv|
      
      #ヘッダ処理
      @m_oils.each do |oil|
        str = str + "," + oil.oil_name.tosjis
      end
      csv << str.split(/,/)
      
      #データ処理
      # 2012/09/26 月跨り不具合修正 oda 
      @num = Date.parse(@to_ymd_s) - Date.parse(@from_ymd_s)
      @m_shops.each do |shop|
        #for i in @from_ymd_s.to_i..@to_numymd_s.to_i
        for i in 0..@num.to_i
            #str = shop.shop_cd.to_s + "," + shop.shop_name.tosjis + "," + "#{i.to_s[0,4]}/#{i.to_s[4,2]}/#{i.to_s[6,2]}"
            #str = shop.shop_cd.to_s + "," + shop.shop_name.tosjis + "," + "#{i.to_s[0,4]}/#{i.to_s[4,2]}/#{i.to_s[6,2]}"
            str = shop.shop_cd.to_s + "," + shop.shop_name.tosjis + "," + (Date.parse(@from_ymd_s) + i).strftime("%Y/%m/%d")
             @m_oils.each do |oil|
               #str = str + "," + get_sum_stock(i.to_s,i.to_s,shop.id,oil.id).to_s
               str = str + "," + get_sum_stock((@from_ymd_s.to_i + i).to_s,(@from_ymd_s.to_i + i).to_s,shop.id,oil.id).to_s
             end
           csv << str.split(/,/)        
        end #for
       end #@m_shops.each
    end # CSV
    

    file_name = "燃料油在庫データ_#{@from_ymd_s}_#{@to_ymd_s}.csv"
    ua = request.env["HTTP_USER_AGENT"]
    file_name = URI.encode(file_name) if ua.include?('MSIE') #InternetExproler対応
        
    send_data(output,
              :type => 'text/csv',
              :filename => file_name)
  end

end
