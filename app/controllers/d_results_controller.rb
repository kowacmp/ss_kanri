# -*- coding:utf-8 -*-
class DResultsController < ApplicationController
  include DResultsHelper

  def index
    @today = Time.now.strftime("%Y/%m/%d")
    
    sql = result_index_sql(Time.now.strftime("%Y%m%d"), '')
    @m_shops = MShop.find_by_sql(sql)    
  end
  
  def index_select
    p "index_select_date   index_select_date   index_select_date   index_select_date"
    select_date = params[:select_date].delete("/")
  
    sql = result_index_sql(select_date, params[:select_shop_kbn])
    @m_shops = MShop.find_by_sql(sql)
  end
  
  #ロック／解除
  def lock
    p "lock   lock   lock   lock   lock   lock"
    p "params[:id]=#{params[:id]}"
    p "params[:kakutei_flg]=#{params[:kakutei_flg]}"
    
    d_result = DResult.find(params[:id])
    if params[:kakutei_flg] == "checked" 
      d_result.kakutei_flg = 1 #ロックする
    else
      d_result.kakutei_flg = 0 #解除する
    end
    d_result.updated_user_id = current_user.id
    d_result.save
    
    head :ok
  end  
  
  #すべてロック／解除
  def all_lock
    p "params[:input_day]=#{params[:input_day]}"
    p "params[:input_shop_kbn]=#{params[:input_shop_kbn]}"
    p "params[:kakutei_flg]=#{params[:kakutei_flg]}"

    if params[:kakutei_flg] == "checked" 
      @all_kakutei_flg = 1
    else
      @all_kakutei_flg = 0
    end    
        
    update_sql = "update d_results "
    update_sql << " set kakutei_flg = #{@all_kakutei_flg} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where result_date = '#{params[:input_day].delete("/")}' "
    unless params[:input_shop_kbn].blank?
      update_sql << " and m_shop_id in (select id from m_shops where shop_kbn = #{params[:input_shop_kbn]}) "
    end

    ActiveRecord::Base::connection.execute(update_sql)
    
    #対象データを取得
    sql = result_index_sql(params[:input_day].delete("/"), params[:input_shop_kbn])
    @m_shops = MShop.find_by_sql(sql)
    
    respond_to do |format|
      format.html { render :partial => 'result'  }
    end
  end  

  def new
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"])
    @m_oiletc0s = MOiletc.find(:all, :conditions => ["oiletc_group = 0 and deleted_flg = 0"])  
    @m_oiletc1s = MOiletc.find(:all, :conditions => ["oiletc_group = 1 and deleted_flg = 0"])
    @etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0 and kansa_flg = 1"])
    @m_oiletc0_pos_totals = MOiletc.find_by_sql(m_oiletc0_en_pos_total_sql)
    
    session[:m_oil_totals] = Array::new                 
    @m_oils.each do |m_oil|
      session[:m_oil_totals][m_oil.id] = Hash::new
      session[:m_oil_totals][m_oil.id][:total] = 0
    end  
    
    session[:d_result_params] = Hash::new
       
    if params[:d_result_id].blank?
      #直接実績データ入力に来た場合はログイン所属、今日の日付がデフォルト
      @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, Time.now.strftime("%Y%m%d")])
      session[:d_result_params][:d_result_id] = ""
      session[:d_result_params][:d_result_id] = @d_result.id unless @d_result.blank?
      session[:d_result_params][:m_shop_id] = current_user.m_shop_id
      @today = Time.now.strftime("%Y/%m/%d")
      @m_shop_id = current_user.m_shop_id
    else
      #実績データ入力状況確認から来た場合は値をセット
      @d_result = DResult.find(params[:d_result_id])
      session[:d_result_params][:d_result_id] = params[:d_result_id]
      session[:d_result_params][:m_shop_id] = @d_result.m_shop_id
      @today = @d_result.result_date[0,4] + "/" + @d_result.result_date[4,2] + "/" + @d_result.result_date[6,2]
      @m_shop_id = @d_result.m_shop_id
      @edit_flg = 1
    end
    
    select_date
  end
  
  def select_date
    if params[:select_date].blank?
      #newから来た場合
      @result_date = @today.delete("/")
      @m_shop = MShop.find(@m_shop_id)
    else  
      #入力画面にて日付を選択した場合
      @result_date = params[:select_date].delete("/")
      @m_shop = MShop.find(params[:m_shop_id])
    end
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      @m_shop.id, @result_date])
    
    #出荷数量取得
    oil_sql = "select m.id, m.oil_name, d.pos1_data, d.pos2_data, d.pos3_data,"
    oil_sql << " COALESCE(d.pos1_data, 0) + COALESCE(d.pos2_data, 0) + COALESCE(d.pos3_data, 0) as pos_total"
    oil_sql << " from m_oils m left join d_result_oils d on (m.id = d.m_oil_id"
    if @d_result.blank?
      oil_sql << " and d.d_result_id is null)"
    else
      oil_sql << " and d.d_result_id = #{@d_result.id})"  
    end    
    oil_sql << " where m.deleted_flg = 0 order by m.oil_cd"

    @pos1_gasorin, @pos2_gasorin, @pos3_gasorin, @total_gasorin = 0,0,0,0
    @pos1_mofuel, @pos2_mofuel, @pos3_mofuel, @total_mofuel = 0,0,0,0
    
    @m_oil_totals = MOil.find_by_sql(oil_sql)
    @m_oil_totals.each do |m_oil| 
      session[:m_oil_totals][m_oil.id][:total] = m_oil.pos_total
      
      if m_oil.id == 1 or m_oil.id == 2
        @pos1_gasorin += m_oil.pos1_data.to_f
        @pos2_gasorin += m_oil.pos2_data.to_f
        @pos3_gasorin += m_oil.pos3_data.to_f
        @total_gasorin += m_oil.pos_total.to_f
      end
       
      if m_oil.id == 1 or m_oil.id == 2 or m_oil.id == 3
        @pos1_mofuel += m_oil.pos1_data.to_f
        @pos2_mofuel += m_oil.pos2_data.to_f
        @pos3_mofuel += m_oil.pos3_data.to_f
        @total_mofuel += m_oil.pos_total.to_f
      end          
    end
    @pos1_gasorin = @pos1_gasorin.round(2)
    @pos2_gasorin = @pos1_gasorin.round(2)
    @pos3_gasorin = @pos1_gasorin.round(2)
    @total_gasorin = @total_gasorin.round(2)
    @pos1_mofuel = @pos1_mofuel.round(2)
    @pos2_mofuel = @pos2_mofuel.round(2)
    @pos3_mofuel = @pos3_mofuel.round(2)
    @total_mofuel = @total_mofuel.round(2)
    
    #油外販売取得  油外店のみ取得
    if @m_shop.shop_kbn == 1
      oiletc0_sql = m_oiletc_sql(@d_result, 0)
      @oiletc0s = MOiletc.find_by_sql(oiletc0_sql)

      @etc0_pos1_total, @etc0_pos2_total, @etc0_pos3_total, @etc0_pos_total = 0,0,0,0  
      @oiletc0s.each do |oiletc0|
        #単位が円のものだけ合計する
        if oiletc0.oiletc_tani == 0 
          @etc0_pos1_total += oiletc0.pos1_data.to_f
          @etc0_pos2_total += oiletc0.pos2_data.to_f 
          @etc0_pos3_total += oiletc0.pos3_data.to_f
          @etc0_pos_total += oiletc0.pos_total.to_f
        end   
      end
    end
 
    #その他商品取得
    oiletc1_sql = m_oiletc_sql(@d_result, 1)
    @oiletc1s = MOiletc.find_by_sql(oiletc1_sql)
    
    
    #その他売上取得
    etc_sql = "select m.id, m.etc_name, m.etc_tani, c.code_name, m.max_num,m.etc_cd, d.id d_result_etc_id, d.no,"
    etc_sql << "      d.pos1_data, d.pos2_data, d.pos3_data,"
    etc_sql << "      COALESCE(d.pos1_data, 0) + COALESCE(d.pos2_data, 0) + COALESCE(d.pos3_data, 0) as pos_total"
    etc_sql << " from m_etcs m left join d_result_etcs d on (m.id = d.m_etc_id"
    if @d_result.blank?
      etc_sql << " and d.d_result_id is null)"
    else
      etc_sql << " and d.d_result_id = #{@d_result.id})"  
    end
    
    etc_sql << " left join m_codes c on (to_number(c.code, '999999999') = m.etc_tani and c.kbn = 'tani')"
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

      #営業POS累計
      @ruikei_eigyos = Array.new
      @m_oil_etcs.each do |m_oil_etc|
        ruikei_sql = "select COALESCE(SUM(c.get_num), 0) get_num_ruikei from d_result_collects c, d_results r"
        ruikei_sql << " where c.d_result_id = r.id and r.m_shop_id = #{@m_shop.id}"
        ruikei_sql << "   and c.m_oiletc_id = #{m_oil_etc.id}"
        ruikei_sql << "   and r.result_date between '#{@result_date[0,6] + '01'}' and '#{@result_date}'"
 
        ruikei = MOiletc.count_by_sql(ruikei_sql)
        @ruikei_eigyos[m_oil_etc.id] = Hash::new
        @ruikei_eigyos[m_oil_etc.id][:ruikei] = MOiletc.count_by_sql(ruikei_sql)
      end    
    
    
    #車検予約カード獲得
    syukei_data(@d_result, @result_date, @m_shop.id)
    
    #夢ポイント
    if @d_result.blank?
      
    else
      sql = yume_sql(@d_result.id)
      @d_result_yumes = DResultOiletc.find_by_sql(sql)
    end
        
    #タンク、メーターとレコードが登録されていない場合は集計を行わない
    unless @d_result.blank?
      meter_count_sql = m_meters_count_sql(@m_shop.id)
      m_meters_count = MMeter.count_by_sql(meter_count_sql)
      d_result_meters_count = DResultMeter.count(:all, :conditions => ["d_result_id = ?", @d_result.id])    

      m_tanks_count = MTank.count(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",@m_shop.id])
      d_result_tanks_count = DResultTank.count(:all, :conditions => ["d_result_id = ?",@d_result.id])   
    end
        
    #油種別メーター集計
    if @d_result.blank? or (m_meters_count != d_result_meters_count) or (m_tanks_count != d_result_tanks_count)
      sql = tank_volume_sql(@m_shop.id)
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
      tank_betu_total(0, @m_shop.id)
    else  
      meter_total(@d_result.id)
      tank_betu_total(@d_result.id, @m_shop.id)
    end    
  end
  
  def d_result_create
    p "d_result_create   d_result_create   d_result_create   d_result_create"
    p "m_shop_id=#{params[:select][:m_shop_id]}"
    m_shop = MShop.find(params[:select][:m_shop_id])
    d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      m_shop.id, params[:select][:result_date]])
    #実績データ作成 
    if d_result.blank?
      d_result = DResult.new
      d_result.result_date = params[:select][:result_date]
      d_result.m_shop_id = m_shop.id
      d_result.kakutei_flg = 0
      d_result.created_user_id = current_user.id      
    end
    d_result.updated_user_id = current_user.id
    d_result.save
    
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

    #油外販売データ作成  油外店のみ作成
    if m_shop.shop_kbn == 1
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
         
        #獲得件数が空白の場合０をセット         
        if params[:get_num]["#{m_oiletc.id}"].blank?
          get_num = 0
        else
          get_num  = params[:get_num]["#{m_oiletc.id}"]  
        end
           
        d_result_collect.get_num = get_num
        d_result_collect.updated_user_id = current_user.id
        d_result_collect.save
      end
    end
        
    #タンク点検フラグ更新
    unless params[:inspect_flg].blank?
      m_tank_sql = "select distinct tank_union_no from m_tanks"
      m_tank_sql << " where m_shop_id = #{m_shop.id} and deleted_flg = 0"
      m_tanks = MTank.find_by_sql(m_tank_sql)

      m_tanks.each do |m_tank|
        up_sql = "update d_tank_compute_reports set inspect_flg = #{params[:inspect_flg]["#{m_tank.tank_union_no}"]}, updated_at = '#{Time.now}'"
        up_sql << " where d_result_id = #{d_result.id} and m_tank_id in"
        up_sql << " (select id from m_tanks where m_shop_id = #{m_shop.id}"
        up_sql << "     and deleted_flg = 0 and tank_union_no = #{m_tank.tank_union_no})"
        ActiveRecord::Base.connection.execute(up_sql)
      end 
    end
      
    #d_tank_compute_reports = DTankComputeReport.find(:all, :conditions => ["d_result_id = ?",d_result.id])
    #unless params[:inspect_flg].blank?
      #d_tank_compute_reports.each do |d_tank_compute_report|
        #d_tank_compute_report.inspect_flg = params[:inspect_flg]["#{d_tank_compute_report.id}"]
        #d_tank_compute_report.save    
      #end
    #end
    
    #消費税取得
    tax_rate = Establish.find(:first).tax_rate
    #前日のd_result_id取得
    day, yesterday = old_result_date(d_result.result_date)
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         d_result.m_shop_id, yesterday])
    #実績表
    if m_shop.shop_kbn == 0
      #セルフ実績表データ
      d_result_self_report = DResultSelfReport.find(:first, :conditions => ["d_result_id = ?", d_result.id])
      
      if d_result_self_report.blank?
        d_result_self_report = DResultSelfReport.new
        d_result_self_report.d_result_id = d_result.id        
      end
      #油種
      d_result_self_report.mo_gas = (session[:m_oil_totals][1][:total].to_f + session[:m_oil_totals][2][:total].to_f).round(1)
      d_result_self_report.keiyu = (session[:m_oil_totals][3][:total].to_f).round(1)
      d_result_self_report.touyu = (session[:m_oil_totals][4][:total].to_f).round(1)   
      #油外
      d_result_self_report.kyuyu_purika = m_oiletc_pos_total(d_result.id, 8, tax_rate)
      d_result_self_report.sensya = m_oiletc_pos_total(d_result.id, 12, tax_rate)
      d_result_self_report.sensya_purika = m_oiletc_pos_total(d_result.id, 11, tax_rate)
      d_result_self_report.sensya_purika_sale = m_oiletc_pos_total(d_result.id, 10, tax_rate)
      d_result_self_report.muton = m_oiletc_pos_total(d_result.id, 22, tax_rate)
      d_result_self_report.sp_plus = m_oiletc_pos_total(d_result.id, 26, tax_rate)
      d_result_self_report.taiyaw = m_oiletc_pos_total(d_result.id, 27, tax_rate)
      d_result_self_report.sp = m_oiletc_pos_total(d_result.id, 9, tax_rate)
      d_result_self_report.sc = m_oiletc_pos_total(d_result.id, 23, tax_rate)
      #他売上
      d_result_self_report.wash_item = m_etc_pos_total(d_result.id, 10, tax_rate)
      d_result_self_report.game = m_etc_pos_total(d_result.id, 12, tax_rate)
      d_result_self_report.health = m_etc_pos_total(d_result.id, 11, tax_rate)
      d_result_self_report.net = m_etc_pos_total(d_result.id, 14, tax_rate)
      d_result_self_report.charge = m_etc_pos_total(d_result.id, 13, tax_rate)
      d_result_self_report.spare = 0
      d_result_self_report.save
    else
      #実績表データ
      d_result_report = DResultReport.find(:first, :conditions => ["d_result_id = ?", d_result.id])
      if old_d_result.blank?
        old_d_result_report = ""
      else  
        old_d_result_report = DResultReport.find(:first, :conditions => ["d_result_id = ?", old_d_result.id])
      end
      
      if d_result_report.blank?
        d_result_report = DResultReport.new
        d_result_report.d_result_id = d_result.id        
      end
      #油種
      d_result_report.mo_gas = (session[:m_oil_totals][1][:total].to_f + session[:m_oil_totals][2][:total].to_f).round(1)
      d_result_report.keiyu = (session[:m_oil_totals][3][:total].to_f).round(1)
      d_result_report.touyu = (session[:m_oil_totals][4][:total].to_f).round(1)
      #油外
      d_result_report.koua = m_oiletc_pos_total(d_result.id, 1, tax_rate)
      d_result_report.buyou = m_oiletc_pos_total(d_result.id, 2, tax_rate)
      d_result_report.tokusei = m_oiletc_pos_total(d_result.id, 3, tax_rate)
      d_result_report.sensya = m_oiletc_pos_total(d_result.id, 4, tax_rate)
      d_result_report.koutin = m_oiletc_pos_total(d_result.id, 5, tax_rate)
      d_result_report.taiya = m_oiletc_pos_total(d_result.id, 6, tax_rate)
      d_result_report.chousei = m_oiletc_pos_total(d_result.id, 28, tax_rate) 
      d_result_report.arari = (d_result_report.koua * 500) + (d_result_report.buyou * 0.3) + (d_result_report.tokusei * 0.7) + (d_result_report.sensya * 0.95) + (d_result_report.koutin * 0.95) + (d_result_report.taiya * 1500) + d_result_report.chousei      
      d_result_report.syaken = m_oiletc_pos_total(d_result.id, 13, tax_rate)
      d_result_report.kyuyu_purika = m_oiletc_pos_total(d_result.id, 8, tax_rate)
      d_result_report.sensya_purika = m_oiletc_pos_total(d_result.id, 11, tax_rate)
      d_result_report.sp = m_oiletc_pos_total(d_result.id, 9, tax_rate)
      d_result_report.sc = m_oiletc_pos_total(d_result.id, 23, tax_rate)
      d_result_report.taiyaw = m_oiletc_pos_total(d_result.id, 27, tax_rate)
      d_result_report.sp_plus = m_oiletc_pos_total(d_result.id, 26, tax_rate)
      d_result_report.atf = m_oiletc_pos_total(d_result.id, 14, tax_rate)
      d_result_report.kousen = m_oiletc_pos_total(d_result.id, 15, tax_rate)
      d_result_report.bt = m_oiletc_pos_total(d_result.id, 17, tax_rate)
      d_result_report.bankin = m_oiletc_pos_total(d_result.id, 7, tax_rate)
      d_result_report.waiper = m_oiletc_pos_total(d_result.id, 18, tax_rate)
      d_result_report.mobil1 = m_oiletc_pos_total(d_result.id, 19, tax_rate)
       
      #前回レコードがない場合、または月初めの場合は累計項目に今回の値を代入
      if old_d_result_report.blank? or day == "01" 
        d_result_report.arari_total = d_result_report.arari
      else
        d_result_report.arari_total = old_d_result_report.arari + d_result_report.arari 
      end
      
      today = Time.parse(d_result.result_date).strftime("%d") 
      month_end_day = Time.parse(d_result.result_date).end_of_month.strftime("%d")   
      d_result_report.oiletc_pace = (d_result_report.arari_total / today.to_i) * month_end_day.to_i
              
      d_result_report.save
    end
  end
  
  def reserve_index
    p "reserve_index   reserve_index   reserve_index   reserve_index   reserve_index"
    p "params[:result_date]=#{params[:result_date]}"
    p "params[:m_shop_id]=#{params[:m_shop_id]}"
    @result_date = params[:result_date]
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      params[:m_shop_id], @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = params[:m_shop_id]
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
    
    if params[:reserve][:get_date].blank?
      get_date = ""
    else
      get_date = params[:reserve][:get_date].delete("/")     
    end

    if get_date.blank?
      @message = "車検予約日は入力必須です。"
    elsif d_result.result_date > get_date
      @message = "車検予約日が獲得日より前になっています。"
    else     
      d_result_reserve = DResultReserve.new
      d_result_reserve.d_result_id = d_result.id
      d_result_reserve.get_date = get_date
      d_result_reserve.reserve_name = params[:reserve][:reserve_name] 
      d_result_reserve.created_user_id = current_user.id
      d_result_reserve.updated_user_id = current_user.id
      d_result_reserve.save
      @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result.id], :order => 'get_date, id')
    
      @result_date = d_result.result_date
      @m_shop = MShop.find(d_result.m_shop_id) 
      #現在月から４ヶ月先までの車検予約実績データ集計
      syukei_data(d_result, '', d_result.m_shop_id)
    end
  end
  
  def reserve_edit
    @d_result_reserve = DResultReserve.find(params[:id])
    #render :layout => 'modal'
  end
  
  def reserve_update
    p "reserve_update   reserve_update   reserve_update   reserve_update"
    d_result_reserve = DResultReserve.find(params[:reserve][:id])
    d_result = DResult.find(d_result_reserve.d_result_id)
    get_date = params[:reserve][:get_date].delete("/")
    
    if d_result.result_date > get_date
      @message = "車検予約日が獲得日より前になっています。"
    else    
      d_result_reserve.get_date = get_date
      d_result_reserve.reserve_name = params[:reserve][:reserve_name]
      d_result_reserve.updated_user_id = current_user.id
      d_result_reserve.save
    
      @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result.id], :order => 'get_date, id')
  
      @result_date = d_result.result_date
      @m_shop = MShop.find(d_result.m_shop_id) 
      #現在月から４ヶ月先までの車検予約実績データ集計
      syukei_data(d_result, '', d_result.m_shop_id)  
    end
  end
  
  def reserve_delete
    d_result_reserve = DResultReserve.find(params[:id])
    d_result = DResult.find(d_result_reserve.d_result_id)
    
    d_result_reserve.destroy
    @d_result_reserves = DResultReserve.find(:all, :conditions => ["d_result_id = ?", d_result.id], :order => 'get_date, id')
    @result_date = d_result.result_date
    @m_shop = MShop.find(d_result.m_shop_id) 
    #現在月から４ヶ月先までの車検予約実績データ集計
    syukei_data(d_result, '', d_result.m_shop_id)  
  end
  
  def yume_index
    p "yume_index   yume_index   yume_index   yume_index   yume_index"
    p "params[:result_date]=#{params[:result_date]}"
    p "params[:m_shop_id]=#{params[:m_shop_id]}"
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      params[:m_shop_id], @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = params[:m_shop_id]
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
    d_result_yume.pos1_data = params[:yume][:kensu]
    d_result_yume.pos2_data = params[:yume][:point]
    d_result_yume.pos3_data = params[:yume][:kingaku] 
    d_result_yume.created_user_id = current_user.id
    d_result_yume.updated_user_id = current_user.id
    d_result_yume.save
   
    sql = yume_sql(d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date
    @m_shop = MShop.find(d_result.m_shop_id) 
  end

  def yume_edit
    @d_result_yume = DResultOiletc.find(params[:id])
  end
  
  def yume_update
    d_result_yume = DResultOiletc.find(params[:yume][:id])
    d_result_yume.pos1_data = params[:yume][:kensu]
    d_result_yume.pos2_data = params[:yume][:point]
    d_result_yume.pos3_data = params[:yume][:kingaku]
    d_result_yume.updated_user_id = current_user.id   
    d_result_yume.save

    d_result = DResult.find(d_result_yume.d_result_id)    
    sql = yume_sql(d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date  
    @m_shop = MShop.find(d_result.m_shop_id)      
  end
  
  def yume_delete
    d_result_yume = DResultOiletc.find(params[:id])
    d_result = DResult.find(d_result_yume.d_result_id)  
    d_result_yume.destroy
    
    sql = yume_sql(d_result.id)
    @d_result_yumes = DResultOiletc.find_by_sql(sql)
    @result_date = d_result.result_date    
    @m_shop = MShop.find(d_result.m_shop_id) 
  end
  
  def meter_index
    p "meter_index   meter_index   meter_index   meter_index   meter_index"
    p "params[:result_date]=#{params[:result_date]}"
    p "params[:m_shop_id]=#{params[:m_shop_id]}"
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      params[:m_shop_id], @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = params[:m_shop_id]
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')
    @m_codes = MCode.find(:all, :conditions => ["kbn = 'pos_class'", :order => 'code'])
  
    #開始時メーター
    day, yesterday = old_result_date(@result_date)
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
          sql << " where m.pos_class = #{m_code.code} and o.id = #{m_oil.id} and t.m_shop_id = #{@d_result.m_shop_id}"
          sql << "  and m.deleted_flg = 0 and t.deleted_flg = 0 and o.deleted_flg = 0"
          sql << " order by m.number"
                              
          old_meter["#{m_oil.id}_#{m_code.code}"] = MOil.find_by_sql(sql)
          old_max_no = old_meter["#{m_oil.id}_#{m_code.code}"].size if old_meter["#{m_oil.id}_#{m_code.code}"].size > old_max_no
        end
      end
    
      for i in 0..old_max_no - 1
        @old_meters[i] = Hash::new
      end
    
      @m_oils.each do |m_oil|
        @m_codes.each do |m_code|
                                      
          old_meter["#{m_oil.id}_#{m_code.code}"].each_with_index do |m_meter, idx|
            @old_meters[idx]["#{m_oil.id}_#{m_code.code}_m_meter_id"] = m_meter.m_meter_id
            @old_meters[idx]["#{m_oil.id}_#{m_code.code}_meter_no"] = m_meter.meter_no
            @old_meters[idx]["#{m_oil.id}_#{m_code.code}_meter"] = m_meter.meter
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
        sql << " where m.pos_class = #{m_code.code} and o.id = #{m_oil.id} and t.m_shop_id = #{@d_result.m_shop_id}"
        sql << "  and m.deleted_flg = 0 and t.deleted_flg = 0 and o.deleted_flg = 0"
        sql << " order by m.number"
                            
        meter["#{m_oil.id}_#{m_code.code}"] = MOil.find_by_sql(sql)
        max_no = meter["#{m_oil.id}_#{m_code.code}"].size if meter["#{m_oil.id}_#{m_code.code}"].size > max_no
      end
    end
    
    @meters = Array::new
    for i in 0..max_no - 1
      @meters[i] = Hash::new
    end
    
    @m_oils.each do |m_oil|
      @m_codes.each do |m_code|
                                      
        meter["#{m_oil.id}_#{m_code.code}"].each_with_index do |m_meter, idx|
          @meters[idx]["#{m_oil.id}_#{m_code.code}_m_meter_id"] = m_meter.m_meter_id
          @meters[idx]["#{m_oil.id}_#{m_code.code}_meter_no"] = m_meter.meter_no
          @meters[idx]["#{m_oil.id}_#{m_code.code}_meter"] = m_meter.meter
        end
      end
    end
        
    if @d_result.kakutei_flg == 1
      @text = true
    else
      @text = false  
    end          
        
    render :layout => 'modal'
  end
  
  def d_result_meter_create
    p "d_result_meter_create   d_result_meter_create   d_result_meter_create"
    #d_result_id = params[:select][:d_result_id]
    d_result = DResult.find(params[:select][:d_result_id])
    
    #メーター登録
    sql = "select m.* from m_meters m, m_tanks t"
    sql << " where m.m_tank_id = t.id and t.m_shop_id = #{d_result.m_shop_id}"

    m_meters = MMeter.find_by_sql(sql)
    m_meters.each do |m_meter|
      d_result_meter = DResultMeter.find(:first, :conditions => ["d_result_id = ? and m_meter_id = ?", d_result.id, m_meter.id])
      
      if d_result_meter.blank?
        d_result_meter = DResultMeter.new
        d_result_meter.d_result_id = d_result.id
        d_result_meter.m_meter_id = m_meter.id
        d_result_meter.created_user_id = current_user.id
        d_result_meter.updated_user_id = current_user.id        
      end
      
      d_result_meter.meter = params[:meter]["#{m_meter.id}"]
      d_result_meter.updated_user_id = current_user.id 
      d_result_meter.save
    end

    @m_tanks_count = MTank.count(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",d_result.m_shop_id])
    @d_result_tanks_count = DResultTank.count(:all, :conditions => ["d_result_id = ?",d_result.id])
  
    #レコード数が等しいなら集計、帳票データ作成を行う。
    if @m_tanks_count == @d_result_tanks_count
      #地下タンク過不足、計算データ作成
      tika_data_create(d_result.id)
    
      #油種別集計
      meter_total(d_result.id)
    
      #タンク別集計
      tank_betu_total(d_result.id, d_result.m_shop_id)
    end
    
    @m_shop = MShop.find(d_result.m_shop_id) 
    @result_date = d_result.result_date
    p "end   end   end   end   end   end   end   end"    
  end
  
  def tank_index
    @result_date = params[:result_date]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      params[:m_shop_id], @result_date])
    
    #実績データ作成 
    if @d_result.blank?
      @d_result = DResult.new
      @d_result.result_date = @result_date
      @d_result.m_shop_id = @d_result.m_shop_id
      @d_result.kakutei_flg = 0
      @d_result.created_user_id = current_user.id
      @d_result.updated_user_id = current_user.id
      @d_result.save
    end
        
    #仕入、在庫データ取得    
    sql = "select t.id m_tank_id, t.tank_no, t.volume, o.oil_name, d.receive, d.stock from m_tanks t"
    sql << " left join d_result_tanks d on (t.id = d.m_tank_id and d.d_result_id = #{@d_result.id})"
    sql << " left join m_oils o on (t.m_oil_id = o.id)"
    sql << " where t.m_shop_id = #{@d_result.m_shop_id} and t.deleted_flg = 0 and o.deleted_flg = 0 "
    sql << " order by t.tank_no"
                                            
    @m_tanks = MTank.find_by_sql(sql)
        
    if @d_result.kakutei_flg == 1
      @text = true
    else
      @text = false  
    end    
        
    render :layout => 'modal'
  end  

  def d_result_tank_create
    p "d_result_tank_create   d_result_tank_create   d_result_tank_create"
    #d_result_id = params[:select][:d_result_id]
    d_result = DResult.find(params[:select][:d_result_id])
    
    #タンク在庫登録
    m_tanks = MTank.find(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",d_result.m_shop_id])
    m_tanks.each do |m_tank|
      d_result_tank = DResultTank.find(:first, :conditions => ["d_result_id = ? and m_tank_id = ?", d_result.id, m_tank.id])
      
      if d_result_tank.blank?
        d_result_tank = DResultTank.new
        d_result_tank.d_result_id = d_result.id
        d_result_tank.m_tank_id = m_tank.id
        d_result_tank.created_user_id = current_user.id
        d_result_tank.updated_user_id = current_user.id           
      end
      
      d_result_tank.receive = params[:receive]["#{m_tank.id}"]
      d_result_tank.stock = params[:stock]["#{m_tank.id}"]     
      d_result_tank.updated_user_id = current_user.id 
      d_result_tank.save      
    end  
    
    sql = m_meters_count_sql(d_result.m_shop_id)
    @m_meters_count = MMeter.count_by_sql(sql)
    @d_result_meters_count = DResultMeter.count(:all, :conditions => ["d_result_id = ?", d_result.id]) 
    
    #レコード数が等しいなら集計、帳票データ作成を行う。
    if @m_meters_count == @d_result_meters_count
      #地下タンク過不足、計算データ作成
      tika_data_create(d_result.id)
    
      #油種別集計
      meter_total(d_result.id)
    
      #タンク別集計
      tank_betu_total(d_result.id, d_result.m_shop_id)
    end
    
    
    @result_date = d_result.result_date   
    @m_shop = MShop.find(d_result.m_shop_id) 
  end
  
  def oil_total_set
    session[:m_oil_totals][params[:oil].to_i][:total] = params[:oil_total]  

    head :ok
  end
end