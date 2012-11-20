# -*- coding:utf-8 -*-
class DAuditEtcsController < ApplicationController

  def index
    
    # 自主監査 or 本監査を取得しセッションへ保存
    if params[:audit_class] == "0" or params[:audit_class] == "1" then
      session[:audit_class] = params[:audit_class].to_s
    else
      redirect_to :controller => "homes", :action => "index"
      return
    end 

    # 自主監査はログイン者の店舗固定、本監査は自由に設定可
    if session[:audit_class].to_s == "0" then
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:header_m_shop_id] 
    end 

    # from ～ to の読込
    load_from_to(session[:audit_class], @m_shop_id)
    
  end
  
  def show
    
    # UPDATE 2012.10.16 コメントのみ更新モードを追加
    redirect_to :action => "edit", :id => params[:id], :readonly => true, :back => true ,:comment => params[:comment].to_s
    
  end
  
  def edit
    
    if not(params[:id].nil?) then
      # IDを指定した呼出
      d_audit_etc = DAuditEtc.find(params[:id]) 
      session[:audit_class] = d_audit_etc[:audit_class].to_s
      @m_shop_id            = d_audit_etc[:m_shop_id]
      @created_user_id      = d_audit_etc[:created_user_id]
      @audit_date_from      = d_audit_etc[:audit_date_from]
      @audit_date_from      = @audit_date_from[0..3] + "/" + @audit_date_from[4..5] + "/" + @audit_date_from[6..7]
      @audit_date_to        = d_audit_etc[:audit_date_to]
      @audit_date_to        = @audit_date_to[0..3] + "/" + @audit_date_to[4..5] + "/" + @audit_date_to[6..7]
    else
      # 検索から呼出
      @m_shop_id       = params[:header][:m_shop_id] 
      @created_user_id = params[:header][:created_user_id]
      @audit_date_from = params[:header][:audit_date_from]
      @audit_date_to   = params[:header][:audit_date_to]
    end
    
    # from ～ to の読込
    load_from_to(session[:audit_class], @m_shop_id)
    
    # d_wash_sale が入力済みかどうか確認
    if chk_d_sale_etc then
      @d_sale_etc_flg = true
      
      # _form用のデータ読込
      read_from
    else
      @d_sale_etc_flg = false
      
    end

  end
  
  def update
      
    #更新日時をバッファ
    upd_time = Time.now 

    #更新全体をトランザクション処理    
    DAuditEtc.transaction {  
    
    #その他監査データUpdate
    d_audit_etc = DAuditEtc.find(:first, 
                                 :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      params['dt1'][:audit_date_from],
                                                      session[:audit_class],
                                                      params['dt1'][:m_shop_id]])
    
    if d_audit_etc.nil? then
      #新規
      d_audit_etc = DAuditEtc.new
      
      d_audit_etc.audit_date_from   = params['dt1'][:audit_date_from]
      d_audit_etc.audit_date_to     = params['dt1'][:audit_date_to]
      d_audit_etc.audit_class       = session[:audit_class]
      d_audit_etc.m_shop_id         = params['dt1'][:m_shop_id]
      d_audit_etc.kakutei_flg       = 0
      d_audit_etc.kakunin_flg       = 0
      d_audit_etc.kakunin_user_id   = 0
      d_audit_etc.kakunin_date      = nil
      d_audit_etc.approve_id1       = 0
      d_audit_etc.approve_date1     = nil
      d_audit_etc.approve_id2       = 0
      d_audit_etc.approve_date2     = nil
      d_audit_etc.approve_id3       = 0
      d_audit_etc.approve_date3     = nil
      d_audit_etc.approve_id4       = 0
      d_audit_etc.approve_date4     = nil
      d_audit_etc.approve_id5       = 0
      d_audit_etc.approve_date5     = nil
      d_audit_etc.confirm_shop_id   = params[:confirm][:shop_id]
      d_audit_etc.confirm_user_id   = params[:confirm][:user_id]
      d_audit_etc.comment           = params[:d_audit_etc][:comment] #UPDATE 2012.10.16 コメント機能追加
      d_audit_etc.created_user_id   = current_user.id
      d_audit_etc.created_at        = upd_time
      d_audit_etc.updated_user_id   = current_user.id
      d_audit_etc.updated_at        = upd_time
    else
      #更新
      d_audit_etc.confirm_shop_id   = params[:confirm][:shop_id]
      d_audit_etc.confirm_user_id   = params[:confirm][:user_id]
      d_audit_etc.comment           = params[:d_audit_etc][:comment] #INSERT 2012.10.16 コメント機能追加
      d_audit_etc.updated_user_id   = current_user.id
      d_audit_etc.updated_at        = upd_time
    end
    d_audit_etc.save!
    
    @id = d_audit_etc.id #redirect時のために保存しておく
    
    #その他自主監査詳細データUpdate
    rec_no = 1
    until params["dt#{rec_no}"].nil?
      dt_rec = params["dt#{rec_no}"]
      
      d_audit_etc_detail = DAuditEtcDetail.find(:first, 
                                                :conditions => ["d_audit_etc_id=? AND m_etc_id=? AND etc_no=?",
                                                                    d_audit_etc.id,
                                                                    dt_rec[:m_etc_id],
                                                                    dt_rec[:etc_no]])
                                                                    
      if d_audit_etc_detail.nil? then
        #新規
        d_audit_etc_detail = DAuditEtcDetail.new
        
        d_audit_etc_detail.d_audit_etc_id = d_audit_etc.id
        d_audit_etc_detail.m_etc_id = dt_rec[:m_etc_id]
        d_audit_etc_detail.etc_no = dt_rec[:etc_no]
        if dt_rec[:etc_no].to_i != 99 then
          #通常明細
          d_audit_etc_detail.meter = dt_rec[:t_meter]
          d_audit_etc_detail.uriage = dt_rec[:k_uri]
          d_audit_etc_detail.error_money = 0
        else
          #合計明細
          d_audit_etc_detail.meter = dt_rec[:g_uri]
          d_audit_etc_detail.uriage = 0
          d_audit_etc_detail.error_money = dt_rec[:gosa]
        end
        d_audit_etc_detail.created_user_id   = current_user.id
        d_audit_etc_detail.created_at        = upd_time
        d_audit_etc_detail.updated_user_id   = current_user.id
        d_audit_etc_detail.updated_at        = upd_time
      else
        #更新
        if dt_rec[:etc_no].to_i != 99 then
          #通常明細
          d_audit_etc_detail.meter = dt_rec[:t_meter]
          d_audit_etc_detail.error_money = 0
        else
          #合計明細
          d_audit_etc_detail.meter = dt_rec[:g_uri]
          d_audit_etc_detail.error_money = dt_rec[:gosa]
        end
        d_audit_etc_detail.updated_user_id   = current_user.id
        d_audit_etc_detail.updated_at         = upd_time
      end
      d_audit_etc_detail.save!
      
      rec_no += 1
    end
    
    } #トランザクションCommit
    
    # トップに戻る
    redirect_to :action => "edit", :id => @id
    
  end
  
  # 誤差選択時イベント
  def dialog_gosa
    
    # 誤差が発生した日を取得
    sql = <<-SQL
        select 
            a.sale_date
        from 
                     d_sale_etcs        a 
          inner join d_sale_etc_details b
        on 
              a.id = b.d_sale_etc_id
        where 
                a.sale_date  >=  '#{params[:dialog_gosa][:sale_date_from]}' 
            and a.sale_date  <=  '#{params[:dialog_gosa][:sale_date_to]}'
            and a.m_shop_id  =  #{params[:dialog_gosa][:m_shop_id]} 
            and b.m_etc_id   =  #{params[:dialog_gosa][:m_etc_id]}
            and b.etc_no     =  99
            and b.error_money != 0 --UPDATE 2012.10.16 >0 → != 0
        order by
            a.sale_date
     
     SQL
    
    @d_sale_etcs = DSaleEtc.find_by_sql(sql)
    
    render :layout => "modal"
    
  end

  # INSERT BEGIN 2012.11.16 コメント機能追加 
  def edit_comment
    
    render :layout => "modal"
    
  end

  # コメントのみのAJAX更新
  def update_comment
    
    @d_audit_etc = DAuditEtc.find(params[:id])
    @d_audit_etc[:comment] = params[:comment]
    @d_audit_etc.save!
    
    head :ok
    
  end

  # INSERT END 2012.11.16 コメント機能追加 
  
private 
  
  # 期間内にその他入力が実行されているかを確認
  def chk_d_sale_etc
    
    d_sale_etcs = DSaleEtc.find(:all, :conditions => ["sale_date >= ? and sale_date <= ? and m_shop_id = ? ",
                                                          @audit_date_from.gsub("/",""),
                                                          @audit_date_to.gsub("/",""),
                                                          @m_shop_id])
    
    return (d_sale_etcs.length > 0)
    
  end
  
  # _form用データ読込
  def read_from
    
    #Viewに渡す配列
    @dt = Array.new
      
    #その他売上監査データRead
    d_audit_etc = DAuditEtc.find(:first, 
                                 :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      @audit_date_from.gsub("/",""),
                                                      session[:audit_class],
                                                      @m_shop_id])
    
    @d_audit_etc = DAuditEtc.find(:first, 
                                  :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      @audit_date_from.gsub("/",""),
                                                      session[:audit_class],
                                                      @m_shop_id])
    
    #前回監査データRead 
    d_audit_etc_z = DAuditEtc.find(:first, 
                                   :conditions => ["audit_date_from<? AND m_shop_id=?",
                                                        @audit_date_from.gsub("/",""),
                                                        @m_shop_id],
                                   :order => "audit_date_from desc")
    
    #その他売上Read
    m_etc = MEtc.find(:all, 
                      :conditions=>[ "deleted_flg=?", 0], 
                      :order=>"etc_cd")
    
    for m_etc_rec in m_etc
            
      k_uri_sum = 0 #その他売上毎の売上計
            
      for num in 1 .. m_etc_rec.max_num

        #今回監査明細READ
        d_audit_etc_detail = nil
        if not(d_audit_etc.nil?) then 
          d_audit_etc_detail = DAuditEtcDetail.find(:first,
                                                    :conditions => ["d_audit_etc_id=? AND m_etc_id=? AND etc_no=?",
                                                                       d_audit_etc.id,
                                                                       m_etc_rec.id,
                                                                       num])
        end        
        
        #前回監査明細READ
        d_audit_etc_detail_z = nil
        if not(d_audit_etc_z.nil?) then 
          d_audit_etc_detail_z = DAuditEtcDetail.find(:first,
                                                      :conditions => ["d_audit_etc_id=? AND m_etc_id=? AND etc_no=?",
                                                                        d_audit_etc_z.id,
                                                                        m_etc_rec.id,
                                                                        num])
        end
       
        #売上READ
        d_sale_etcs_sum = nil
        if d_audit_etc_detail.nil? then  
          
          # UPDATE BEGIN 2012.11.20 ZEROメータを考慮
          #
          ## UPDATE BEGIN 2012.10.16 当日メータは売上最終データを読み込む
          ##sql = <<-SQL
          ##          select 
          ##              coalesce(sum(b.meter), 0) as sum_meter
          ##          from 
          ##                        d_sale_etcs        a 
          ##             inner join d_sale_etc_details b
          ##          on 
          ##              a.id = b.d_sale_etc_id
          ##          where 
          ##                 a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
          ##             and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
          ##             and a.m_shop_id  =   #{@m_shop_id} 
          ##             and b.m_etc_id   =  #{m_etc_rec.id}
          ##             and b.etc_no     =  #{num}
          ##      SQL
          #
          #sql = <<-SQL
          #          select 
          #              coalesce(b.meter, 0) as sum_meter
          #          from 
          #                       d_sale_etcs        a  -- d_sale_etcは必ず存在,left joinなので必ずデータが返る
          #             left join 
          #             
          #              (select * from d_sale_etc_details 
          #               where m_etc_id   =  #{m_etc_rec.id}
          #                 and etc_no     =  #{num}
          #              ) b
          #          on 
          #              a.id = b.d_sale_etc_id
          #          where 
          #                 a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
          #             and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
          #             and a.m_shop_id  =   #{@m_shop_id} 
          #          order by 
          #             a.sale_date desc
          #      SQL
          ## UPDATE END 2012.10.16 売上は期間内の最終データを読み込む
          
          if m_etc_rec.etc_class.to_i == 1 then
            #ゼロメータ(期間内のメータ計がそのまま売上個数)
            sql = <<-SQL
                    select 
                        coalesce(sum(b.meter), 0) as sum_meter
                    from 
                                  d_sale_etcs        a 
                       inner join d_sale_etc_details b
                    on 
                        a.id = b.d_sale_etc_id
                    where 
                           a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
                       and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
                       and a.m_shop_id  =   #{@m_shop_id} 
                       and b.m_etc_id   =  #{m_etc_rec.id}
                       and b.etc_no     =  #{num}
                  SQL
          else
            #前回メータ(期間内の最終メータ - 前回メータが売上個数)
            sql = <<-SQL
                    select 
                        coalesce(b.meter, 0) as sum_meter
                    from 
                                 d_sale_etcs        a  -- d_sale_etcは必ず存在,left joinなので必ずデータが返る
                       left join 
                       
                        (select * from d_sale_etc_details 
                         where m_etc_id   =  #{m_etc_rec.id}
                           and etc_no     =  #{num}
                        ) b
                    on 
                        a.id = b.d_sale_etc_id
                    where 
                           a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
                       and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
                       and a.m_shop_id  =   #{@m_shop_id} 
                    order by 
                       a.sale_date desc
              SQL
          end
          # UPDATE END 2012.11.20 ZEROメータを考慮
          
          d_sale_etcs_sum = DSaleEtc.find_by_sql(sql)[0]
           
        end
         
        #明細レコード定義
        dt_rec = Hash.new 
        dt_rec[:audit_date_from] = @audit_date_from.gsub("/","") #d_audit_etcs.audit_date_from
        dt_rec[:audit_date_to] = @audit_date_to.gsub("/","")     #d_audit_etcs.audit_date_to
        dt_rec[:audit_class] = session[:audit_class]             #d_audit_etcs.audit_class
        dt_rec[:m_shop_id] = @m_shop_id        #d_audit_etcs.m_shop_id
        dt_rec[:m_etc_id] = m_etc_rec.id       #d_audit_etc_details.m_etc_id
        dt_rec[:etc_cd]   = m_etc_rec.etc_cd   #他売上CD
        dt_rec[:etc_name] = m_etc_rec.etc_name #他売上名
        dt_rec[:max_num]   = m_etc_rec.max_num #売上行最大数
        dt_rec[:etc_no] = num                #d_audit_etc_details.etc_no
        dt_rec[:t_meter] = 0                 #当日メータ(明細のみ)
        dt_rec[:z_meter] = 0                 #前回メータ(明細のみ)
        dt_rec[:k_uri] = 0                   #計算上売上高
        dt_rec[:g_uri] = 0                   #現金売上高(合計行のみ)
        dt_rec[:gosa] = 0                    #誤差(合計行のみ)
        
        #当日メータ(優先順位：登録済の詳細、売上集計)
        if not(d_audit_etc_detail.nil?) then
          dt_rec[:t_meter]   = d_audit_etc_detail.meter       
        else
          dt_rec[:t_meter]   = d_sale_etcs_sum.sum_meter.to_i 
        end
        
        #前回メータ
        if not(d_audit_etc_detail_z.nil?) then
          dt_rec[:z_meter]   = d_audit_etc_detail_z.meter #前回監査登録済
        else
          dt_rec[:z_meter]   = 0 #前回監査なし          
        end
        
        # INSERT BEGIN 2012.11.20 ZEROメータを考慮
        if m_etc_rec.etc_class.to_i == 1 then
          dt_rec[:z_meter] = "-"
        end
        # INSERT END 2012.11.20 ZEROメータを考慮
        
        #計算上売上高(当日メータ - 前回メータ)
        #if dt_rec[:t_meter] < dt_rec[:z_meter] then
        #  dt_rec[:k_uri] = dt_rec[:t_meter] #故障の場合は0から再カウント
        #else
        #  dt_rec[:k_uri] = dt_rec[:t_meter] - dt_rec[:z_meter]
        #end
        
        #計算上売上高(優先順位：登録済の詳細、(今回メータ - 前回メータ)*単価)
        if not(d_audit_etc_detail.nil?) then
          dt_rec[:k_uri] = d_audit_etc_detail.uriage
        else
          # UPDATE BEGIN 2012.11.20 ZEROメータを考慮
          #if dt_rec[:t_meter] < dt_rec[:z_meter] then
          #  dt_rec[:k_uri] = dt_rec[:t_meter] #故障の場合は0から再カウント
          #else
          #  dt_rec[:k_uri] = dt_rec[:t_meter] - dt_rec[:z_meter]
          #end
          
          if m_etc_rec.etc_class.to_i == 1 then
            dt_rec[:k_uri] = dt_rec[:t_meter]
          else
            if dt_rec[:t_meter] < dt_rec[:z_meter] then
              dt_rec[:k_uri] = dt_rec[:t_meter] #故障の場合は0から再カウント
            else
              dt_rec[:k_uri] = dt_rec[:t_meter] - dt_rec[:z_meter]
            end
          end
          # UPDATE END 2012.11.20 ZEROメータを考慮
          
          dt_rec[:k_uri] *= m_etc_rec.price
        end
        
        #売上集計
        k_uri_sum += dt_rec[:k_uri]
        
        dt_rec[:g_uri]     = 0 #合計行のみ
        dt_rec[:gosa]      = 0 #合計行のみ
        @dt.push dt_rec
      
      end #for num in 1 .. m_etc_rec.max_num
      
      #今回監査明細READ(合計行)
      d_audit_etc_detail99 = nil
      if not(d_audit_etc.nil?) then
        
        d_audit_etc_detail99 = DAuditEtcDetail.find(:first,
                                                     :conditions => ["d_audit_etc_id=? AND m_etc_id=? AND etc_no=99",
                                                                        d_audit_etc.id,
                                                                        m_etc_rec.id])
                                                                        
      end
      
      #売上READ(合計行)
      d_sale_etcs_sum99 = nil
      if d_audit_etc_detail99.nil? then
          
          sql = <<-SQL
                    select 
                        coalesce(sum(b.meter), 0)       as sum_meter
                       ,coalesce(sum(b.error_money), 0) as sum_error_money
                    from 
                                  d_sale_etcs        a 
                       inner join d_sale_etc_details b
                    on 
                        a.id = b.d_sale_etc_id
                    where 
                           a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
                       and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
                       and a.m_shop_id   =  #{@m_shop_id} 
                       and b.m_etc_id   =  #{m_etc_rec.id}
                       and b.etc_no     =  99
                SQL
                
           d_sale_etcs_sum99 = DSaleEtc.find_by_sql(sql)[0]
           
      end  
      
      #合計レコード定義
      dt_rec = Hash.new 
      dt_rec[:audit_date_from] = @audit_date_from.gsub("/","") #d_audit_etcs.audit_date_from
      dt_rec[:audit_date_to] = @audit_date_to.gsub("/","")     #d_audit_etcs.audit_date_to
      dt_rec[:audit_class] = session[:audit_class]             #d_audit_etcs.audit_class
      dt_rec[:m_shop_id] = @m_shop_id      #d_audit_etcs.m_shop_id
      dt_rec[:m_etc_id] = m_etc_rec.id     #d_audit_etc_details.m_etc_id
      dt_rec[:etc_cd]   = m_etc_rec.etc_cd      #他売上CD
      dt_rec[:etc_name] = m_etc_rec.etc_name    #他売上名
      dt_rec[:max_num]   = m_etc_rec.max_num    #他売上行最大数
      dt_rec[:etc_no] = 99                 #d_audit_etc_details.etc_no
      dt_rec[:t_meter] = 0                 #当日メータ(明細のみ)
      dt_rec[:z_meter] = 0                 #前回メータ(明細のみ)
      dt_rec[:k_uri] = k_uri_sum           #計算上売上高
      dt_rec[:g_uri] = 0                   #現金売上高(合計行のみ)
      dt_rec[:gosa] = 0                    #誤差(合計行のみ)
      
      if not(d_audit_etc_detail99.nil?) then
        #前回登録済み
        dt_rec[:g_uri]     = d_audit_etc_detail99.meter
        dt_rec[:gosa]      = d_audit_etc_detail99.error_money
      else
        #売上集計
        dt_rec[:g_uri]     = d_sale_etcs_sum99.sum_meter.to_i
        dt_rec[:gosa]      = d_sale_etcs_sum99.sum_error_money.to_i
      end 
      
      @dt.push dt_rec
    
    end #for m_etc_rec in m_etc
    
  end

  # UPDATE 2012.10.17 監査日のリストの作成方法を変更
  # from～toのコンボ用データ読込
  def load_from_to(audit_class, m_shop_id)
    # 戻り値の初期化
    @from = Array.new    
    @to   = Array.new
    
    #登録済の監査日を読込
    d_audit_etcs = DAuditEtc.find(:all, 
                                  :conditions => ["audit_class=? AND m_shop_id=?", 
                                                    audit_class,
                                                    m_shop_id],      
                                  :order => "audit_date_from desc")
    
    #最後の監査日を読込(audit_classを関係なしに読み込む)
    d_audit_from = DAuditEtc.find(:all,
                                  :conditions => ["m_shop_id=?", 
                                                    m_shop_id],      
                                  :order => "audit_date_from desc")
    
    #新規の監査日を作る
    if d_audit_from.length == 0 then 
      @from.push '0000/00/00'
      @to.push   ''  
    else
      @from.push Date.strptime(d_audit_from[0].audit_date_to, "%Y%m%d").next.strftime('%Y/%m/%d')
      @to.push   ''
    end

    #登録済の監査日を作る
    for d_audit_etc_rec in d_audit_etcs
      if d_audit_etc_rec.audit_date_from == '00000000' then
        @from.push '0000/00/00'
      else
        @from.push Date.strptime(d_audit_etc_rec.audit_date_from, "%Y%m%d").strftime('%Y/%m/%d')
      end
    
      @to.push   Date.strptime(d_audit_etc_rec.audit_date_to, "%Y%m%d").strftime('%Y/%m/%d')
    end

  end
  
end
