class DResultsController < ApplicationController
  include DResultsHelper

  def index
    @m_shop = MShop.find(current_user.m_shops_id)
  end
  
  def select_date
    if params[:select_date].length == 10
      @result_date = params[:select_date][0,4] + params[:select_date][5,2] + params[:select_date][8,2]
    else
        
    end
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shops_id, @result_date])
    
    #出荷数量取得
    oil_sql = "select m.id, m.oil_name, d.pos1_data, d.pos2_data, d.pos3_data"
    oil_sql << " from m_oils m left join d_result_oils d on (m.id = d.m_oil_id"
    if @d_result.blank?
      oil_sql << " and d.d_result_id is null)"
    else
      oil_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    oil_sql << " where m.deleted_flg = 0 order by m.oil_cd"
    @m_oils = MOil.find_by_sql(oil_sql)

    
    #油外販売取得
    oiletc0_sql = m_oiletc_sql(@d_result, 0)
    @oiletc0s = MOiletc.find_by_sql(oiletc0_sql)
      
      
    #油外販売取得
    oiletc1_sql = m_oiletc_sql(@d_result, 1)
    @oiletc1s = MOiletc.find_by_sql(oiletc1_sql)
    
    
    #その他売上取得
    etc_sql = "select m.id, m.etc_name, m.max_num,m.etc_cd, d.id d_result_etc_id, d.no, d.pos1_data, d.pos2_data, d.pos3_data"
    etc_sql << " from m_etcs m left join d_result_etcs d on (m.id = d.m_etc_id"
    if @d_result.blank?
      etc_sql << " and d.d_result_id is null)"
    else
      etc_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    etc_sql << " where m.deleted_flg = 0 order by m.etc_cd, d.no"
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
  end
  
  def d_result_create
    d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shops_id, params[:select][:result_date]])
    #実績データ作成 
    if d_result.blank?
      d_result = DResult.new
      d_result.result_date = params[:select][:result_date]
      d_result.m_shop_id = current_user.m_shops_id
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
    m_etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0"])     
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
    
    #営業POS伝回収報告データ作成
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
  
  def reserve_index
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shops_id, @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = current_user.m_shops_id
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
    d_result_reserve.save
    
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result_reserve.d_result_id], :order => 'get_date, id')
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
  
  def meter_index
    p "meter_index   meter_index   meter_index   meter_index"
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shops_id, @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = current_user.m_shops_id
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')
    @m_codes = MCode.find(:all, :conditions => ["kbn = 'pos_class'", :order => 'code'])
    
    @max_no = 0
    meter = Hash::new 
    
    @m_oils.each do |m_oil|
      @m_codes.each do |m_code|
        sql = "select m.id m_meter_id, m.meter_no, d.meter from m_meters m"
        sql << " left join d_result_meters d on (m.id = d.m_meter_id and d.d_result_id = #{@d_result.id})"
        sql << " left join m_tanks t on (m.m_tank_id = t.id)"
        sql << " left join m_oils o on (t.m_oil_id = o.id)"
        sql << " where m.m_code_id = #{m_code.id} and o.id = #{m_oil.id} and t.m_shop_id = #{@d_result.m_shop_id}"
        sql << "  and m.deleted_flg = 0 and t.deleted_flg = 0 and o.deleted_flg = 0"
        sql << " order by m.number"
                                    
        meter["#{m_oil.id}_#{m_code.id}"] = MOil.find_by_sql(sql)
        @max_no = meter["#{m_oil.id}_#{m_code.id}"].size if meter["#{m_oil.id}_#{m_code.id}"].size > @max_no
      end
    end
    
    @meters = Array::new
    for i in 0..@max_no - 1
      @meters[i] = Hash::new
    end
    
    @m_oils.each do |m_oil|
      @m_codes.each do |m_code|
                                      
        meter["#{m_oil.id}_#{m_code.id}"].each_with_index do |m_meter, idx|
          p "idx=#{idx}"
          @meters[idx]["#{m_oil.id}_#{m_code.id}_m_meter_id"] = m_meter.m_meter_id
          @meters[idx]["#{m_oil.id}_#{m_code.id}_meter_no"] = m_meter.meter_no
          @meters[idx]["#{m_oil.id}_#{m_code.id}_meter"] = m_meter.meter
          #@meters[idx][:m_oil_id] = m_oil.id
          #@meters[idx][:m_code_id] = m_code.id
        end
      end
    end
        
    p "max_no=#{@max_no}"
    p "test=#{meter["1_7"]}"
    render :layout => 'modal'
  end
  
  def d_result_meter_create
    p "d_result_meter_create   d_result_meter_create   d_result_meter_create"
    p params[:select][:d_result_id]
    sql = "select m.* from m_meters m, m_tanks t"
    sql << " where m.m_tank_id = t.id and t.m_shop_id = #{current_user.m_shops_id}"

    m_meters = MMeter.find_by_sql(sql)
    m_meters.each do |m_meter|
      p params[:meter]["#{m_meter.id}"]
      d_result_meter = DResultMeter.find(:first, :conditions => ["d_result_id = ? and m_meter_id = ?", params[:select][:d_result_id], m_meter.id])
      
      if d_result_meter.blank?
        d_result_meter = DResultMeter.new
        d_result_meter.d_result_id = params[:select][:d_result_id]
        d_result_meter.m_meter_id = m_meter.id
        d_result_meter.created_user_id = current_user.id
        d_result_meter.updated_user_id = current_user.id        
      end
      
      d_result_meter.meter = params[:meter]["#{m_meter.id}"]
      d_result_meter.updated_user_id = current_user.id 
      d_result_meter.save
    end
    
  end
end
