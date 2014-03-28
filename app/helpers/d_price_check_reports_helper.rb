module DPriceCheckReportsHelper
  def price_888_print(value)
    #表示価格が888の場合表示しない
    if value.to_i == 888
      return ""
    else
      return value
    end
  end
  
  # 税抜金額取得(レギュラー、ハイオク)
  def get_zeinuki_print(tanka)
    
    # 指定された単価が無い場合空白を返す
    if tanka.to_f == 0 then
      return ""
    end
    
    # 消費税率を取得する
    establish = Establish.find(1)
    
    # 税抜額を計算
    ret = tanka.to_f / establish.tax_rate.to_f
    
    # 小数点2位で四捨五入
    return ret.round(1)
    
  end
  
  # 税抜金額取得(軽油)
  def get_zeinuki_kg_print(tanka)
  
    # 指定された単価が無い場合空白を返す
    if tanka.to_f == 0 then
      return ""
    end
  
    # 軽油取引税を取得(消費税込)
    establish = Establish.find(1)
  
    ## 税抜額を計算
    #ret = tanka.to_f - establish.light_oil.to_f
    # 20140328 修正
    # 税抜額を計算 (( 入力単価 - 軽油取引税 ) ÷ 消費税率) + 軽油取引税
    ret = ((tanka.to_f - establish.light_oil.to_f) / establish.tax_rate.to_f) + establish.light_oil.to_f
    
    # 小数点2位で四捨五入
    return ret.round(1)
    
  end
  
  # 税込金額取得
  def get_zeikomi_print(tanka)
    
    # 指定された単価が無い場合空白を返す
    if tanka.to_f == 0 then
      return ""
    end
    
    # 消費税率を取得する
    establish = Establish.find(1)
    
    # 税込額を計算
    ret = tanka.to_f * establish.tax_rate.to_f
    
    # 小数点1位で四捨五入
    return ret.round(0)
    
  end
  
  # 小数点1桁まで表示,ただし.0の場合は小数点以下を表示しない
  def format_minus_gak(par)
    
    ret = sprintf("%.1f", par.to_f)
    
    if /.0$/ =~ ret
      ret = sprintf("%.0f", par.to_f)
    end
    
    return ret
    
  end
  
end
