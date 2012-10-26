# -*- coding:utf-8 -*-
class DWashpurikaReportsController < ApplicationController

  def index

    # 引数より入力、照会を取得
    if params[:mode] == "edit" then
      session[:washpurika_mode] = "edit"     
    else
      session[:washpurika_mode] = "show"   
    end
    
  end

  def show

    @d_washpurika_reports = read_d_washpurika_reports(params[:header][:y] + params[:header][:m])
    @days = Time.days_in_month(params[:header][:m].to_i, params[:header][:y].to_i)

  end

  def edit

    @d_washpurika_reports = create_d_washpurika_reports(params[:header][:y] + params[:header][:m])
    @days = Time.days_in_month(params[:header][:m].to_i, params[:header][:y].to_i)

  end
  
  def update

    DWashpurikaReport.transaction { #begin trans
        
    cnt = 1
    until params["data#{cnt}"].nil? do
      
      rec = params["data#{cnt}"]
      
      d_washpurika_report = DWashpurikaReport.find(:first, 
                                                   :conditions => ["date=? and m_shop_id=?",
                                                     rec[:date],
                                                     rec[:m_shop_id]])
      
      if d_washpurika_report.nil? then
        d_washpurika_report = DWashpurikaReport.new()
        d_washpurika_report.created_user_id = current_user.id
      end
                                                     
      d_washpurika_report.attributes = rec
      d_washpurika_report.updated_user_id = current_user.id
      if params[:update][:rezero].to_s == "true" then
        d_washpurika_report.total_point = params["data_#{cnt}"][:up_point]
      end
      
      d_washpurika_report.save!
      
      cnt += 1
    end
    
    } # commit
    
    redirect_to :action => "edit", :header => {:y => params[:hheader][:y],
                                               :m => params[:hheader][:m]}
    
  end
  
private

  # 洗車プリカ販売
  def read_d_washpurika_reports(ym)
    
    # 戻り値の配列設定
    ret = Array.new()
    
    # 前月を取得
    if ym[4..5] == "01" then
      zym = (ym[0..3].to_i - 1).to_s + "12"
    else
      zym = ym[0..3] + sprintf("%02d", (ym[4..5].to_i - 1)) 
    end

    # 今月のデータがなければ中断
    if DWashpurikaReport.count(:conditions => ["date=?", ym]).to_i == 0 then
      return ret
    end
    
    # 前月のデータを取得
    washpurika_reports = DWashpurikaReport.find(:all, 
                                                :conditions => ["date=?", zym],
                                                :order => "league, rank")
                                                
    for rec in washpurika_reports
    
      # 今月データを読込
      washpurika_report = DWashpurikaReport.find(:first,
                                                 :conditions => ["date=? and m_shop_id=?",
                                                   ym, rec.m_shop_id])
    
    
      ret_rec = Hash.new()
    
      ret_rec["date"] = ym
      ret_rec["m_shop_id"]     = rec.m_shop_id
      ret_rec["dsp_league"]    = rec.before_league #DBに存在しない項目
      ret_rec["dsp_rank"]      = rec.before_rank   #DBに存在しない項目
      ret_rec["z_total_rank"]  = rec.total_rank    #DBに存在しない項目
      ret_rec["total_rank"]    = washpurika_report.total_rank
      ret_rec["before_league"] = rec.league
      ret_rec["league"] = washpurika_report.league
      ret_rec["before_rank"] = rec.rank
      ret_rec["rank"] = washpurika_report.rank
      ret_rec["before_total_point"] = rec.total_point
      ret_rec["total_point"] = washpurika_report.total_point
    
      for d in 1..31
        ret_rec["result#{ d }"] = washpurika_report["result#{ d }"]
        ret_rec["uriage#{ d }"] = washpurika_report["uriage#{ d }"]
      end
      
      ret_rec["result_total"] = washpurika_report.result_total
      ret_rec["uriage_total"] = washpurika_report.uriage_total
      ret_rec["pace"] = washpurika_report.pace
      ret_rec["same_pace"] = washpurika_report.same_pace
      ret_rec["same_uriage"] = washpurika_report.same_uriage
      ret_rec["same_uriage_total"] = washpurika_report.same_uriage_total
      ret_rec["same_uriage_total_max"] = washpurika_report.same_uriage_total_max
      
      ret.push ret_rec

    end 
 
    return ret
 
  end
    
  # 洗車プリカ販売目標データ作成
  def create_d_washpurika_reports(ym)
    
    # 戻り値の配列設定
    ret = Array.new()

    # 前月を取得
    if ym[4..5] == "01" then
      zym = (ym[0..3].to_i - 1).to_s + "12"
    else
      zym = ym[0..3] + sprintf("%02d", (ym[4..5].to_i - 1)) 
    end
    
    # 前月のデータを取得
    washpurika_reports = DWashpurikaReport.find(:all, 
                                                :conditions => ["date=?", zym],
                                                :order => "league, rank")
        
    for rec in washpurika_reports
    
      ret_rec = Hash.new()
      
      ret_rec["date"] = ym
      ret_rec["m_shop_id"]    = rec.m_shop_id
      ret_rec["dsp_league"]   = rec.before_league  #DBに存在しない項目
      ret_rec["dsp_rank"]     = rec.before_rank    #DBに存在しない項目
      ret_rec["z_total_rank"] = rec.total_rank     #DBに存在しない項目
      ret_rec["total_rank"] = 0
      ret_rec["before_league"] = rec.league
      ret_rec["league"] = 0
      ret_rec["before_rank"] = rec.rank
      ret_rec["rank"] = 0
      ret_rec["before_total_point"] = rec.total_point
      ret_rec["total_point"] = 0
      
      result_total = 0
      result_days = 0
      result_max_day = 0
      uriage_total = 0
      
      for d in 1..31
        
        # 売上枚数取得
        sql = "
          select
                 coalesce(b.pos1_data, 0) 
               + coalesce(b.pos2_data, 0)
               + coalesce(b.pos3_data, 0) as pos_data
          from
                     d_results        a 
           left join d_result_oiletcs b
          on 
              a.id = b.d_result_id
          where
                a.result_date = '#{ym + sprintf('%02d', d)}'
            and a.m_shop_id   =  #{rec.m_shop_id}
            and b.m_oiletc_id =  11 --11:洗車プリカ枚数
        "
      
        d_result = DResult.find_by_sql(sql)
          
        if d_result.length == 0 then
          ret_rec["result#{ d }"] = nil
        else
          ret_rec["result#{ d }"] = d_result[0].pos_data.to_i
          result_total += d_result[0].pos_data.to_i
          result_days += 1
          result_max_day = d
        end
      
        # 売上金額取得
        sql = "
          select
               coalesce(b.pos1_data, 0) 
             + coalesce(b.pos2_data, 0)
             + coalesce(b.pos3_data, 0) as pos_data
          from
                      d_results        a 
           left  join d_result_oiletcs b
          on 
              a.id = b.d_result_id
          where
                a.result_date = '#{ym + sprintf('%02d', d)}'
            and a.m_shop_id   =  #{rec.m_shop_id}
           and b.m_oiletc_id =  34 --34:洗車プリカ売上金額(洗車型)
        "
      
        d_uriage = DResult.find_by_sql(sql)
        if d_uriage.length == 0 then
          ret_rec["uriage#{ d }"] = nil
        else
          ret_rec["uriage#{ d }"] = d_uriage[0].pos_data.to_i
          uriage_total += d_uriage[0].pos_data.to_i
        end
      
    end # for d in 1..31
    
    ret_rec["result_total"]   = result_total   #枚数1～31計
    ret_rec["result_days"]    = result_days    #実績入力日数
    ret_rec["result_max_day"] = result_max_day #実績入力最終日
    ret_rec["uriage_total"]   = uriage_total   #売上1～31計
    
    # ペース
    if result_days == 0 then
      ret_rec["pace"] = 0
    else
      ret_rec["pace"] = uriage_total / result_days * Time.days_in_month(ym[4..5].to_i, ym[0..3].to_i)
    end
    
    # 前年同月データを読込
    zennen = DWashpurikaReport.find(:first, 
                                    :conditions => ["date=? and m_shop_id=?",
                                          (ym[0..3].to_i - 1).to_s + ym[4..5],
                                          rec.m_shop_id])
    
    # 前年同日迄のペース
    if zennen.nil? then
      ret_rec["same_pace"] = 0
    else
      z_uriage_total = 0
      z_result_days  = 0
      for i in 1..result_max_day
        if not(zennen["uriage#{ i }"].nil?) then
          z_uriage_total += zennen["uriage#{ i }"]
          z_result_days += 1
        end
      end  
      
      if z_result_days == 0 then
          ret_rec["same_pace"] = 0
      else
          ret_rec["same_pace"] = z_result_days / z_result_days * Time.days_in_month(ym[4..5].to_i, ym[0..3].to_i - 1)
      end
        
    end
      
    # 前年同日迄の実績
    if zennen.nil? then
      ret_rec["same_uriage"] = 0
    else
      same_uriage = 0
      for i in 1..result_max_day
        if not(zennen["uriage#{ i }"].nil?) then
          same_uriage += zennen["uriage#{ i }"]
        end
      end
        
      ret_rec["same_uriage"] = same_uriage

    end
      
    # 前年同月末実績
    if zennen.nil? then
      ret_rec["same_uriage_total"] = 0
    else
      ret_rec["same_uriage_total"] = zennen["uriage_total"]
    end
        
    # 同月過去最高実績
    ret_rec["same_uriage_total_max"] = DWashpurikaReport.maximum(:uriage_total, 
                                                              :conditions => ["m_shop_id=? and date < ? and date like ?",
                                                                rec.m_shop_id,
                                                                ym,
                                                                "%" + ym[4..5]])
    
    
    ret_rec["same_uriage_total_max"] = 0 if ret_rec["same_uriage_total_max"].nil?
    
    ret.push ret_rec
      
   end # for rec in @washpurika_reports    
 
   # 今月当初リーグ、今月売上の降順でソート
   ret = ret.sort{|a,b| sort_func(a, b, "before_league, uriage_total desc")}
 
   # ①今月当初リーグ、今月売上の降順で順位をつける
   rank = 0
   for rec in ret
     rank += 1
     if rank > 5 then
       rank = 1
     end
     
     rec["league"] = rec["before_league"]
     rec["rank"] = rank
     
   end
 
   # ①でつけたリーグ内順位の最上位、最下位で順位が逆転している場合は入れ替えを行う。
   for league in 1..5 # 1:A～B, 2:B～C, 3:C～D, 4:D～E, 5:E～F
     rec1 = nil
     rec2 = nil
     
     for i in 0..(ret.length - 1)
       # 最下位を取得
       if (ret[i]["league"] == league) and (ret[i]["rank"] == 5) then
         rec1 = i
       end
       # 最上位を取得
       if (ret[i]["league"] == (league + 1)) and (ret[i]["rank"] == 1) then
         rec2 = i
       end
     end
           
     # 最上位、最下位が逆転している場合は入れ替える
     if (not(rec1.nil?)) and (not(rec2.nil?)) then
        if ret[rec1]["uriage_total"] < ret[rec2]["uriage_total"] then
            ret[rec1]["league"] = (league + 1)
            ret[rec1]["rank"] = 1
            ret[rec2]["league"] = league
            ret[rec2]["rank"] = 5
        end  
     end
 
   end

   #今月のリーグ内順位を振り直す
   ret = ret.sort{|a,b| sort_func(a, b, "league, uriage_total desc, before_league, before_rank")}   
   league = 0
   rank = 0
   for i in 0..(ret.length - 1)
     if ret[i]["league"] != league then
       league = ret[i]["league"]
       rank = 0
     end
     rank += 1
     
     ret[i]["rank"] = rank
   end
   
   #合計ポイントの加算
   for i in 0..(ret.length - 1)
      ret[i]["up_point"] = 0
      if ym[4..5] == "01" then
        ret[i]["total_point"] = 0 #1月で累積ポイントはリセット
      else
        ret[i]["total_point"] = ret[i]["before_total_point"]
      end 
      
      m_get_point = MGetPoint.find(:first, :conditions=>["rank=? and league_rank=?",
                                                            ret[i]["league"],
                                                            ret[i]["rank"]])
                                                            
      if not(m_get_point.nil?) then
          ret[i]["up_point"] = m_get_point.pt.to_i
          ret[i]["total_point"] += m_get_point.pt.to_i
      end
      
   end

   # 今月リーグ、今月ランクでソート
   ret = ret.sort{|a,b| sort_func(a, b, "before_league, before_rank")}

   return ret
 
  end # def

  # ハッシュa,bをsort_orderで比較する
  def sort_func(a, b, sort_order) 
    
    # a < b は負, a > b は正, a = b は0
    
    # スペースが2個以上連続する場合はスペース1個へ置換する
    until sort_order.index("  ").nil?
      sort_order = sort_order.sub("  ", " ")       
    end
    
    orders = sort_order.split(",")
    for order in orders
      
      order1 = order.strip.split(" ")
      
      if order1.length > 1 then
        if order1[1].strip == "desc" then
          #降順比較
          field = order1[0].strip
          desc = -1
        else
          #昇順比較
          field = order1[0].strip
          desc = 1
        end
      else
        #昇順比較
        field = order1[0].strip
        desc = 1
      end

      # a と b を比較、同一の場合は次のorderへ
      if a[field] < b[field] then
        return (-1 * desc)
      end
      if a[field] > b[field] then
        return desc
      end

    end
    
    return 0
    
  end
  
end