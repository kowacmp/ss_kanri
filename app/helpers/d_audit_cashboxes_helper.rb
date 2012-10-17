module DAuditCashboxesHelper
  
  # 1万円札金額取得
  def get_kingaku_10000paper(i)
    
    if @d_audit_cashbox["cashbox#{ i }_10000paper"].nil? or @d_audit_cashbox["cashbox#{ i }_10000paper"].blank? then
      maisu = 0
    else
      maisu = @d_audit_cashbox["cashbox#{ i }_10000paper"].to_i
    end
    
    return maisu * 10000
    
  end
  
  # 5千円札金額取得
  def get_kingaku_5000paper(i)
    
    if @d_audit_cashbox["cashbox#{ i }_5000paper"].nil? or @d_audit_cashbox["cashbox#{ i }_5000paper"].blank? then
      maisu = 0
    else
      maisu = @d_audit_cashbox["cashbox#{ i }_5000paper"].to_i
    end
    
    return maisu * 5000
    
  end
  
  # 2千円札金額取得
  def get_kingaku_2000paper(i)
    
    if @d_audit_cashbox["cashbox#{ i }_2000paper"].nil? or @d_audit_cashbox["cashbox#{ i }_2000paper"].blank? then
      maisu = 0
    else
      maisu = @d_audit_cashbox["cashbox#{ i }_2000paper"].to_i
    end
    
    return maisu * 2000
    
  end

  # 千円札金額取得
  def get_kingaku_1000paper(i)
    
    if @d_audit_cashbox["cashbox#{ i }_1000paper"].nil? or @d_audit_cashbox["cashbox#{ i }_1000paper"].blank? then
      maisu = 0
    else
      maisu = @d_audit_cashbox["cashbox#{ i }_1000paper"].to_i
    end
    
    return maisu * 1000
    
  end
  
  # 500円玉金額取得
  def get_kingaku_500coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_500coin_20"].nil? or @d_audit_cashbox["cashbox#{ i }_500coin_20"].blank? then
      maisu += 0
    else
      maisu += 20 * @d_audit_cashbox["cashbox#{ i }_500coin_20"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_500coin_50"].nil? or @d_audit_cashbox["cashbox#{ i }_500coin_50"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_500coin_50"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_500coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_500coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_500coin_mai"].to_i
    end
    
    return maisu * 500
    
  end
  
  # 100円玉金額取得
  def get_kingaku_100coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_100coin_hon"].nil? or @d_audit_cashbox["cashbox#{ i }_100coin_hon"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_100coin_hon"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_100coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_100coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_100coin_mai"].to_i
    end
    
    return maisu * 100
    
  end
  
  # 50円玉金額取得
  def get_kingaku_50coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_50coin_hon"].nil? or @d_audit_cashbox["cashbox#{ i }_50coin_hon"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_50coin_hon"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_50coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_50coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_50coin_mai"].to_i
    end
    
    return maisu * 50
    
  end
 
  # 10円玉金額取得
  def get_kingaku_10coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_10coin_hon"].nil? or @d_audit_cashbox["cashbox#{ i }_10coin_hon"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_10coin_hon"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_10coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_10coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_10coin_mai"].to_i
    end
    
    return maisu * 10
    
  end
  
  # 5円玉金額取得
  def get_kingaku_5coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_5coin_hon"].nil? or @d_audit_cashbox["cashbox#{ i }_5coin_hon"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_5coin_hon"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_5coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_5coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_5coin_mai"].to_i
    end
    
    return maisu * 5
    
  end
  
  # 1円玉金額取得
  def get_kingaku_1coin(i)
    
    maisu = 0
    
    if @d_audit_cashbox["cashbox#{ i }_1coin_hon"].nil? or @d_audit_cashbox["cashbox#{ i }_1coin_hon"].blank? then
      maisu += 0
    else
      maisu += 50 * @d_audit_cashbox["cashbox#{ i }_1coin_hon"].to_i
    end
    
    if @d_audit_cashbox["cashbox#{ i }_1coin_mai"].nil? or @d_audit_cashbox["cashbox#{ i }_1coin_mai"].blank? then
      maisu += 0
    else
      maisu += 1 * @d_audit_cashbox["cashbox#{ i }_1coin_mai"].to_i
    end
    
    return maisu * 1
    
  end
  
  # 金額合計
  def get_kingaku(i)
  
    gokei  = 0
    gokei += get_kingaku_10000paper(i)
    gokei += get_kingaku_5000paper(i)    
    gokei += get_kingaku_2000paper(i)
    gokei += get_kingaku_1000paper(i)
    gokei += get_kingaku_500coin(i)
    gokei += get_kingaku_100coin(i)
    gokei += get_kingaku_50coin(i)
    gokei += get_kingaku_10coin(i)
    gokei += get_kingaku_5coin(i)
    gokei += get_kingaku_1coin(i)
    
    # INSERT 2012.10.17 予備金額を合計金額に加算
    gokei += nvl(@d_audit_cashbox["cashbox#{ i }_yobi"], 0).to_i 
    
    return gokei
    
  end
  
  # 過不足
  def get_kabusoku(i)
    
    # UPDATE 2012.10.17 合計金額 - 指定額
    #gokei = 0
    #
    #if @d_audit_cashbox["cashbox#{ i }"].nil? or @d_audit_cashbox["cashbox#{ i }"].blank? then
    #  gokei += 0
    #else
    #  gokei += @d_audit_cashbox["cashbox#{ i }"].to_i
    #end
    #
    #gokei -= get_kingaku(i)
    
    gokei  = get_kingaku(i)
    gokei -= nvl(@d_audit_cashbox["cashbox#{ i }"], 0).to_i
    
    return gokei
    
  end
  
  # 立替未処理計
  def get_tatekae_kei(i)
 
    gokei = 0
    
    for j in 1..5
      if @d_audit_cashbox["cashbox#{ i }_still#{ j }"].nil? or @d_audit_cashbox["cashbox#{ i }_still#{ j }"].blank? then
        gokei += 0
      else
        gokei += @d_audit_cashbox["cashbox#{ i }_still#{ j }"].to_i
      end
    end 
    
    return gokei
 
  end
 
  # 実過不足金
  def get_jitu_kabusoku(i)
    
    return get_kabusoku(i) - get_tatekae_kei(i)

  end

  # 過不足金2
  def get_kabusoku2(i)
    
    gokei = 0
    
    if @d_audit_cashbox["sum#{ i }_cashbox"].nil? or @d_audit_cashbox["sum#{ i }_cashbox"].blank? then
      gokei += 0
    else
      gokei += @d_audit_cashbox["sum#{ i }_cashbox"].to_i
    end
    
    if @d_audit_cashbox["sum#{ i }_money"].nil? or @d_audit_cashbox["sum#{ i }_money"].blank? then
      gokei -= 0  
    else
      gokei -= @d_audit_cashbox["sum#{ i }_money"].to_i
    end 
   
    return gokei    
     
  end

  # 立替金計2
  def get_tatekae_kei2(i)
 
    gokei = 0
    
    for j in 1..5
      if @d_audit_cashbox["sum#{ i }_still#{ j }"].nil? or @d_audit_cashbox["sum#{ i }_still#{ j }"].blank? then
        gokei += 0
      else
        gokei += @d_audit_cashbox["sum#{ i }_still#{ j }"].to_i
      end
    end 
    
    return gokei
 
  end

  # 実過不足2
  def get_jitu_kabusoku2(i)
    
    return get_kabusoku2(i) - get_tatekae_kei2(i)

  end

  # 金庫合計指定(固定)額 
  def get_kinko_gokei3()

    gokei = 0
    
    for i in 1..6
      gokei += nvl(@d_audit_cashbox["cashbox#{ i }"], 0).to_i
    end

    for i in 1..7
      gokei += nvl(@d_audit_cashbox["sum#{ i }_cashbox"], 0).to_i
    end

    return gokei

  end

  # 実有高
  def get_jitu_aridaka_gokei3

    gokei = 0
    
    for i in 1..6
      gokei += get_kingaku(i)
    end 

    for i in 1..7 
      gokei += nvl(@d_audit_cashbox["sum#{ i }_money"], 0).to_i
    end

    return gokei

  end
  
  # 過不足
  def get_kabusoku_gokei3
    
    return get_jitu_aridaka_gokei3 - get_kinko_gokei3 
    
  end

  # 釣銭固定額読込
  def get_m_fix(m_shop_id, cd, month)
    
    m_fix_item = MFixItem.find(:first, :conditions => ["fix_item_cd=?", cd])
    if m_fix_item.nil? then
      return nil
    end
    
    m_fix_money = MFixMoney.find(:first, :conditions => ["m_shop_id=? and start_month <= ? and end_month >= ?", m_shop_id, month, month])
    if m_fix_money.nil? then
      return nil
    end

    for i in 1..13 
      if m_fix_money["m_fix_item_id#{i}"] == m_fix_item.id then
        if nvl(m_fix_money["fix_money#{i}"], 0) > 0 then
          return [m_fix_item.fix_item_ryaku, m_fix_money["fix_money#{i}"]]
        else
          return nil
        end
      end
    end
    
    return nil
    
  end
 
  def nvl(value, zero)
    if value.to_s == "" then
      return zero
    else
      return value
    end
  end
 
end
