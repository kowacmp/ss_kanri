# -*- coding:utf-8 -*-
class DWashpurikaReportsController < ApplicationController

  include DWashpurikaReportsHelper

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

    @d_washpurika_reports = create_d_washpurika_reports(params[:header][:y] + params[:header][:m], params[:header][:d].to_i)
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
                                               :m => params[:hheader][:m],
                                               :d => params[:hheader][:d]}
    
  end

  def print
    @d_washpurika_reports = read_d_washpurika_reports(params[:rheader][:y] + params[:rheader][:m])
    @days = Time.days_in_month(params[:rheader][:m].to_i, params[:rheader][:y].to_i)
    
    shops = MShop.find(:all,:conditions => ['shop_kbn = 0'],:order => 'shop_cd')
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_washpurika_report.tlf')
    
    #ページ、作成日、タイトル設定
    report.events.on :page_create do |e|
      #e.page.item(:page).value(e.page.no)
      #e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
      e.page.item(:title).value("洗車プリカ販売目標・実績表")
    end #evants.on
    
    report.start_new_page
 
    #ヘッダー
    report.page.list(:list).header do |h|
        output_ym = params[:rheader][:y].to_i.to_s + "年" + params[:rheader][:m].to_i.to_s + "月"
        output_y = params[:rheader][:y].to_i.to_s + "年"
        output_m = params[:rheader][:m].to_i.to_s + "月"
        #h.item(:output_ym).value(output_ym)
        h.item(:output_y).value(output_y)
        h.item(:output_m).value(output_m)
        #h.item(:shop_name).value(@m_shop.shop_name)
        for i in 1..@days
          select_day = Date.new(params[:rheader][:y].to_i, params[:rheader][:m].to_i, i)    
          week_w = day_of_the_week(select_day.wday) 
          h.item("d_#{i}").value(i)
          h.item("w_#{i}").value(week_w)
        end
    end
 
    tmp_league = ""
 
    # 詳細作成
    for rec_group in @d_washpurika_reports
      #リーグが変わった場合実行
      if tmp_league != rec_group["before_league"]
        league_idx = 0
        # Set header datas.
        report.page.list(:list).add_row do |row|
        for rec in @d_washpurika_reports
          #同リーグを１レコードとする
          if rec["before_league"] == rec_group["before_league"]
            league_idx = league_idx + 1
            #１リーグ５店舗までとする
            if league_idx <= 5 
              
              m_shop = MShop.find(rec["m_shop_id"])
              row.item("league").value(get_league_chr(rec["before_league"]))
              row.item("shop_name_#{league_idx}").value(m_shop.shop_ryaku)
              row.item("zen_rank_#{league_idx}").value("前月順位 " + get_league_chr(rec["dsp_league"]).to_s + rec["dsp_rank"].to_s)
              row.item("r_pt_#{league_idx}").value("累積pt " + rec["before_total_point"].to_s)
              
              #目標1～31
              d_aim = DAim.find(:first, :conditions => ["date=? and m_shop_id=? and m_aim_id=26", rec["date"], rec["m_shop_id"]])
              aim_total = 0
              for i in 1..@days
                if rec["result#{ i }"].nil? then
                  row.item("aim_#{league_idx}_#{i}").value("") #わざとだしません
                else
                  #2012/11/30 目標値累積修正 oda
                  #row.item("aim_#{league_idx}_#{i}").value(d_aim["aim_value#{ i }"]) unless d_aim.nil?
                  if d_aim.blank? or d_aim.aim_total == nil
                    row.item("aim_#{league_idx}_#{i}").value(0)
                  else
                    row.item("aim_#{league_idx}_#{i}").value(d_aim["aim_value#{ i }"])
                    aim_total += d_aim["aim_value#{ i }"].to_i
                  end
                end
              end
              #2012/11/30 目標値累積修正 oda
              #目標トータル
              #row.item("aim_total_#{league_idx}").value(d_aim.aim_total) unless d_aim.nil?
              if d_aim.blank? or d_aim.aim_total == nil
                row.item("aim_total_#{league_idx}").value(0)
              else
                row.item("aim_total_#{league_idx}").value(aim_total)
              end
              #2012/11/30 月合計表示 oda
              #月目標
              if d_aim.blank? or d_aim.aim_total == nil
                row.item("aim_month_#{league_idx}").value(0)
              else
                row.item("aim_month_#{league_idx}").value(d_aim.aim_total)
              end
              #枚数差
              #2012/11/30 目標値累積修正 oda
              #row.item("aim_maisu_#{league_idx}").value(d_aim.aim_total - rec["result_total"]) unless d_aim.nil?
              row.item("aim_maisu_#{league_idx}").value(aim_total - rec["result_total"])
              #ペース
              row.item("aim_pace_#{league_idx}").value(rec["pace"])
              #前年同日迄のペース
              row.item("same_pace_#{league_idx}").value(rec["same_pace"])
              #同月過去最高実績
              row.item("same_uriage_total_max_#{league_idx}").value(rec["same_uriage_total_max"])
              
              #実績枚数1～31
              for i in 1..@days
                row.item("j_#{league_idx}_#{i}").value(rec["result#{ i }"])
              end
              #実績枚数トータル
              row.item("j_total_#{league_idx}").value(rec["result_total"])
              #前年同日迄の実績
              row.item("same_uriage_#{league_idx}").value(rec["same_uriage"])
              
              #洗車売上金額
              row.item("uriage_total_#{league_idx}").value(rec["uriage_total"])
              #前年同月末実績
              row.item("same_uriage_total_#{league_idx}").value(rec["same_uriage_total"])
              #本年ペース - 過去最高
              row.item("result_total_#{league_idx}").value(rec["pace"] - rec["same_uriage_total_max"])
            
            end #if league_idx <= 5 
          end #if rec["before_league"] == rec_group["before_league"]
        end #for rec
        end #add_row  
      end #if tmp_league != rec_group["before_league"]
      tmp_league = rec_group["before_league"]
    end #for rec_group
    
    #ファイル名セット     
    pdf_title = "洗車プリカ販売目標実績表_#{params[:rheader][:y] + params[:rheader][:m]}.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
                               
  end #def print

  
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
  def create_d_washpurika_reports(ym, max_d)
    
    # 戻り値の配列設定
    ret = Array.new()

    # 前月を取得
    if ym[4..5] == "01" then
      zym = (ym[0..3].to_i - 1).to_s + "12"
    else
      zym = ym[0..3] + sprintf("%02d", (ym[4..5].to_i - 1)) 
    end
    
    # 店舗が追加された場合に表示されないので、前月データに場合
    add_new_shops(zym)
    
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
      
      for d in 1..max_d
        
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
      
    end # for d in 1..max_d
    
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
    
    # 前年同月の計算値が0の場合は入力済みを優先させる
    # ※1年目のみ前年のデータがないので、前年計算値がALL=0で出力されるが、例外的に手入力を許可しているため。
    #   常に再計算を優先させると前回入力の値が失われることになる。
    last_input = DWashpurikaReport.find(:first, 
                                        :conditions => ["date=? and m_shop_id=?",
                                                          ret_rec["date"],
                                                          ret_rec["m_shop_id"]])
    
    if not(last_input.nil?) then
      ret_rec["same_pace"]             = last_input["same_pace"]              if ret_rec["same_pace"] == 0
      ret_rec["same_uriage"]           = last_input["same_uriage"]            if ret_rec["same_uriage"] == 0
      ret_rec["same_uriage_total"]     = last_input["same_uriage_total"]      if ret_rec["same_uriage_total"] == 0
      ret_rec["same_uriage_total_max"] = last_input["same_uriage_total_max"]  if ret_rec["same_uriage_total_max"] == 0
    end
    
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
   
   # リーグの最大を取得する
   max_league = 0
   for rec in ret
     if rec["league"] > max_league then
       max_league = rec["league"]
     end
   end
   
   # ①でつけたリーグ内順位の最上位、最下位で順位が逆転している場合は入れ替えを行う。
   for league in 1..max_league # 1:A～B, 2:B～C, 3:C～D, 4:D～E, 5:E～F　‥
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
           
     # 最上位、最下位を強制的に入れ替える
     if (not(rec1.nil?)) and (not(rec2.nil?)) then
        #if ret[rec1]["uriage_total"] < ret[rec2]["uriage_total"] then #DEL 2012.10.31 売上に関係なく入れ替える
            ret[rec1]["league"] = (league + 1)
            ret[rec1]["rank"] = 1
            ret[rec2]["league"] = league
            ret[rec2]["rank"] = 5
        #end  
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
      if ym[4..5] == "12" then
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
  
  # 新規店舗のレコードを追加する
  def add_new_shops(ym)
     
     
     # 新規店舗を取得
     sql = "select
              *
            from 
              m_shops
            where
                   id not in (select m_shop_id from d_washpurika_reports where date = '#{ ym }')
              and  shop_kbn = 0
            order by
              shop_cd
           "
     
     m_shops = MShop.find_by_sql(sql)
     
     # ランクと順位の最大を取得する
     max_d_washpurika_report = DWashpurikaReport.find(:first, :conditions => ["date=?", ym], :order => "league desc, rank desc")
     if max_d_washpurika_report.nil?
       league     = 1
       rank       = 0
       total_rank = 0
     else
       league     = max_d_washpurika_report.league
       rank       = max_d_washpurika_report.rank
       total_rank = max_d_washpurika_report.total_rank
     end
     
     
     for m_shop in m_shops
       
       # 順位+1したものを取得する
       rank += 1
       total_rank += 1
       if rank > 5 
         league += 1
         rank = 1
       end
       
       # 新規店舗を最下位に追加する
       d_washpurika_report = DWashpurikaReport.new()
       
       d_washpurika_report.date               = ym
       d_washpurika_report.m_shop_id          = m_shop.id
       d_washpurika_report.total_rank         = total_rank
       d_washpurika_report.before_league      = league
       d_washpurika_report.league             = league
       d_washpurika_report.before_rank        = rank
       d_washpurika_report.rank               = rank
       d_washpurika_report.before_total_point = 0
       d_washpurika_report.total_point        = 0
       
       for i in 1..31
         d_washpurika_report["result#{ i }"] = 0
       end
       d_washpurika_report.result_total = 0
       
       for i in 1..31
         d_washpurika_report["uriage#{ i }"] = 0
       end
       d_washpurika_report.uriage_total = 0
       
       d_washpurika_report.pace                  = 0
       d_washpurika_report.same_pace             = 0
       d_washpurika_report.same_uriage           = 0
       d_washpurika_report.same_uriage_total     = 0
       d_washpurika_report.same_uriage_total_max = 0
       
       d_washpurika_report.created_user_id = current_user.id
       d_washpurika_report.updated_user_id = current_user.id
       
       d_washpurika_report.save!
       
     end
     
  end
  
end