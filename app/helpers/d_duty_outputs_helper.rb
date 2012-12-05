module DDutyOutputsHelper

#明細行計算項目
  
  # 単価取得
  def get_tanka(money, time) 
    if time.to_f == 0 
      return nil
    else
      return (money.to_f / time.to_f).to_i #絶対に整数になる模様
    end
  end
  
  # 支払金額
  def get_shiharai_gak (d_duty)
  
    ret = 0
    
    ret += d_duty.day_work_money.to_i
    ret += d_duty.day_over_money.to_i
    ret += d_duty.night_work_money.to_i
    ret += d_duty.night_over_money.to_i
    
    for i in 1..6
      ret += d_duty["time#{ i }_money"].to_i
    end
    
    for i in 1..2
      ret += d_duty["day#{ i }_money"].to_i
    end
    
    for i in 1..4
      ret += d_duty["get_money#{ i }"].to_i
    end
    
    return ret
    
  end
  
#合計行計算項目

  # 指定項目合計(整数)
  def get_sum_i(d_duties, col)
    ret = 0
    for d_duty in d_duties
      ret += d_duty[col].to_i
    end
    return ret
  end
  
  # 指定項目合計(小数点)
  def get_sum_d(d_duties, col)
    ret = BigDecimal.new(0)
    for d_duty in d_duties
      if not(d_duty[col].blank?) 
        ret += BigDecimal.new(d_duty[col])
      end
    end
    return ret
  end
  
  # 支払額(合計)
  def get_shiharai_gaks(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += get_shiharai_gak(d_duty)
    end
    return ret
  end
  
end

