module DResultsHelper
  def m_oiletc_sql(d_result, oiletc_group)
    sql = "select m.id, m.oiletc_name, m.oiletc_tani, d.pos1_data, d.pos2_data, d.pos3_data, d.pos1_data + d.pos2_data + d.pos3_data as pos_total"
    sql << " from m_oiletcs m left join d_result_oiletcs d"
    sql << "   on (m.id = d.m_oiletc_id "
    if d_result.blank?
      sql << " and d.d_result_id is null)"
    else
      sql << " and d.d_result_id = #{d_result.id})"  
    end
    
    sql << " where m.oiletc_group = #{oiletc_group} and m.deleted_flg = 0 order by m.oiletc_cd" 

    return sql  
  end
  
  def syukei_data(d_result, select_date)
    p "syukei_data   syukei_data   syukei_data"
    if d_result.blank?
      now = Time.parse(select_date)
      result_date = Time.parse(select_date).strftime("%Y%m%d")
    else  
      now = Time.parse(d_result.result_date)
      result_date = d_result.result_date
    end
    
    @syukei_reserves = Array.new
    
    for i in 0..4
      ymd = now + i.months
      start_ymd = ymd.strftime("%Y%m") + "01"
      end_ymd = ymd.strftime("%Y%m") + "31"
      
      if d_result.blank?
        nikkei_count = 0
      else  
        #日計
        nikkei_count = DResultReserve.count(:conditions => ["d_result_id = ? and get_date between ? and ?",
                                                            d_result.id, start_ymd, end_ymd])
      end
             
      #累計                                                        
      sql = "select count(*) from d_result_reserves r, d_results d"
      sql << " where r.d_result_id = d.id and d.result_date <= '#{result_date}'"
      sql << "   and r.get_date between '#{start_ymd}' and '#{end_ymd}'"
    
      ruikei = DResultReserve.find_by_sql(sql) 
      

      @syukei_reserves[i] = Hash::new
      @syukei_reserves[i][:month] = ymd.strftime("%m")
      @syukei_reserves[i][:nikkei] = nikkei_count
      @syukei_reserves[i][:ruikei] = ruikei[0].count
    end    
  end
  
  def oil_betu_meter_sql(m_shop_id, d_result_id)
    sql = "select t.m_oil_id, SUM(meter) from d_result_meters d, m_meters m, m_tanks t"
    sql << " where d.m_meter_id = m.id and m.m_tank_id = t.id"
    sql << "   and t.m_shop_id = #{m_shop_id} and d.d_result_id = #{d_result_id}"
    sql << "   and m.deleted_flg = 0 and t.deleted_flg = 0 group by t.m_oil_id order by t.m_oil_id"
    
    return sql
  end
  
  def oil_betu_result_tank_sql(d_result_id) 
    sql = "select t.m_oil_id, SUM(receive) r_sum, SUM(stock) s_sum"
    sql << " from d_result_tanks dt, m_tanks t"
    sql << " where dt.d_result_id = #{d_result_id} and t.deleted_flg = 0"
    sql << "   and dt.m_tank_id = t.id group by t.m_oil_id order by t.m_oil_id"
    
    return sql
  end
  
  def tank_volume_sql(m_shop_id)
    sql = "select m_oil_id, SUM(volume) from m_tanks"
    sql << " where deleted_flg = 0 and m_shop_id = #{m_shop_id} group by m_oil_id order by m_oil_id"    
  
    return sql
  end
  
  def meter_total(d_result_id)
    #油種別集計----------------------------------
    d_result = DResult.find(d_result_id)
    today = Time.parse(d_result.result_date)
    yesterday = (today - 1.days).strftime("%Y%m%d")
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         d_result.m_shop_id, yesterday])
    
    #タンク容量集計
    sql = tank_volume_sql(d_result.m_shop_id)
    m_tanks = MTank.find_by_sql(sql)
        
    volumes = Array::new                 
    m_tanks.each do |m_tank|
      volumes[m_tank.m_oil_id.to_i] = Hash::new
      volumes[m_tank.m_oil_id.to_i][:sum_volume] = m_tank.sum
    end
    
    
    #メーター進み
    m_sql = oil_betu_meter_sql(d_result.m_shop_id, d_result.id)
    d_result_meters = DResultMeter.find_by_sql(m_sql)
    unless old_d_result.blank?
      old_m_sql = oil_betu_meter_sql(d_result.m_shop_id, old_d_result.id)                           
      old_d_result_meters = DResultMeter.find_by_sql(old_m_sql)
    end
    
    if d_result_meters.blank?
      sql = tank_volume_sql(current_user.m_shop_id)
      m_tanks = MTank.find_by_sql(sql)
        
      volumes = Array::new                 
      m_tanks.each do |m_tank|
        volumes[m_tank.m_oil_id.to_i] = Hash::new
        volumes[m_tank.m_oil_id.to_i][:sum_volume] = m_tank.sum
      end
      
      m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')

      @meters = Array::new
      m_oils.each_with_index do |m_oil, idx|
        @meters[idx] = Hash::new
        @meters[idx][:oil_name] = m_oil.oil_name
        @meters[idx][:volume] = volumes[m_oil.id][:sum_volume]
        @meters[idx][:meter_susumi] = ""
        @meters[idx][:receive] = ""
        @meters[idx][:stock] = ""
        @meters[idx][:tank_kabusoku] = ""
        @meters[idx][:meter_kabusoku] = ""  
      end
    else  
      result_meters = Array::new
    
      if old_d_result.blank?
        d_result_meters.each do |d_result_meter|
          result_meters[d_result_meter.m_oil_id.to_i] = Hash::new
          result_meters[d_result_meter.m_oil_id.to_i][:meter] = d_result_meter.sum
          result_meters[d_result_meter.m_oil_id.to_i][:old_meter] = 0
        end            
      else
        d_result_meters.each do |d_result_meter| 
          result_meters[d_result_meter.m_oil_id.to_i] = Hash::new
          result_meters[d_result_meter.m_oil_id.to_i][:meter] = d_result_meter.sum
        end         
        old_d_result_meters.each do |old_d_result_meter|
          result_meters[old_d_result_meter.m_oil_id.to_i][:old_meter] = old_d_result_meter.sum
        end
      end
          
          
      #地下タンク過不足、仕入、在庫
      dt_sql = oil_betu_result_tank_sql(d_result.id)      
      d_result_tanks = DResultMeter.find_by_sql(dt_sql)
      unless old_d_result.blank?
        old_dt_sql = oil_betu_result_tank_sql(old_d_result.id)                            
        old_d_result_tanks = DResultMeter.find_by_sql(old_dt_sql)
      end
    
      result_tanks = Array::new
    
      if old_d_result.blank?
        d_result_tanks.each do |d_result_tank|
          result_tanks[d_result_tank.m_oil_id.to_i] = Hash::new
          result_tanks[d_result_tank.m_oil_id.to_i][:tank_stock] = d_result_tank.s_sum
          result_tanks[d_result_tank.m_oil_id.to_i][:tank_receive] = d_result_tank.r_sum
          result_tanks[d_result_tank.m_oil_id.to_i][:old_tank_stock] = 0
        end      
      else                   
        d_result_tanks.each do |d_result_tank|
          result_tanks[d_result_tank.m_oil_id.to_i] = Hash::new
          result_tanks[d_result_tank.m_oil_id.to_i][:tank_stock] = d_result_tank.s_sum
          result_tanks[d_result_tank.m_oil_id.to_i][:tank_receive] = d_result_tank.r_sum
        end         
        old_d_result_tanks.each do |old_d_result_tank|
          result_tanks[old_d_result_tank.m_oil_id.to_i][:old_tank_stock] = old_d_result_tank.s_sum
        end
      end    
         
         
      @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')

      @meters = Array::new
      @m_oils.each_with_index do |m_oil, idx|
        @meters[idx] = Hash::new
        @meters[idx][:oil_name] = m_oil.oil_name
        @meters[idx][:volume] = volumes[m_oil.id][:sum_volume]
        @meters[idx][:meter_susumi] = result_meters[m_oil.id][:meter].to_i - result_meters[m_oil.id][:old_meter].to_i
        @meters[idx][:receive] = result_tanks[m_oil.id][:tank_receive]
        @meters[idx][:stock] = result_tanks[m_oil.id][:tank_stock]
        @meters[idx][:tank_kabusoku] = result_tanks[m_oil.id][:old_tank_stock].to_i + @meters[idx][:receive].to_i - @meters[idx][:stock].to_i - @meters[idx][:meter_susumi].to_i  
        @meters[idx][:meter_kabusoku] = @meters[idx][:meter_susumi] - session[:m_oil_totals][m_oil.id][:total]
      end
    end #d_result_meters.blank?   
  end

  def yume_sql(d_result_id)
    sql = "select d.* from d_result_oiletcs d, m_oiletcs m"
    sql << " where d.m_oiletc_id = m.id and m.deleted_flg = 0" 
    sql << "   and oiletc_group = 2 and d.d_result_id = #{d_result_id} order by pos1_data" 

    return sql    
  end
  
  def tank_betu_total(d_result_id)
    cr_sql = "select t.tank_no, o.oil_name, cr.* from m_oils o, m_tanks t"
    cr_sql << " left join d_tank_compute_reports cr on (cr.m_tank_id = t.id and cr.d_result_id = #{d_result_id})"
    cr_sql << " where t.m_oil_id = o.id and t.deleted_flg = 0 and o.deleted_flg = 0"
    cr_sql << "   and t.m_shop_id = #{current_user.m_shop_id} order by t.tank_no"
    @d_tank_compute_reports = DTankComputeReport.find_by_sql(cr_sql)       
  end
end
