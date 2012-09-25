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
    if params[:shop_kbn] == nil or params[:shop_kbn] == ""
      @shop_kbn = 0
    else
      @shop_kbn = params[:shop_kbn]
    end

    @m_shops = MShop.where('shop_cd <> 999999 and shop_kbn = ?',@shop_kbn).order('shop_cd')
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
    str = "店舗".tosjis + ",日付".tosjis
    
    @m_shops = MShop.where('shop_cd <> 999999 and shop_kbn = ?',@shop_kbn).order('shop_cd')
    @m_oils = MOil.where('deleted_flg = 0').order('oil_cd')

    CSV.generate(output = "") do |csv|
      
      #ヘッダ処理
      @m_oils.each do |oil|
        str = str + "," + oil.oil_name.tosjis
      end
      csv << str.split(/,/)
      
      #データ処理
      @m_shops.each do |shop|
        for i in @from_ymd_s.to_i..@to_ymd_s.to_i
            str = shop.shop_name.tosjis + "," + "#{i.to_s[0,4]}/#{i.to_s[4,2]}/#{i.to_s[6,2]}"
             @m_oils.each do |oil|
               str = str + "," + get_sum_stock(i.to_s,i.to_s,shop.id,oil.id).to_s
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
