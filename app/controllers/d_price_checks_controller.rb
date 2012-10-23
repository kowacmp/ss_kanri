# -*- coding:utf-8 -*-
class DPriceChecksController < ApplicationController

  def index
    
    @m_shop_id = current_user.m_shop_id
    @d_price_check = get_d_price_check(@m_shop_id, Time.now.strftime("%Y%m%d"), Time.now.strftime("%H"))
    @d_price_check_last = DPriceCheck.find(:first, :conditions => ["m_shop_id=?", @m_shop_id], :order => "research_day desc, research_time desc")
    
  end

  # 入力エリア更新
  def update
    
    # 更新対象レコード取得
    d_price_check = DPriceCheck.find(:first, 
                                     :conditions => ["m_shop_id = ? and research_day = ? and research_time = ? ",
                                         params[:input_area][:m_shop_id],
                                         params[:input_area][:research_day].delete("/"),
                                         params[:input_area][:research_time]])
    
    if d_price_check.nil? then
      d_price_check = DPriceCheck.new
      d_price_check.created_user_id = current_user.id
    end

    # 更新値を設定
    values = params[:input_area]
    values.delete("id") # idは設定しない
    d_price_check.attributes = values
    d_price_check.research_day = d_price_check.research_day.to_s.delete("/")
    d_price_check.updated_user_id = current_user.id
    
    # 税抜を設定
    d_price_check.dis1_4_rg = get_zeinuki(d_price_check.dis1_3_rg)
    d_price_check.dis1_4_hg = get_zeinuki(d_price_check.dis1_3_hg)
    d_price_check.dis1_4_kg = get_zeinuki_kg(d_price_check.dis1_3_kg)
    d_price_check.dis1_4_tg = get_zeinuki(d_price_check.dis1_3_tg.to_f / 18)
    
    # 更新確定
    d_price_check.save!
    
    @m_shop_id = d_price_check.m_shop_id
    @d_price_check = d_price_check
    # response update.js.erb
    
  end
  
  # 参照エリア選択
  def select_d_price_check
    
    @d_price_check = DPriceCheck.find(params[:select_d_price_check][:id])
    
    # response select_d_price_check.js.erb
    
  end
  
  # 入力エリアコピー
  def input_copy
    
    @d_price_check = DPriceCheck.find(params[:copy_id])
    
    @d_price_check.id = nil # idは念のため消しておく
    @d_price_check.research_day  = params[:research_day].to_s.delete("/")
    @d_price_check.research_time = params[:research_time]
    
    # response input_copy.js.erb
    
  end 
  
  # 入力エリア編集
  def input_edit
    
    @d_price_check = DPriceCheck.find(params[:edit_id])
    
    # response input_edit.js.erb
    
  end
  
private

  def get_d_price_check(m_shop_id, research_day, research_time)

    d_price_check = DPriceCheck.find(:first, :conditions => ["m_shop_id = ? and research_day = ? and research_time = ?",
                                                               m_shop_id, 
                                                               research_day.delete("/"),
                                                               research_time])
                                                               

    if not(d_price_check.nil?) then
      d_price_check["research_day"] = research_day
      return d_price_check
    end

    m_price_chk_name = MPriceChkName.first() #レコードは1件のみ
    d_price_check = DPriceCheck.new
    
    d_price_check["m_shop_id"]     = m_shop_id
    d_price_check["research_day"]  = research_day
    d_price_check["research_time"] = research_time

    d_price_check["dis1_name"]   = m_price_chk_name["price1_disp1"]
    d_price_check["dis1_1_name"] = m_price_chk_name["price1_item1"]
    d_price_check["dis1_2_name"] = m_price_chk_name["price1_item2"]
    d_price_check["dis1_3_name"] = m_price_chk_name["price1_item3"]
    
    d_price_check["dis2_name"]   = m_price_chk_name["price2_disp1"]
    d_price_check["dis2_1_name"] = m_price_chk_name["price2_item1"]
    d_price_check["dis2_2_name"] = m_price_chk_name["price2_item2"]
    d_price_check["dis2_3_name"] = m_price_chk_name["price2_item3"]

    return d_price_check

  end

  # 税抜金額取得(レギュラー、ハイオク)
  def get_zeinuki(tanka)
    
    # 指定された単価が無い場合ZEROを返す
    if tanka.nil? then
      return 0
    end
    
    # 消費税率を取得する
    establish = Establish.find(1)
    
    # 税抜額を計算
    ret = tanka.to_f / (1.to_f + (establish.tax_rate.to_f / 100.to_f))
    
    # 小数点2位で四捨五入
    return ret.round(1)
    
  end
  
  # 税抜金額取得(軽油)
  def get_zeinuki_kg(tanka)
  
    # 軽油取引税を取得(消費税込)
    establish = Establish.find(1)
  
    # 税抜額を計算
    ret = tanka.to_f - establish.light_oil.to_f
    
    # 小数点2位で四捨五入
    return ret.round(1)
    
  end
  
end
