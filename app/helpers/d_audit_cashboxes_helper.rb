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
    
    return gokei
    
  end
  
  # 過不足
  def get_kabusoku(i)
    
    gokei = 0
    
    if @d_audit_cashbox["cashbox#{ i }"].nil? or @d_audit_cashbox["cashbox#{ i }"].blank? then
      gokei += 0
    else
      gokei += @d_audit_cashbox["cashbox#{ i }"].to_i
    end
    
    gokei -= get_kingaku(i)
    
    return gokei
    
  end
 
end
