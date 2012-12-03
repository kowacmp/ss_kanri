module DDutyOutputsHelper

#明細行計算項目

  # 日勤金額取得
  def get_general_money(d_duty)
    return (d_duty.general_price.to_i * d_duty.day_work_time.to_f).to_i
  end
  
  # 残業金額取得
  def get_general_overtime_money(d_duty)
    return (d_duty.general_overtime.to_i * d_duty.day_over_time.to_f).to_i
  end
  
  # 深勤金額取得
  def get_night_money(d_duty)
    return (d_duty.night_price.to_i * d_duty.night_work_time.to_f).to_i
  end
  
  # 深残業金額取得
  def get_night_overtime_money(d_duty)
    return (d_duty.night_overtime.to_i * d_duty.night_over_time.to_f).to_i
  end
  
  # 支払金額
  def get_shiharai_gak (d_duty)
  
    ret = 0
    
    ret += get_general_money(d_duty)
    ret += get_general_overtime_money(d_duty)
    ret += get_night_money(d_duty)
    ret += get_night_overtime_money(d_duty)
    
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

  # 日勤時間取得(合計)
  def get_day_work_times(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.day_work_time.to_f
    end
    return ret
  end
  
  # 日勤金額取得(合計)
  def get_general_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += get_general_money(d_duty)
    end
    return ret
  end
  
  # 残業時間取得(合計)
  def get_day_over_times(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.day_over_time.to_f
    end
    return ret
  end
  
  # 残業金額取得(合計)
  def get_general_overtime_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += get_general_overtime_money(d_duty)
    end
    return ret
  end
  
  # 深勤時間取得(合計)
  def get_night_work_times(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.night_work_time.to_f
    end
    return ret
  end
  
  # 深勤金額取得(合計)
  def get_night_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += get_night_money(d_duty)
    end
    return ret
  end
  
  # 深勤時間取得(合計)
  def get_night_overtimes(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.night_over_time.to_f
    end
    return ret
  end
  
  # 深勤時間金額取得(合計)
  def get_night_overtime_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += get_night_overtime_money(d_duty)
    end
    return ret
  end
  
  # 時間1金額取得(合計)
  def get_time1_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time1_money.to_i
    end
    return ret
  end
  
  # 時間2金額取得(合計)
  def get_time2_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time2_money.to_i
    end
    return ret
  end
  
  # 時間3金額取得(合計)
  def get_time3_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time3_money.to_i
    end
    return ret
  end
  
  # 時間4金額取得(合計)
  def get_time4_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time4_money.to_i
    end
    return ret
  end
  
  # 時間5金額取得(合計)
  def get_time5_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time5_money.to_i
    end
    return ret
  end
  
  # 時間6金額取得(合計)
  def get_time6_moneys(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.time6_money.to_i
    end
    return ret
  end
  
  # 日数1金額取得(合計)
  def get_day1_money(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.day1_money.to_i
    end
    return ret
  end
  
  # 日数2金額取得(合計)
  def get_day2_money(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.day2_money.to_i
    end
    return ret
  end
  
  # 手当1金額取得(合計)
  def get_moneys1(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.get_money1.to_i
    end
    return ret
  end
  
  # 手当2金額取得(合計)
  def get_moneys2(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.get_money2.to_i
    end
    return ret
  end
  
  # 手当3金額取得(合計)
  def get_moneys3(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.get_money3.to_i
    end
    return ret
  end
  
  # 手当4金額取得(合計)
  def get_moneys4(d_duties)
    ret = 0
    for d_duty in d_duties
      ret += d_duty.get_money4.to_i
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

