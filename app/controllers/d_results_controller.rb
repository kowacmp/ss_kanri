class DResultsController < ApplicationController
  include DResultsHelper

  def index
    @m_shop = MShop.find(current_user.m_shop_id)
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"])
    @m_oiletc0s = MOiletc.find(:all, :conditions => ["oiletc_group = 0 and deleted_flg = 0"])
    @m_oiletc1s = MOiletc.find(:all, :conditions => ["oiletc_group = 1 and deleted_flg = 0"])
    @etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0 and kansa_flg = 1"])
    
    session[:m_oil_totals] = Array::new                 
    @m_oils.each do |m_oil|
      session[:m_oil_totals][m_oil.id] = Hash::new
      session[:m_oil_totals][m_oil.id][:total] = ""
    end    
  end
  
  def select_date
    @m_shop = MShop.find(current_user.m_shop_id)
    @result_date = params[:select_date][0,4] + params[:select_date][5,2] + params[:select_date][8,2]
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, @result_date])
    
    #出荷数量取得
    oil_sql = "select m.id, m.oil_name, d.pos1_data, d.pos2_data, d.pos3_data"
    oil_sql << " from m_oils m left join d_result_oils d on (m.id = d.m_oil_id"
    if @d_result.blank?
      oil_sql << " and d.d_result_id is null)"
    else
      oil_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    oil_sql << " where m.deleted_flg = 0 order by m.oil_cd"
    @m_oil_totals = MOil.find_by_sql(oil_sql)
    @m_oil_totals.each do |m_oil| 
      session[:m_oil_totals][m_oil.id][:total] = m_oil.pos1_data.to_f + m_oil.pos2_data.to_f + m_oil.pos3_data.to_f
    end
    
    #油外販売取得
    oiletc0_sql = m_oiletc_sql(@d_result, 0)
    @oiletc0s = MOiletc.find_by_sql(oiletc0_sql)
    @etc0_pos1_total, @etc0_pos2_total, @etc0_pos3_total, @etc0_pos_total = 0,0,0,0  
    @oiletc0s.each do |oiletc0|
      @etc0_pos1_total += oiletc0.pos1_data.to_i
      @etc0_pos2_total += oiletc0.pos2_data.to_i 
      @etc0_pos3_total += oiletc0.pos3_data.to_i
      @etc0_pos_total += oiletc0.pos_total.to_i    
    end

 
    #油外販売取得
    oiletc1_sql = m_oiletc_sql(@d_result, 1)
    @oiletc1s = MOiletc.find_by_sql(oiletc1_sql)
    
    
    #その他売上取得
    etc_sql = "select m.id, m.etc_name, m.max_num,m.etc_cd, d.id d_result_etc_id, d.no,"
    etc_sql << "      d.pos1_data, d.pos2_data, d.pos3_data, d.pos1_data + d.pos2_data + d.pos3_data as pos_total"
    etc_sql << " from m_etcs m left join d_result_etcs d on (m.id = d.m_etc_id"
    if @d_result.blank?
      etc_sql << " and d.d_result_id is null)"
    else
      etc_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    etc_sql << " where m.deleted_flg = 0 and m.kansa_flg = 1 order by m.etc_cd, d.no"
    @m_etcs = MEtc.find_by_sql(etc_sql)

 
    #営業POS伝回収報告
    m_oil_etc_sql = "select m.id, m.oiletc_name, d.get_num"
    m_oil_etc_sql << " from m_oiletcs m left join d_result_collects d"
    m_oil_etc_sql << "   on (m.id = d.m_oiletc_id"
    if @d_result.blank?
      m_oil_etc_sql << " and d.d_result_id is null)"
    else
      m_oil_etc_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    m_oil_etc_sql << " where m.oiletc_trade = 1 and m.deleted_flg = 0 order by m.oiletc_cd" 
    @m_oil_etcs = MOiletc.find_by_sql(m_oil_etc_sql)
    
    
    #車検予約カード獲得
    syukei_data(@d_result, @result_date)
    
    #夢ポイント
    if @d_result.blank?
      
    else
      sql = yume_sql(@d_result.id)
      @d_result_yumes = DResultOiletc.find_by_sql(sql)
    end
        
    #油種別メーター集計
    if @d_result.blank?
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
      end
      tank_betu_total(0)
    else  
      meter_total(@d_result.id)
      tank_betu_total(@d_result.id)
    end    
  end
  
  def d_result_create
    m_shop = MShop.find(current_user.m_shop_id)
    d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, params[:select][:result_date]])
    #実績データ作成 
    if d_result.blank?
      d_result = DResult.new
      d_result.result_date = params[:select][:result_date]
      d_result.m_shop_id = current_user.m_shop_id
      d_result.kakutei_flg = 0
      d_result.created_user_id = current_user.id
      d_result.updated_user_id = current_user.id
      d_result.save
    end
    
    #油種実績データ作成
    m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"])
        
    m_oils.each do |m_oil|
      d_result_oil = DResultOil.find(:first, :conditions => ["d_result_id = ? and m_oil_id = ?", d_result.id, m_oil.id])
      if d_result_oil.blank?
        d_result_oil = DResultOil.new
        d_result_oil.d_result_id = d_result.id
        d_result_oil.m_oil_id = m_oil.id
        d_result_oil.created_user_id = current_user.id       
      end
      
      d_result_oil.pos1_data = params[:oil_pos1]["#{m_oil.id}"]
      d_result_oil.pos2_data = params[:oil_pos2]["#{m_oil.id}"]
      d_result_oil.pos3_data = params[:oil_pos3]["#{m_oil.id}"]
      d_result_oil.updated_user_id = current_user.id
      d_result_oil.save
    end

    #油外販売データ作成
    m_oiletc0s = MOiletc.find(:all, :conditions => ["oiletc_group = 0 and deleted_flg = 0"])

    m_oiletc0s.each do |m_oiletc0|
      d_result_oiletc0 = DResultOiletc.find(:first, :conditions => ["d_result_id = ? and m_oiletc_id = ?", d_result.id, m_oiletc0.id])
     
      if d_result_oiletc0.blank?
        d_result_oiletc0 = DResultOiletc.new
        d_result_oiletc0.d_result_id = d_result.id
        d_result_oiletc0.m_oiletc_id = m_oiletc0.id
        d_result_oiletc0.created_user_id = current_user.id       
      end
           
      d_result_oiletc0.pos1_data = params[:etc0_pos1]["#{m_oiletc0.id}"]
      d_result_oiletc0.pos2_data = params[:etc0_pos2]["#{m_oiletc0.id}"]
      d_result_oiletc0.pos3_data = params[:etc0_pos3]["#{m_oiletc0.id}"]
      d_result_oiletc0.updated_user_id = current_user.id
      d_result_oiletc0.save
    end    
    
    #他売上データ作成
    m_oiletc1s = MOiletc.find(:all, :conditions => ["oiletc_group = 1 and deleted_flg = 0"])

    m_oiletc1s.each do |m_oiletc1|
      d_result_oiletc1 = DResultOiletc.find(:first, :conditions => ["d_result_id = ? and m_oiletc_id = ?", d_result.id, m_oiletc1.id])
     
      if d_result_oiletc1.blank?
        d_result_oiletc1 = DResultOiletc.new
        d_result_oiletc1.d_result_id = d_result.id
        d_result_oiletc1.m_oiletc_id = m_oiletc1.id
        d_result_oiletc1.created_user_id = current_user.id       
      end
           
      d_result_oiletc1.pos1_data = params[:etc1_pos1]["#{m_oiletc1.id}"]
      d_result_oiletc1.pos2_data = params[:etc1_pos2]["#{m_oiletc1.id}"]
      d_result_oiletc1.pos3_data = params[:etc1_pos3]["#{m_oiletc1.id}"]
      d_result_oiletc1.updated_user_id = current_user.id
      d_result_oiletc1.save
    end
    
    #その他売上データ作成
    m_etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0 and kansa_flg = 1"])     
    m_etcs.each do |m_etc|
      for i in 1..m_etc.max_num
        d_result_etc = DResultEtc.find(:first, :conditions => ["d_result_id = ? and m_etc_id = ? and no = ?",
                                                                d_result.id, m_etc.id, i])
        
        if d_result_etc.blank?
          d_result_etc = DResultEtc.new
          d_result_etc.d_result_id = d_result.id
          d_result_etc.m_etc_id = m_etc.id
          d_result_etc.no = i
          d_result_etc.created_user_id = current_user.id  
        end
        
        d_result_etc.pos1_data = params[:m_etc_pos1]["#{m_etc.id}_no#{i}"]
        d_result_etc.pos2_data = params[:m_etc_pos2]["#{m_etc.id}_no#{i}"]
        d_result_etc.pos3_data = params[:m_etc_pos3]["#{m_etc.id}_no#{i}"]
        d_result_etc.updated_user_id = current_user.id
        d_result_etc.save                                                                
      end   
    end
    
    #営業POS伝回収報告データ作成  油外店舗のみ作成
    if m_shop.shop_kbn == 1
      m_oiletcs = MOiletc.find(:all, :conditions => ["oiletc_trade = 1 and deleted_flg = 0"])

      m_oiletcs.each do |m_oiletc|
        d_result_collect = DResultCollect.find(:first, :conditions => ["d_result_id = ? and m_oiletc_id = ?", d_result.id, m_oiletc.id])
     
        if d_result_collect.blank?
          d_result_collect = DResultCollect.new
          d_result_collect.d_result_id = d_result.id
          d_result_collect.m_oiletc_id = m_oiletc.id
          d_result_collect.created_user_id = current_user.id       
        end
           
        d_result_collect.get_num = params[:get_num]["#{m_oiletc.id}"]
        d_result_collect.updated_user_id = current_user.id
        d_result_collect.save
      end
    end
        
    #タンク点検フラグ更新
    d_tank_compute_reports = DTankComputeReport.find(:all, :conditions => ["d_result_id = ?",d_result.id])
    d_tank_compute_reports.each do |d_tank_compute_report|
      d_tank_compute_report.inspect_flg = params[:inspect_flg]["#{d_tank_compute_report.id}"]
      d_tank_compute_report.save    
    end
     
    head :ok
  end
  
  def reserve_index
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = current_user.m_shop_id
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
    
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", @d_result.id], :order => 'get_date, id')
    
    render :layout => 'modal'
  end
  
  def reserve_new
    @d_result_id = params[:d_result_id]
    #render :layout => 'modal'
  end
  
  def reserve_create
    d_result = DResult.find(params[:reserve][:d_result_id]) 
    d_result_reserve = DResultReserve.new
    d_result_reserve.d_result_id = d_result.id
    d_result_reserve.get_date = params[:reserve][:get_date][0,4] + params[:reserve][:get_date][5,2] + params[:reserve][:get_date][8,2]
    d_result_reserve.reserve_name = params[:reserve][:reserve_name] 
    d_result_reserve.created_user_id = current_user.id
    d_result_reserve.updated_user_id = current_user.id
    d_result_reserve.save
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result.id], :order => 'get_date, id')
    
    @result_date = d_result.result_date
    #現在月から４ヶ月先までの車検予約実績データ集計
    syukei_data(d_result, '')
  end
  
  def reserve_edit
    @d_result_reserve = DResultReserve.find(params[:id])
    #render :layout => 'modal'
  end
  
  def reserve_update
    d_result_reserve = DResultReserve.find(params[:reserve][:id])
    d_result_reserve.get_date = params[:reserve][:get_date][0,4] + params[:reserve][:get_date][5,2] + params[:reserve][:get_date][8,2]
    d_result_reserve.reserve_name = params[:reserve][:reserve_name]
    d_result_reserve.updated_user_id = current_user.id
    d_result_reserve.save
    
    d_result = DResult.find(d_result_reserve.d_result_id)
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result.id], :order => 'get_date, id')
  
    @result_date = d_result.result_date
    #現在月から４ヶ月先までの車検予約実績データ集計
    syukei_data(d_result, '')  
  end
  
  def reserve_delete
    d_result_reserve = DResultReserve.find(params[:id])
    d_result_id = d_result_reserve.d_result_id
    d_result = DResult.find(d_result_id)
    
    d_result_reserve.destroy
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result_id], :order => 'get_date, id')
    @result_date = d_result.result_date
    #現在月から４ヶ月先までの車検予約実績データ集計
    syukei_data(d_result, '')  
  end
  
  def yume_index
    p "yume_index   yume_index   yume_index   yume_index"
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = current_user.m_shop_id
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
    
    sql = yume_sql(@d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    
    render :layout => 'modal'    
  end
  
  def yume_new
    @d_result_id = params[:d_result_id]
    #render :layout => 'modal'
  end
  
  def yume_create
    d_result = DResult.find(params[:yume][:d_result_id]) 
    m_oiletc = MOiletc.find(:first, :conditions => ["oiletc_group = 2"])

    d_result_yume = DResultOiletc.new
    d_result_yume.d_result_id = d_result.id
    d_result_yume.m_oiletc_id = m_oiletc.id
    d_result_yume.pos1_data = params[:yume][:kingaku]
    d_result_yume.pos2_data = params[:yume][:point]
    d_result_yume.pos3_data = params[:yume][:kensu] 
    d_result_yume.created_user_id = current_user.id
    d_result_yume.updated_user_id = current_user.id
    d_result_yume.save
   
    sql = yume_sql(d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date
  end

  def yume_edit
    @d_result_yume = DResultOiletc.find(params[:id])
  end
  
  def yume_update
    d_result_yume = DResultOiletc.find(params[:yume][:id])
    d_result_yume.pos1_data = params[:yume][:kingaku]
    d_result_yume.pos2_data = params[:yume][:point]
    d_result_yume.pos3_data = params[:yume][:kensu]
    d_result_yume.updated_user_id = current_user.id   
    d_result_yume.save

    d_result = DResult.find(d_result_yume.d_result_id)    
    sql = yume_sql(d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date       
  end
  
  def yume_delete
    d_result_yume = DResultOiletc.find(params[:id])
    d_result_id = d_result_yume.d_result_id
    d_result = DResult.find(d_result_id)  
    d_result_yume.destroy
    
    sql = yume_sql(d_result_id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date    
  end
  
  def meter_index
    p "meter_index   meter_index   meter_index   meter_index"
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = current_user.m_shop_id
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')
    @m_codes = MCode.find(:all, :conditions => ["kbn = 'pos_class'", :order => 'code'])
  
    #開始時メーター
    today = Time.parse(@result_date)
    yesterday = (today - 1.days).strftime("%Y%m%d")
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         @d_result.m_shop_id, yesterday])
    old_max_no = 0
    old_meter = Hash::new
    @old_meters = Array::new
    
    unless old_d_result.blank?  #前日レコードがない場合は作成しない                                                  
      @m_oils.each do |m_oil|
        @m_codes.each do |m_code|
          sql = "select m.id m_meter_id, m.meter_no, d.meter from m_meters m"
          sql << " left join d_result_meters d on (m.id = d.m_meter_id and d.d_result_id = #{old_d_result.id})"
          sql << " left join m_tanks t on (m.m_tank_id = t.id)"
          sql << " left join m_oils o on (t.m_oil_id = o.id)"
          sql << " where m.pos_class = #{m_code.id} and o.id = #{m_oil.id} and t.m_shop_id = #{@d_result.m_shop_id}"
          sql << "  and m.deleted_flg = 0 and t.deleted_flg = 0 and o.deleted_flg = 0"
          sql << " order by m.number"
                              
          old_meter["#{m_oil.id}_#{m_code.id}"] = MOil.find_by_sql(sql)
          old_max_no = old_meter["#{m_oil.id}_#{m_code.id}"].size if old_meter["#{m_oil.id}_#{m_code.id}"].size > old_max_no
        end
      end
    
      for i in 0..old_max_no - 1
        @old_meters[i] = Hash::new
      end
    
      @m_oils.each do |m_oil|
        @m_codes.each do |m_code|
                                      
          old_meter["#{m_oil.id}_#{m_code.id}"].each_with_index do |m_meter, idx|
            @old_meters[idx]["#{m_oil.id}_#{m_code.id}_m_meter_id"] = m_meter.m_meter_id
            @old_meters[idx]["#{m_oil.id}_#{m_code.id}_meter_no"] = m_meter.meter_no
            @old_meters[idx]["#{m_oil.id}_#{m_code.id}_meter"] = m_meter.meter
          end
        end
      end 
    end    
    
    
    #終了時メーター
    max_no = 0
    meter = Hash::new 
    
    @m_oils.each do |m_oil|
      @m_codes.each do |m_code|
        sql = "select m.id m_meter_id, m.meter_no, d.meter from m_meters m"
        sql << " left join d_result_meters d on (m.id = d.m_meter_id and d.d_result_id = #{@d_result.id})"
        sql << " left join m_tanks t on (m.m_tank_id = t.id)"
        sql << " left join m_oils o on (t.m_oil_id = o.id)"
        sql << " where m.pos_class = #{m_code.id} and o.id = #{m_oil.id} and t.m_shop_id = #{@d_result.m_shop_id}"
        sql << "  and m.deleted_flg = 0 and t.deleted_flg = 0 and o.deleted_flg = 0"
        sql << " order by m.number"
p "sql=#{sql}"                             
        meter["#{m_oil.id}_#{m_code.id}"] = MOil.find_by_sql(sql)
        max_no = meter["#{m_oil.id}_#{m_code.id}"].size if meter["#{m_oil.id}_#{m_code.id}"].size > max_no
      end
    end
    
    @meters = Array::new
    for i in 0..max_no - 1
      @meters[i] = Hash::new
    end
    
    @m_oils.each do |m_oil|
      @m_codes.each do |m_code|
                                      
        meter["#{m_oil.id}_#{m_code.id}"].each_with_index do |m_meter, idx|
          @meters[idx]["#{m_oil.id}_#{m_code.id}_m_meter_id"] = m_meter.m_meter_id
          @meters[idx]["#{m_oil.id}_#{m_code.id}_meter_no"] = m_meter.meter_no
          @meters[idx]["#{m_oil.id}_#{m_code.id}_meter"] = m_meter.meter
        end
      end
    end
        
    #仕入、在庫データ取得    
    sql = "select t.id m_tank_id, t.tank_no, t.volume, o.oil_name, d.receive, d.stock from m_tanks t"
    sql << " left join d_result_tanks d on (t.id = d.m_tank_id and d.d_result_id = #{@d_result.id})"
    sql << " left join m_oils o on (t.m_oil_id = o.id)"
    sql << " where t.m_shop_id = #{@d_result.m_shop_id} and t.deleted_flg = 0 and o.deleted_flg = 0 "
    sql << " order by t.tank_no"
                                            
    @m_tanks = MTank.find_by_sql(sql)
        
    render :layout => 'modal'
  end
  
  def d_result_meter_create
    p "d_result_meter_create   d_result_meter_create   d_result_meter_create"
    d_result_id = params[:select][:d_result_id]

    #メーター登録
    sql = "select m.* from m_meters m, m_tanks t"
    sql << " where m.m_tank_id = t.id and t.m_shop_id = #{current_user.m_shop_id}"

    m_meters = MMeter.find_by_sql(sql)
    m_meters.each do |m_meter|
      d_result_meter = DResultMeter.find(:first, :conditions => ["d_result_id = ? and m_meter_id = ?", d_result_id, m_meter.id])
      
      if d_result_meter.blank?
        d_result_meter = DResultMeter.new
        d_result_meter.d_result_id = d_result_id
        d_result_meter.m_meter_id = m_meter.id
        d_result_meter.created_user_id = current_user.id
        d_result_meter.updated_user_id = current_user.id        
      end
      
      d_result_meter.meter = params[:meter]["#{m_meter.id}"]
      d_result_meter.updated_user_id = current_user.id 
      d_result_meter.save
    end
    
    #タンク在庫登録
    m_tanks = MTank.find(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",current_user.m_shop_id])
    m_tanks.each do |m_tank|
      d_result_tank = DResultTank.find(:first, :conditions => ["d_result_id = ? and m_tank_id = ?", d_result_id, m_tank.id])
      
      if d_result_tank.blank?
        d_result_tank = DResultTank.new
        d_result_tank.d_result_id = d_result_id
        d_result_tank.m_tank_id = m_tank.id
        d_result_tank.created_user_id = current_user.id
        d_result_tank.updated_user_id = current_user.id           
      end
      
      d_result_tank.receive = params[:receive]["#{m_tank.id}"]
      d_result_tank.stock = params[:stock]["#{m_tank.id}"]     
      d_result_tank.updated_user_id = current_user.id 
      d_result_tank.save      
    end


    #地下タンク計算データ
    d_result = DResult.find(d_result_id)
    today = Time.parse(d_result.result_date)
    day = today.strftime("%d")
    yesterday = (today - 1.days).strftime("%Y%m%d")
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         d_result.m_shop_id, yesterday])
    if old_d_result.blank?
      old_d_result_id = 0
    else
      old_d_result_id = old_d_result.id  
    end
    
      #販売数量SQL
    meter_sql = "select t.id m_tank_id, SUM(COALESCE(dm.meter, 0)) meter_sum, SUM(COALESCE(old_dm.meter, 0)) old_meter_sum"                                                     
    meter_sql << " from m_tanks t, m_meters m"
    meter_sql << " left join d_result_meters dm on (dm.m_meter_id = m.id and dm.d_result_id = #{d_result.id})"
    meter_sql << " left join d_result_meters old_dm on (old_dm.m_meter_id = m.id and old_dm.d_result_id = #{old_d_result_id})"
    meter_sql << " where t.deleted_flg = 0 and m.deleted_flg = 0 and t.id = m.m_tank_id"
    meter_sql << "   and m_shop_id = #{d_result.m_shop_id} group by t.id"                                                     
     
    meter_sales = MMeter.find_by_sql(meter_sql)          
    sales = Array::new
    
    meter_sales.each do |meter_sale|
      sales[meter_sale.m_tank_id] = Hash::new
      sales[meter_sale.m_tank_id][:sale] = meter_sale.meter_sum.to_i - meter_sale.old_meter_sum.to_i
    end              
                                                        
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

      d_tank_compute_report.receive = params[:receive]["#{m_tank.id}"]
      d_tank_compute_report.sale = sales[m_tank.id][:sale]
      d_tank_compute_report.compute_stock = d_tank_compute_report.before_stock + d_tank_compute_report.receive - d_tank_compute_report.sale
      d_tank_compute_report.after_stock = params[:stock]["#{m_tank.id}"]
      d_tank_compute_report.decrease = d_tank_compute_report.after_stock - d_tank_compute_report.compute_stock
      
      if old_d_tank_compute_report.blank? or day == "01"#前回レコードがない、または月初だと今回の値を代入
        d_tank_compute_report.sale_total = sales[m_tank.id][:sale]
        d_tank_compute_report.decrease_total = d_tank_compute_report.decrease 
      else
        d_tank_compute_report.decrease_total = old_d_tank_compute_report.decrease_total + d_tank_compute_report.decrease
        d_tank_compute_report.sale_total = old_d_tank_compute_report.sale_total + sales[m_tank.id][:sale] 
      end
      
      total_percentage = d_tank_compute_report.decrease_total.to_f / d_tank_compute_report.sale_total.to_f * 100      
      d_tank_compute_report.total_percentage = total_percentage.round(3)
      d_tank_compute_report.save      
    end
    
    
    #地下タンク過不足データ
    compute_sql = "select o.id m_oil_id, SUM(cr.decrease) decrease_sum, SUM(cr.sale) sale_sum"
    compute_sql << " from m_oils o, m_tanks t, d_tank_compute_reports cr"
    compute_sql << " where o.deleted_flg = 0 and t.deleted_flg = 0 and o.id = t.m_oil_id"
    compute_sql << "   and cr.m_tank_id = t.id and cr.d_result_id = #{d_result.id}"
    compute_sql << " group by o.id order by o.id"
    
    d_tank_compute_reports = DTankComputeReport.find_by_sql(compute_sql)    
    d_tank_decrease_report = DTankDecreaseReport.find(:first, :conditions => ["d_result_id = ?", d_result.id])
    old_d_tank_decrease_report = DTankDecreaseReport.find(:first, :conditions => ["d_result_id = ?", old_d_result.id])
    
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
        d_tank_decrease_report.oil_percent = oil_percent.round(2)
      end
    end
        
    d_tank_decrease_report.save
    
    
    #油種別集計----------------------------------
    meter_total(d_result_id)
    tank_betu_total(d_result_id)
    
    @result_date = d_result.result_date
    p "end   end   end   end   end   end   end   end"    
  end
  
  def oil_total_set
    session[:m_oil_totals][params[:oil].to_i][:total] = params[:oil_total]  

    head :ok
  end
end