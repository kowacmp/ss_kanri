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

end
