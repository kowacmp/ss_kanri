module DResultsHelper
  def old_result_date(result_date)
    today = Time.parse(result_date)
    day = today.strftime("%d")
    yesterday = (today - 1.days).strftime("%Y%m%d")    
    
    return day, yesterday
  end
  
  def m_oiletc_sql(d_result, oiletc_group)
    sql = "select m.id, m.oiletc_name, m.oiletc_tani, c.code_name,"
    sql << "      CASE m.oiletc_tani WHEN 6 THEN d.pos1_data"
    sql << "                         ELSE trunc(d.pos1_data, 0)"
    sql << "      END pos1_data,"
    sql << "      CASE m.oiletc_tani WHEN 6 THEN d.pos2_data"
    sql << "                         ELSE trunc(d.pos2_data, 0)"
    sql << "      END pos2_data,"
    sql << "      CASE m.oiletc_tani WHEN 6 THEN d.pos3_data"
    sql << "                         ELSE trunc(d.pos3_data, 0)"
    sql << "      END pos3_data,"
    sql << "      CASE m.oiletc_tani WHEN 6 THEN COALESCE(d.pos1_data, 0) + COALESCE(d.pos2_data, 0) + COALESCE(d.pos3_data, 0)"
    sql << "                         ELSE trunc(COALESCE(d.pos1_data, 0) + COALESCE(d.pos2_data, 0) + COALESCE(d.pos3_data, 0), 0)"
    sql << "      END pos_total"
    
    sql << " from m_oiletcs m left join d_result_oiletcs d"
    sql << "   on (m.id = d.m_oiletc_id "
    if d_result.blank?
      sql << " and d.d_result_id is null)"
    else
      sql << " and d.d_result_id = #{d_result.id})"  
    end
    
    sql << " left join m_codes c on (to_number(c.code, '999999999') = m.oiletc_tani and c.kbn = 'tani')"
    sql << " where m.oiletc_group = #{oiletc_group} and m.deleted_flg = 0 order by m.oiletc_cd" 

    return sql  
  end
  
  def syukei_data(d_result, select_date, m_shop_id)
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
      sql << " where r.d_result_id = d.id and d.m_shop_id = #{m_shop_id}"
      sql << " and d.result_date <= '#{result_date}'"
      sql << " and r.get_date between '#{start_ymd}' and '#{end_ymd}'"
    
      ruikei = DResultReserve.count_by_sql(sql) 

      @syukei_reserves[i] = Hash::new
      @syukei_reserves[i][:month] = ymd.strftime("%m")
      @syukei_reserves[i][:nikkei] = nikkei_count
      @syukei_reserves[i][:ruikei] = ruikei
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
    day, yesterday = old_result_date(d_result.result_date)
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
    
    if old_d_result.blank?
      old_d_result_id = 0
    else  
      old_d_result_id = old_d_result.id
    end
    
    
    result_meter = DResultMeter.find(:first, :conditions => ["d_result_id = ?", d_result.id])
    if result_meter.blank?
    #if d_result_meters.blank?  
      sql = tank_volume_sql(d_result.m_shop_id)
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
      m_sql = "select t.m_oil_id, dm.meter, COALESCE(old_dm.meter, 0) old_meter"
      m_sql << " from m_meters m"
      m_sql << " left join m_tanks t on (m.m_tank_id = t.id)"
      m_sql << " left join d_result_meters dm on (dm.m_meter_id = m.id and dm.d_result_id = #{d_result.id})"
      m_sql << " left join d_result_meters old_dm on (old_dm.m_meter_id = m.id and old_dm.d_result_id = #{old_d_result_id})"
      m_sql << " where m.deleted_flg = 0 and t.deleted_flg = 0  and t.m_shop_id = #{d_result.m_shop_id}"       
      m_sql << " order by t.m_oil_id, m.pos_class, m.number"
      d_result_meters = DResultMeter.find_by_sql(m_sql)
      
      result_meters = Array::new
      @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')
      
      @m_oils.each do |m_oil|
        result_meters[m_oil.id.to_i] = Hash::new
        result_meters[m_oil.id.to_i][:meter] = 0
        result_meters[m_oil.id.to_i][:old_meter] = 0
      end  

      d_result_meters.each do |d_result_meter| 
        result_meters[d_result_meter.m_oil_id.to_i][:meter] += d_result_meter.meter.to_i
        if d_result_meter.meter.to_i > d_result_meter.old_meter.to_i
          result_meters[d_result_meter.m_oil_id.to_i][:old_meter] += d_result_meter.old_meter.to_i        
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
         
      @meters = Array::new
      @m_oils.each_with_index do |m_oil, idx|
        @meters[idx] = Hash::new
        @meters[idx][:oil_name] = m_oil.oil_name
        @meters[idx][:volume] = volumes[m_oil.id][:sum_volume]
        @meters[idx][:meter_susumi] = result_meters[m_oil.id][:meter].to_i - result_meters[m_oil.id][:old_meter].to_i
        @meters[idx][:receive] = result_tanks[m_oil.id][:tank_receive]
        @meters[idx][:stock] = result_tanks[m_oil.id][:tank_stock]
        @meters[idx][:tank_kabusoku] = result_tanks[m_oil.id][:old_tank_stock].to_i + @meters[idx][:receive].to_i - @meters[idx][:stock].to_i - @meters[idx][:meter_susumi].to_i  
        @meters[idx][:meter_kabusoku] = @meters[idx][:meter_susumi].to_i - session[:m_oil_totals][m_oil.id][:total].to_i
      end
    end #d_result_meters.blank?   
  end

  def yume_sql(d_result_id)
    sql = "select d.* from d_result_oiletcs d, m_oiletcs m"
    sql << " where d.m_oiletc_id = m.id and m.deleted_flg = 0" 
    sql << "   and oiletc_group = 2 and d.d_result_id = #{d_result_id} order by pos1_data" 

    return sql    
  end
  
  def tank_betu_total(d_result_id, m_shop_id)
    limit = Establish.find(:first).limit
    cr_sql = "select t.tank_no, t.tank_union_no, t.volume, trunc((t.volume * 1000) * #{limit}, 0) as oil_limit, o.oil_name, cr.* from m_oils o, m_tanks t"
    cr_sql << " left join d_tank_compute_reports cr on (cr.m_tank_id = t.id and cr.d_result_id = #{d_result_id})"
    cr_sql << " where t.m_oil_id = o.id and t.deleted_flg = 0 and o.deleted_flg = 0"
    cr_sql << "   and t.m_shop_id = #{m_shop_id} order by t.tank_union_no, t.tank_no"

    d_tank_compute_reports = DTankComputeReport.find_by_sql(cr_sql)
    idx, union_no = 0,0
    @d_tank_compute_reports = Array::new
    
    d_tank_compute_reports.each_with_index do |cr, index|
      if union_no != cr.tank_union_no
        idx += 1 unless index == 0
        union_no = cr.tank_union_no

        @d_tank_compute_reports[idx] = Hash::new
        @d_tank_compute_reports[idx][:tank_no] = cr.tank_no
        @d_tank_compute_reports[idx][:tank_union_no] = union_no
        @d_tank_compute_reports[idx][:oil_name] = cr.oil_name
        @d_tank_compute_reports[idx][:volume] = cr.volume
        @d_tank_compute_reports[idx][:oil_limit] = cr.oil_limit.to_i
        @d_tank_compute_reports[idx][:before_stock] = cr.before_stock.to_i
        @d_tank_compute_reports[idx][:receive] = cr.receive.to_i
        @d_tank_compute_reports[idx][:sale] = cr.sale.to_i
        @d_tank_compute_reports[idx][:compute_stock] = cr.compute_stock.to_i
        @d_tank_compute_reports[idx][:after_stock] = cr.after_stock.to_i
        @d_tank_compute_reports[idx][:sale_total] = cr.sale_total.to_i
        @d_tank_compute_reports[idx][:decrease] = cr.decrease.to_i
        @d_tank_compute_reports[idx][:decrease_total] = cr.decrease_total.to_i
        @d_tank_compute_reports[idx][:total_percentage] = cr.total_percentage
        @d_tank_compute_reports[idx][:inspect_flg] = cr.inspect_flg
      else
        union_no = cr.tank_union_no
      
        @d_tank_compute_reports[idx][:tank_no] = @d_tank_compute_reports[idx][:tank_no].to_s + " - " + cr.tank_no.to_s
        @d_tank_compute_reports[idx][:oil_name] = cr.oil_name
        @d_tank_compute_reports[idx][:volume] += cr.volume
        @d_tank_compute_reports[idx][:oil_limit] += cr.oil_limit.to_i
        @d_tank_compute_reports[idx][:before_stock] += cr.before_stock.to_i
        @d_tank_compute_reports[idx][:receive] += cr.receive.to_i
        @d_tank_compute_reports[idx][:sale] += cr.sale.to_i
        @d_tank_compute_reports[idx][:compute_stock] += cr.compute_stock.to_i
        @d_tank_compute_reports[idx][:after_stock] += cr.after_stock.to_i
        @d_tank_compute_reports[idx][:sale_total] += cr.sale_total.to_i
        @d_tank_compute_reports[idx][:decrease] += cr.decrease.to_i
        @d_tank_compute_reports[idx][:decrease_total] += cr.decrease_total.to_i
        
        joken = " where cr.m_tank_id = t.id and t.deleted_flg = 0"
        joken << "   and d_result_id = #{d_result_id} and t.tank_union_no = #{union_no}"
        
        count_sql = "select count(*) from d_tank_compute_reports cr, m_tanks t" + joken
        count = DTankComputeReport.count_by_sql(count_sql)
        
        inspect_sql = "select sum(cr.inspect_flg) from d_tank_compute_reports cr, m_tanks t" + joken
        inspect = DTankComputeReport.find_by_sql(inspect_sql)
        
        if inspect[0].sum.blank?
          @d_tank_compute_reports[idx][:inspect_flg] = ""
        elsif count.to_i == inspect[0].sum.to_i
          @d_tank_compute_reports[idx][:inspect_flg] = 1
        else  
          @d_tank_compute_reports[idx][:inspect_flg] = 0
        end

        total_percentage = @d_tank_compute_reports[idx][:decrease_total].to_f / @d_tank_compute_reports[idx][:sale_total].to_f * 100

        #桁オーバーフロー対策
        if total_percentage >= 1000
          total_percentage = 999.999 
        elsif total_percentage <= -1000  
          total_percentage = -999.999
        elsif total_percentage.nan?  
          total_percentage = 0        
        end     

        if total_percentage == 0
          @d_tank_compute_reports[idx][:total_percentage] = ""
        else  
          @d_tank_compute_reports[idx][:total_percentage] = total_percentage.round(3) 
        end
        
      end  
    end  #d_tank_compute_reports.each_with_index
  end
  
  def m_meters_count_sql(m_shop_id)
    sql = "select count(*) from m_meters m , m_tanks t"
    sql << " where m.m_tank_id = t.id and m.deleted_flg = 0"
    sql << "  and t.deleted_flg = 0 and t.m_shop_id = #{m_shop_id}"
    
    return sql    
  end
  
  def tika_data_create(d_result_id)
    d_result = DResult.find(d_result_id)
    day, yesterday = old_result_date(d_result.result_date)
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         d_result.m_shop_id, yesterday])
    if old_d_result.blank?
      old_d_result_id = 0
    else
      old_d_result_id = old_d_result.id  
    end
    
    
  #地下タンク計算データ-------------------------
    
    #販売数量SQL
    meter_sql = "select t.id m_tank_id, SUM(COALESCE(dm.meter, 0)) meter_sum, SUM(COALESCE(old_dm.meter, 0)) old_meter_sum"                                                     
    meter_sql << " from m_tanks t, m_meters m"
    meter_sql << " left join d_result_meters dm on (dm.m_meter_id = m.id and dm.d_result_id = #{d_result.id})"
    meter_sql << " left join d_result_meters old_dm on (old_dm.m_meter_id = m.id and old_dm.d_result_id = #{old_d_result_id})"
    meter_sql << " where t.deleted_flg = 0 and m.deleted_flg = 0 and t.id = m.m_tank_id"
    meter_sql << "   and t.m_shop_id = #{d_result.m_shop_id} group by t.id"                                                     

    meter_sales = MMeter.find_by_sql(meter_sql)          
    sales = Array::new
    
    meter_sales.each do |meter_sale|
      sales[meter_sale.m_tank_id] = Hash::new
      sales[meter_sale.m_tank_id][:sale] = meter_sale.meter_sum.to_i - meter_sale.old_meter_sum.to_i
    end                                                       
    
    #地下タンク仕入量、在庫量抽出
    d_result_tanks = DResultTank.find(:all, :conditions => ["d_result_id = ?", d_result.id])   
    tanks = Array::new
    d_result_tanks.each do |d_result_tank|
      tanks[d_result_tank.m_tank_id] = Hash::new
      tanks[d_result_tank.m_tank_id][:receive] = d_result_tank.receive.to_i
      tanks[d_result_tank.m_tank_id][:stock] = d_result_tank.stock.to_i
    end
    
    m_tanks = MTank.find(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",d_result.m_shop_id])
    m_tanks.each do |m_tank|
      d_tank_compute_report = DTankComputeReport.find(:first, :conditions => ["d_result_id = ? and m_tank_id = ?", d_result_id, m_tank.id])
      old_d_tank_compute_report = DTankComputeReport.find(:first, :conditions => ["d_result_id = ? and m_tank_id = ?", old_d_result_id, m_tank.id])
      
      if d_tank_compute_report.blank?
        d_tank_compute_report = DTankComputeReport.new
        d_tank_compute_report.d_result_id = d_result_id
        d_tank_compute_report.m_tank_id = m_tank.id
        d_tank_compute_report.inspect_flg = 0             
      end
      
      if old_d_tank_compute_report.blank?
        d_tank_compute_report.before_stock = 0
      else
        d_tank_compute_report.before_stock = old_d_tank_compute_report.after_stock     
      end

      d_tank_compute_report.receive = tanks[m_tank.id][:receive]
      d_tank_compute_report.sale = sales[m_tank.id][:sale] #--
      d_tank_compute_report.compute_stock = d_tank_compute_report.before_stock + d_tank_compute_report.receive - d_tank_compute_report.sale
      d_tank_compute_report.after_stock = tanks[m_tank.id][:stock]
      d_tank_compute_report.decrease = d_tank_compute_report.after_stock - d_tank_compute_report.compute_stock
      
      if old_d_tank_compute_report.blank? or day == "01"#前回レコードがない、または月初だと今回の値を代入
        d_tank_compute_report.sale_total = sales[m_tank.id][:sale]
        d_tank_compute_report.decrease_total = d_tank_compute_report.decrease 
      else
        d_tank_compute_report.decrease_total = old_d_tank_compute_report.decrease_total + d_tank_compute_report.decrease
        d_tank_compute_report.sale_total = old_d_tank_compute_report.sale_total + sales[m_tank.id][:sale] 
      end
      total_percentage = d_tank_compute_report.decrease_total.to_f / d_tank_compute_report.sale_total.to_f * 100      

      #桁オーバーフロー対策
      if total_percentage >= 1000
        total_percentage = 999.999 
      elsif total_percentage <= -1000  
        total_percentage = -999.999
      elsif total_percentage.nan?  
        total_percentage = 0        
      end
    
      d_tank_compute_report.total_percentage = total_percentage.round(3)
      d_tank_compute_report.save      
    end
    
    
  #地下タンク過不足データ--------------------------
    compute_sql = "select o.id m_oil_id, SUM(cr.decrease) decrease_sum, SUM(cr.sale) sale_sum, SUM(cr.sale_total) sale_total_sum"
    compute_sql << " from m_oils o, m_tanks t, d_tank_compute_reports cr"
    compute_sql << " where o.deleted_flg = 0 and t.deleted_flg = 0 and o.id = t.m_oil_id"
    compute_sql << "   and cr.m_tank_id = t.id and cr.d_result_id = #{d_result.id}"
    compute_sql << " group by o.id order by o.id"
    
    d_tank_compute_reports = DTankComputeReport.find_by_sql(compute_sql)    
    d_tank_decrease_report = DTankDecreaseReport.find(:first, :conditions => ["d_result_id = ?", d_result.id])
    old_d_tank_decrease_report = DTankDecreaseReport.find(:first, :conditions => ["d_result_id = ?", old_d_result_id])
    
    if d_tank_decrease_report.blank?
      d_tank_decrease_report = DTankDecreaseReport.new
      d_tank_decrease_report.d_result_id = d_result.id      
    end
    
    d_tank_compute_reports.each do |d_tank_compute_report|
      d_tank_decrease_report["oil#{d_tank_compute_report.m_oil_id}_id"] = d_tank_compute_report.m_oil_id
      d_tank_decrease_report["oil#{d_tank_compute_report.m_oil_id}_num"] = d_tank_compute_report.decrease_sum
    end
    
    #前回レコードがない場合、または月初めの場合は累計項目に今回の値を代入
    if old_d_tank_decrease_report.blank? or day == "01" 
      d_tank_decrease_report.oil1_num_total = d_tank_decrease_report.oil1_num
      d_tank_decrease_report.oil2_num_total = d_tank_decrease_report.oil2_num
      d_tank_decrease_report.oil3_num_total = d_tank_decrease_report.oil3_num
      d_tank_decrease_report.oil4_num_total = d_tank_decrease_report.oil4_num
    else
      d_tank_decrease_report.oil1_num_total = d_tank_decrease_report.oil1_num + old_d_tank_decrease_report.oil1_num_total
      d_tank_decrease_report.oil2_num_total = d_tank_decrease_report.oil2_num + old_d_tank_decrease_report.oil2_num_total
      d_tank_decrease_report.oil3_num_total = d_tank_decrease_report.oil3_num + old_d_tank_decrease_report.oil3_num_total
      d_tank_decrease_report.oil4_num_total = d_tank_decrease_report.oil4_num + old_d_tank_decrease_report.oil4_num_total        
    end
      
      #レギュラーのみの欠減率を求める
    d_tank_compute_reports.each do |d_tank_compute_report|
      if d_tank_compute_report.m_oil_id.to_i == 2
        oil_percent = d_tank_decrease_report.oil2_num.to_f / d_tank_compute_report.sale_sum.to_f * 100
        
        #桁オーバーフロー対策
        if oil_percent >= 1000
          oil_percent = 999.99
        elsif oil_percent <= -1000  
          oil_percent = -999.99
        elsif oil_percent.nan?  
          oil_percent = 0        
        end             

        d_tank_decrease_report.oil_percent = oil_percent.round(2)
        
        oil_percent_total = d_tank_decrease_report.oil2_num_total.to_f / d_tank_compute_report.sale_total_sum.to_f * 100        
        #桁オーバーフロー対策
        if oil_percent_total >= 1000
          oil_percent_total = 999.99
        elsif oil_percent_total <= -1000  
          oil_percent_total = -999.99
        elsif oil_percent_total.nan?  
          oil_percent_total = 0        
        end        
     
        d_tank_decrease_report.oil_percent_total = oil_percent_total.round(2)        
      end
    end
        
    d_tank_decrease_report.save    
  end
  
  def m_oiletc_pos_total(d_result_id, m_oiletc_cd, tax_rate)
    sql = "select COALESCE(r.pos1_data, 0) + COALESCE(r.pos2_data, 0) + COALESCE(r.pos3_data, 0) as pos_total, m.tax_flg"
    sql << " from d_result_oiletcs r, m_oiletcs m"
    sql << " where r.m_oiletc_id = m.id and m.oiletc_cd = #{m_oiletc_cd}"
    sql << "   and r.d_result_id = #{d_result_id}"
    
    d_result_oiletc = DResultOiletc.find_by_sql(sql)
    
    if d_result_oiletc.blank?
      pos_total = 0
    else
      #課税フラグが１の場合のみ税抜き値を代入
      if d_result_oiletc[0].tax_flg.to_i == 1
        pos_total = d_result_oiletc[0].pos_total.to_i / tax_rate
      else
        pos_total = d_result_oiletc[0].pos_total  
      end   
    end
    
    return pos_total
  end

  def m_etc_pos_total(d_result_id, m_etc_cd, tax_rate)
    sql = "select COALESCE(r.pos1_data, 0) + COALESCE(r.pos2_data, 0) + COALESCE(r.pos3_data, 0) as pos_total, m.tax_flg"
    sql << " from d_result_etcs r, m_etcs m"
    sql << " where r.m_etc_id = m.id and m.etc_cd = #{m_etc_cd}"
    sql << " and r.d_result_id = #{d_result_id}"
    
    d_result_etc = DResultEtc.find_by_sql(sql)
    
    if d_result_etc.blank?
      pos_total = 0
    else
      #課税フラグが１の場合のみ税抜き値を代入
      if d_result_etc[0].tax_flg.to_i == 1
        pos_total = d_result_etc[0].pos_total.to_i / tax_rate
      else
        pos_total = d_result_etc[0].pos_total
      end
    end
    
    return pos_total
  end
  
  def m_oiletc0_en_pos_total_sql
    sql = "select o.*, c.code from m_oiletcs o, m_codes c"
    sql << " where to_number(c.code, '999999999') = o.oiletc_tani and o.oiletc_group = 0"
    sql << " and o.deleted_flg = 0 and c.kbn = 'tani' and c.code = '0'"

    return sql    
  end 
  
  def result_index_sql(date, shop_kbn)
    sql = "select s.shop_cd, s.shop_name, r.id, r.kakutei_flg, u.user_name, u.account, d.code_name shop_kbn_name, m.code_name flg,"
    sql << "      substr(r.result_date, 1, 4) || '/' || substr(r.result_date, 5, 2) || '/' || substr(r.result_date, 7, 2) as result_date"
    sql << " from m_shops s"
    sql << " left join d_results r on (r.m_shop_id = s.id and r.result_date = '#{date}')"
    sql << " left join users u on (r.created_user_id = u.id)"
    sql << " left join (select * from m_codes where kbn='shop_kbn') d on s.shop_kbn = cast(d.code as integer)"
    sql << " left join (select * from m_codes where kbn='misumi_flg') m on r.kakutei_flg = cast(m.code as integer)"
    sql << " where s.deleted_flg = 0"
    
    unless shop_kbn.blank?
      sql << " and s.shop_kbn = #{shop_kbn}"
    end
    
    sql << " order by s.shop_cd"

    return sql
  end  
end
