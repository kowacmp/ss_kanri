# -*- coding:utf-8 -*-
class DResultsController < ApplicationController
  include DResultsHelper

  def index
    if params[:result_date].blank?
      # UPDATE 2012.09.29 日付の規定値を前日に変更
      #@today = Time.now.strftime("%Y/%m/%d")
      @today = (Time.now - 60*60*24).strftime("%Y/%m/%d")
      # UPDATE 2012.09.29 日付の規定値を前日に変更
      #sql = result_index_sql(Time.now.prev_day.strftime("%Y%m%d"), '')   
      sql = result_index_sql(@today.delete("/"), '')
    else
      @today = params[:result_date][0,4] + "/" + params[:result_date][4,2] + "/" + params[:result_date][6,2]
      sql = result_index_sql(params[:result_date], '')
      @flg = 1     
    end
    
    @m_shops = MShop.find_by_sql(sql)
  end
  
  def index_select
    select_date = params[:select_date].delete("/")
  
    sql = result_index_sql(select_date, params[:select_shop_kbn])
    @m_shops = MShop.find_by_sql(sql)
  end
  
  #ロック／解除
  def lock
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
      format.html { render :partial => 'result'}
    end
  end  

  def new
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"])
    @etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0 and kansa_flg = 1"])
    @m_oiletc0_pos_totals = MOiletc.find_by_sql(m_oiletc0_en_pos_total_sql)
    
    session[:m_oil_totals] = Array::new                 
    @m_oils.each do |m_oil|
      session[:m_oil_totals][m_oil.id] = Hash::new
      session[:m_oil_totals][m_oil.id][:total] = 0
    end  
       
    if params[:d_result_id].blank?
      # UPDATE 2012.09.29
      #直接実績データ入力に来た場合はログイン所属、今日の日付がデフォルト
      #@d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
      #                                                current_user.m_shop_id, Time.now.strftime("%Y%m%d")])
      #@today = Time.now.strftime("%Y/%m/%d")
      @today = (Time.now - 60*60*24).strftime("%Y/%m/%d")
      @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      current_user.m_shop_id, @today])      
      @m_shop_id = current_user.m_shop_id
    else
      #実績データ入力状況確認から来た場合は値をセット
      @d_result = DResult.find(params[:d_result_id])
      @today = @d_result.result_date[0,4] + "/" + @d_result.result_date[4,2] + "/" + @d_result.result_date[6,2]
      @m_shop_id = @d_result.m_shop_id
      @edit_flg = 1
    end
    
    m_shop = MShop.find(@m_shop_id)
    @m_oiletcs = MOiletc.find(:all, :conditions => ["(shop_kbn is null or shop_kbn = ?) and oiletc_group <> 0 and deleted_flg = 0",
                                                      m_shop.shop_kbn])
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
      @edit_flg = params[:edit_flg]
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
p "oil_sql=#{oil_sql}"
    @pos1_gasorin, @pos2_gasorin, @pos3_gasorin, @total_gasorin = 0,0,0,0
    @pos1_mofuel, @pos2_mofuel, @pos3_mofuel, @total_mofuel = 0,0,0,0
    
    @oil_ruikeis = Array.new
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
      
      @oil_ruikeis[m_oil.id] = Hash::new
      @oil_ruikeis[m_oil.id][:oil_ruikei] = 0              
    end
   
    @pos1_gasorin = @pos1_gasorin.round(2)
    @pos2_gasorin = @pos2_gasorin.round(2)
    @pos3_gasorin = @pos3_gasorin.round(2)
    @total_gasorin = @total_gasorin.round(2)
    @pos1_mofuel = @pos1_mofuel.round(2)
    @pos2_mofuel = @pos2_mofuel.round(2)
    @pos3_mofuel = @pos3_mofuel.round(2)
    @total_mofuel = @total_mofuel.round(2)
    
    #出荷数量累計
    oil_total_sql = "select d.m_oil_id, COALESCE(sum(d.pos1_data), 0) + COALESCE(sum(d.pos2_data), 0) +"
    oil_total_sql << "      COALESCE(sum(d.pos3_data), 0) as oil_ruikei"
    oil_total_sql << " from d_results r, d_result_oils d"
    oil_total_sql << " where result_date >= '#{@result_date[0,6] + "01"}' and result_date <= '#{@result_date}'"
    oil_total_sql << "  and m_shop_id = #{@m_shop.id} and r.id = d.d_result_id group by d.m_oil_id"
   
    @ruikei_gasorin = 0
    @ruikei_mofuel = 0
    oil_ruikeis = MOil.find_by_sql(oil_total_sql)
    oil_ruikeis.each do |oil_ruikei|
      @oil_ruikeis[oil_ruikei.m_oil_id.to_i][:oil_ruikei] = oil_ruikei.oil_ruikei
      @ruikei_gasorin += oil_ruikei.oil_ruikei.to_f if oil_ruikei.m_oil_id.to_i == 1 or oil_ruikei.m_oil_id.to_i == 2
      @ruikei_mofuel += oil_ruikei.oil_ruikei.to_f if oil_ruikei.m_oil_id.to_i != 4
    end
    @ruikei_gasorin = @ruikei_gasorin.round(2)
    @ruikei_mofuel = @ruikei_mofuel.round(2)
    
    #油外商品取得
    @oiletcs = MOiletc.find_by_sql(m_oiletc_sql(@d_result, @m_shop.shop_kbn))
    
    #油外商品累計
    @arari_nikkei = 0
    @oiletc_ruikeis = Array.new
    @oiletcs.each do |oiletc|
      @oiletc_ruikeis[oiletc.id] = Hash::new
      @oiletc_ruikeis[oiletc.id][:oiletc_ruikei] = 0
      @oiletc_ruikeis[oiletc.id][:arari_ruikei] = 0
      @arari_nikkei += oiletc.oiletc_arari.to_i
    end    

    oiletc_ruikeis = MOiletc.find_by_sql(m_oiletc_ruikei_sql(@m_shop.id, @result_date, @m_shop.shop_kbn))
    
    @arari_ruikei = 0   
    oiletc_ruikeis.each do |oiletc_ruikei|
      @oiletc_ruikeis[oiletc_ruikei.id][:oiletc_ruikei] = oiletc_ruikei.oiletc_ruikei
      @oiletc_ruikeis[oiletc_ruikei.id][:arari_ruikei] = oiletc_ruikei.arari_ruikei
      @arari_ruikei += oiletc_ruikei.arari_ruikei.to_i
    end  
    #粗利累計は選択日付前日の累計を取得する為(javascriptの都合上)、日計を加算する
    @arari_ruikei += @arari_nikkei

=begin 2012/09/24 nishimura マスタ統合による修正      
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

    #その他売上累計
    @etc_ruikeis = Array.new
    @m_etcs.each do |etc|
      @etc_ruikeis[etc.id] = Hash::new
      @etc_ruikeis[etc.id][:etc_ruikei] = 0
    end      
    
    etc_total_sql = "select d.m_etc_id, COALESCE(sum(d.pos1_data), 0) + COALESCE(sum(d.pos2_data), 0) + "
    etc_total_sql << "      COALESCE(sum(d.pos3_data), 0) as etc_ruikei"
    etc_total_sql << " from d_results r, d_result_etcs d"
    etc_total_sql << " where result_date >= '#{@result_date[0,6] + "01"}' and result_date <= '#{@result_date}'"
    etc_total_sql << "   and m_shop_id = #{@m_shop.id} and r.id = d.d_result_id group by d.m_etc_id"
    
    etc_ruikeis = MOil.find_by_sql(etc_total_sql)
    etc_ruikeis.each do |etc_ruikei|
      @etc_ruikeis[etc_ruikei.m_etc_id.to_i][:etc_ruikei] = etc_ruikei.etc_ruikei
    end    
=end
    
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
      @d_result_yumepoints = ""
    else
      @d_result_yumepoints = DResultOiletc.find_by_sql(yume_sql(@d_result.id))
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
    ActiveRecord::Base.transaction do    
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
    end#transuction
    
    #油外商品データ作成
    m_oiletcs = MOiletc.find(:all, :conditions => ["(shop_kbn is null or shop_kbn = ?) and oiletc_group <> 0 and deleted_flg = 0",
                                                      m_shop.shop_kbn])
    ActiveRecord::Base.transaction do
      m_oiletcs.each do |m_oiletc|
        d_result_oiletc = DResultOiletc.find(:first, :conditions => ["d_result_id = ? and m_oiletc_id = ?", d_result.id, m_oiletc.id])
       
        if d_result_oiletc.blank?
          d_result_oiletc = DResultOiletc.new
          d_result_oiletc.d_result_id = d_result.id
          d_result_oiletc.m_oiletc_id = m_oiletc.id
          d_result_oiletc.created_user_id = current_user.id       
        end
             
        d_result_oiletc.pos1_data = params[:oiletc_pos1]["#{m_oiletc.id}"]
        d_result_oiletc.pos2_data = params[:oiletc_pos2]["#{m_oiletc.id}"]
        d_result_oiletc.pos3_data = params[:oiletc_pos3]["#{m_oiletc.id}"]
  #      total = d_result_oiletc.pos1_data.to_f + d_result_oiletc.pos2_data.to_f + d_result_oiletc.pos3_data.to_f
  #      d_result_oiletc.oiletc_arari = total.round(2) * m_oiletc.oiletc_arari
        total = (d_result_oiletc.pos1_data.to_f * 100) + (d_result_oiletc.pos2_data.to_f * 100) + (d_result_oiletc.pos3_data.to_f * 100)
        d_result_oiletc.oiletc_arari = total * m_oiletc.oiletc_arari / 100
        d_result_oiletc.updated_user_id = current_user.id
        d_result_oiletc.save
      end
    end#transuction

=begin 2012/09/24 nishimura マスタ統合による修正          
    #その他売上データ作成
    m_etcs = MEtc.find(:all, :conditions => ["deleted_flg = 0 and kansa_flg = 1"])     
    ActiveRecord::Base.transaction do
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
    end#transuction
=end
    
    #車検予約、営業POS伝回収報告作成  油外店舗のみ作成
    if m_shop.shop_kbn == 1
      ymd = Time.parse(d_result.result_date)
      for i in 0..4
        ym = (ymd + i.months).strftime("%Y%m")
        mon = (ymd + i.months).strftime("%m")

        d_result_reserve = DResultReserve.find(:first, :conditions => ["d_result_id = ? and reserve_nengetu = ?",
                                                                        d_result.id, ym])
        if d_result_reserve.blank?
          d_result_reserve = DResultReserve.new
          d_result_reserve.d_result_id = d_result.id
          d_result_reserve.reserve_nengetu = ym    
          d_result_reserve.created_user_id = current_user.id  
        end 
              
        d_result_reserve.reserve_num = params[:reserve_num][mon].to_i
        d_result_reserve.updated_user_id = current_user.id                                                        
        d_result_reserve.save
      end
      
      m_oiletcs = MOiletc.find(:all, :conditions => ["oiletc_trade = 1 and deleted_flg = 0"])
      ActiveRecord::Base.transaction do
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
      end#transuction
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
      d_result_self_report.sensya = m_oiletc_pos_total(d_result.id, 33, tax_rate)
      d_result_self_report.sensya_purika = m_oiletc_pos_total(d_result.id, 11, tax_rate)
      d_result_self_report.sensya_purika_sale = m_oiletc_pos_total(d_result.id, 34, tax_rate)
      d_result_self_report.muton = m_oiletc_pos_total(d_result.id, 22, tax_rate)
      d_result_self_report.sp_plus = m_oiletc_pos_total(d_result.id, 26, tax_rate)
      d_result_self_report.taiyaw = m_oiletc_pos_total(d_result.id, 27, tax_rate)
      d_result_self_report.sp = m_oiletc_pos_total(d_result.id, 9, tax_rate)
      d_result_self_report.sc = m_oiletc_pos_total(d_result.id, 23, tax_rate)
      d_result_self_report.cb = m_oiletc_pos_total(d_result.id, 24, tax_rate)
      #他売上
      #2012/09/24 nishimura マスタ統合による修正 <<<
      #d_result_self_report.wash_item = m_etc_pos_total(d_result.id, 10, tax_rate)
      #d_result_self_report.game = m_etc_pos_total(d_result.id, 12, tax_rate)
      #d_result_self_report.health = m_etc_pos_total(d_result.id, 11, tax_rate)
      #d_result_self_report.net = m_etc_pos_total(d_result.id, 14, tax_rate)
      #d_result_self_report.charge = m_etc_pos_total(d_result.id, 13, tax_rate)
      #d_result_self_report.ozone = m_etc_pos_total(d_result.id, 15, tax_rate)
      #d_result_self_report.spare = 0
      d_result_self_report.wash_item = m_oiletc_pos_total(d_result.id, 35, tax_rate)
      d_result_self_report.game = m_oiletc_pos_total(d_result.id, 36, tax_rate)
      d_result_self_report.health = m_oiletc_pos_total(d_result.id, 37, tax_rate)
      d_result_self_report.net = m_oiletc_pos_total(d_result.id, 38, tax_rate)
      d_result_self_report.charge = m_oiletc_pos_total(d_result.id, 39, tax_rate)
      d_result_self_report.ozone = m_oiletc_pos_total(d_result.id, 40, tax_rate)
      d_result_self_report.spare = 0
      #2012/09/24 nishimura マスタ統合による修正 >>>
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
      sensya_genkin = m_oiletc_pos_total(d_result.id, 12, tax_rate)
      sensya_purika_goukei = m_oiletc_pos_total(d_result.id, 10, tax_rate)
      arari = d_result_report_arari_get(d_result.id)
      
      d_result_report.koua = m_oiletc_pos_total(d_result.id, 1, tax_rate)
      d_result_report.buyou = m_oiletc_pos_total(d_result.id, 2, tax_rate)
      d_result_report.tokusei = m_oiletc_pos_total(d_result.id, 3, tax_rate)    
      #2012/10/01 nishimura
      #d_result_report.sensya = sensya_genkin.to_i + sensya_purika_goukei.to_i
      d_result_report.sensya = m_oiletc_pos_total(d_result.id, 4, tax_rate)
      
      d_result_report.koutin = m_oiletc_pos_total(d_result.id, 5, tax_rate)
      d_result_report.taiya = m_oiletc_pos_total(d_result.id, 6, tax_rate)
      d_result_report.chousei = m_oiletc_pos_total(d_result.id, 28, tax_rate)      
      d_result_report.arari = arari.to_i #+ d_result_report.chousei   #2012/10/02 nishimura del   
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
    
#    params[:select_date] = params[:select][:result_date]
#    params[:m_shop_id] = params[:select][:m_shop_id]
#    params[:edit_flg] = params[:select][:edit_flg]
#    select_date
  end
  
  def yume_index
    @result_date = params[:result_date]
    @m_shop_id = params[:m_shop_id]
    d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      params[:m_shop_id], @result_date])

    if d_result.blank?
      @d_result_yumepoints = ""
    else     
      @d_result_yumepoints = DResultYumepoint.find_by_sql(yume_sql(d_result.id))        
    end
      
    render :layout => 'modal'
  end
  
  def yume_new
    @result_date = params[:result_date]
    @m_shop_id = params[:m_shop_id]
  end
  
  def yume_create
    yume_check(params[:yume])
    if @message.blank?
      d_result_check(params[:result_date], params[:m_shop_id])
      establish = Establish.find(:first)

      d_result_yumepoint = DResultYumepoint.new
      d_result_yumepoint.d_result_id = @d_result.id
      d_result_yumepoint.yumepoint_class = params[:yume][:yumepoint_class] 
      d_result_yumepoint.yumepoint_num = params[:yume][:yumepoint_num] 
      d_result_yumepoint.yumepoint = params[:yume][:yumepoint] 
      d_result_yumepoint.yumepoint_money = params[:yume][:yumepoint_money]
      d_result_yumepoint.pay_money = (params[:yume][:yumepoint_num].to_f * establish.yumepoint_cost).truncate
      d_result_yumepoint.created_user_id = current_user.id
      d_result_yumepoint.updated_user_id = current_user.id
      d_result_yumepoint.save
    
      yume_data_set(@d_result)
    end
  end

  def yume_edit
    @d_result_yumepoint = DResultYumepoint.find(params[:id])
  end
  
  def yume_update
    yume_check(params[:yume])
    if @message.blank?
      establish = Establish.find(:first)  
      d_result_yumepoint = DResultYumepoint.find(params[:id])
    
      d_result_yumepoint.yumepoint_class = params[:yume][:yumepoint_class] 
      d_result_yumepoint.yumepoint_num = params[:yume][:yumepoint_num] 
      d_result_yumepoint.yumepoint = params[:yume][:yumepoint] 
      d_result_yumepoint.yumepoint_money = params[:yume][:yumepoint_money] 
      d_result_yumepoint.pay_money = (params[:yume][:yumepoint_num].to_f * establish.yumepoint_cost).truncate
      d_result_yumepoint.updated_user_id = current_user.id
      d_result_yumepoint.save

      d_result = DResult.find(d_result_yumepoint.d_result_id)
      yume_data_set(d_result)
    end
  end
  
  def yume_delete
    d_result_yumepoint = DResultYumepoint.find(params[:id])
    d_result = DResult.find(d_result_yumepoint.d_result_id)  
    d_result_yumepoint.destroy

    yume_data_set(d_result)
  end
  
  def meter_index
    @result_date = params[:result_date]
    @edit_flg = params[:edit_flg]
    @m_shop_id = params[:m_shop_id]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      @m_shop_id, @result_date])
    if @d_result.blank?
      d_result_id = 0
    else
      d_result_id = @d_result.id  
    end
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = 0"], :order => 'oil_cd')
    @m_codes = MCode.find(:all, :conditions => ["kbn = 'pos_class'", :order => 'code'])
  
    #開始時メーター
    day, yesterday = old_result_date(@result_date)
    old_d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                         @m_shop_id, yesterday])
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
          sql << " where m.pos_class = #{m_code.code} and o.id = #{m_oil.id} and t.m_shop_id = #{@m_shop_id}"
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
        sql << " left join d_result_meters d on (m.id = d.m_meter_id and d.d_result_id = #{d_result_id})"
        sql << " left join m_tanks t on (m.m_tank_id = t.id)"
        sql << " left join m_oils o on (t.m_oil_id = o.id)"
        sql << " where m.pos_class = #{m_code.code} and o.id = #{m_oil.id} and t.m_shop_id = #{@m_shop_id}"
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
        
    if @d_result.blank? or @edit_flg.to_i == 1 or @d_result.kakutei_flg == 0
      @text = false 
    else
      @text = true
    end         
        
    render :layout => 'modal'
  end
  
  def d_result_meter_create
    d_result_check(params[:result_date], params[:m_shop_id])
    
    #メーター登録
    sql = "select m.* from m_meters m, m_tanks t"
    sql << " where m.m_tank_id = t.id and t.m_shop_id = #{@d_result.m_shop_id}"

    m_meters = MMeter.find_by_sql(sql)
    ActiveRecord::Base.transaction do
      m_meters.each do |m_meter|
        d_result_meter = DResultMeter.find(:first, :conditions => ["d_result_id = ? and m_meter_id = ?", @d_result.id, m_meter.id])
        
        if d_result_meter.blank?
          d_result_meter = DResultMeter.new
          d_result_meter.d_result_id = @d_result.id
          d_result_meter.m_meter_id = m_meter.id
          d_result_meter.created_user_id = current_user.id
          d_result_meter.updated_user_id = current_user.id        
        end
        
        d_result_meter.meter = params[:meter]["#{m_meter.id}"]
        d_result_meter.updated_user_id = current_user.id 
        d_result_meter.save
      end
    end#transuction

    @m_tanks_count = MTank.count(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",@d_result.m_shop_id])
    @d_result_tanks_count = DResultTank.count(:all, :conditions => ["d_result_id = ?",@d_result.id])
  
    #レコード数が等しいなら集計、帳票データ作成を行う。
    if @m_tanks_count == @d_result_tanks_count
      #地下タンク過不足、計算データ作成
      tika_data_create(@d_result.id)
    
      #油種別集計
      meter_total(@d_result.id)
    
      #タンク別集計
      tank_betu_total(@d_result.id, @d_result.m_shop_id)
    end
    
    @edit_flg = params[:edit_flg]
    @m_shop = MShop.find(@d_result.m_shop_id) 
    @result_date = @d_result.result_date  
    
  end
  
  def tank_index
    @result_date = params[:result_date]
    @edit_flg = params[:edit_flg]
    @m_shop_id = params[:m_shop_id]
    
    @d_result = DResult.find(:first, :conditions => ["m_shop_id = ? and result_date = ?",
                                                      @m_shop_id, @result_date])
                                                      
    if @d_result.blank?
      d_result_id = 0
    else
      d_result_id = @d_result.id  
    end
        
    #仕入、在庫データ取得    
    sql = "select t.id m_tank_id, t.tank_no, t.volume, o.oil_name, d.receive, d.stock from m_tanks t"
    sql << " left join d_result_tanks d on (t.id = d.m_tank_id and d.d_result_id = #{d_result_id})"
    sql << " left join m_oils o on (t.m_oil_id = o.id)"
    sql << " where t.m_shop_id = #{@m_shop_id} and t.deleted_flg = 0 and o.deleted_flg = 0 "
    sql << " order by t.tank_no"
                                    
    @m_tanks = MTank.find_by_sql(sql)

    if @d_result.blank? or @edit_flg.to_i == 1 or @d_result.kakutei_flg == 0
      @text = false 
    else
      @text = true
    end    
        
    render :layout => 'modal'
  end  

  def d_result_tank_create
    d_result_check(params[:result_date], params[:m_shop_id])
    
    #タンク在庫登録
    m_tanks = MTank.find(:all, :conditions => ["m_shop_id = ? and deleted_flg = 0",@d_result.m_shop_id])
    ActiveRecord::Base.transaction do
      m_tanks.each do |m_tank|
        d_result_tank = DResultTank.find(:first, :conditions => ["d_result_id = ? and m_tank_id = ?", @d_result.id, m_tank.id])
      
        if d_result_tank.blank?
          d_result_tank = DResultTank.new
          d_result_tank.d_result_id = @d_result.id
          d_result_tank.m_tank_id = m_tank.id
          d_result_tank.created_user_id = current_user.id
          d_result_tank.updated_user_id = current_user.id           
        end
      
        d_result_tank.receive = params[:receive]["#{m_tank.id}"]
        d_result_tank.stock = params[:stock]["#{m_tank.id}"]     
        d_result_tank.updated_user_id = current_user.id 
        d_result_tank.save      
      end  
  end#transuction
    sql = m_meters_count_sql(@d_result.m_shop_id)
    @m_meters_count = MMeter.count_by_sql(sql)
    @d_result_meters_count = DResultMeter.count(:all, :conditions => ["d_result_id = ?", @d_result.id]) 
    
    #レコード数が等しいなら集計、帳票データ作成を行う。
    if @m_meters_count == @d_result_meters_count
      #地下タンク過不足、計算データ作成
      tika_data_create(@d_result.id)
    
      #油種別集計
      meter_total(@d_result.id)
    
      #タンク別集計
      tank_betu_total(@d_result.id, @d_result.m_shop_id)
    end
    
    @edit_flg = params[:edit_flg]
    @result_date = @d_result.result_date   
    @m_shop = MShop.find(@d_result.m_shop_id) 
  end
  
  def oil_total_set
    session[:m_oil_totals][params[:oil].to_i][:total] = params[:oil_total]  

    head :ok
  end
  
  #2012/09/25 nisimura メーター入力再表示
  def d_resit_meter_reload
    meter_index
  end
  
end