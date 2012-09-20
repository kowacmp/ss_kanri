class DAuditWashesController < ApplicationController

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

  def edit
    
    if not(params[:id].nil?) then
      # IDを指定した呼出
      d_audit_wash = DAuditWash.find(params[:id]) 
      session[:audit_class] = d_audit_wash[:audit_class].to_s
      @m_shop_id            = d_audit_wash[:m_shop_id]
      @created_user_id      = d_audit_wash[:created_user_id]
      @audit_date_from      = d_audit_wash[:audit_date_from]
      @audit_date_from      = @audit_date_from[0..3] + "/" + @audit_date_from[4..5] + "/" + @audit_date_from[6..7]
      @audit_date_to        = d_audit_wash[:audit_date_to]
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
  
    # _form用のデータ読込
    read_from
    
  end

  def update
        
    #更新日時をバッファ
    upd_time = Time.now 

    #更新全体をトランザクション処理    
    DAuditWash.transaction {  
    
    #洗車機監査データUpdate
    d_audit_wash = DAuditWash.find(:first, 
                                   :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      params['dt1'][:audit_date_from],
                                                      session[:audit_class],
                                                      params['dt1'][:m_shop_id]])
    
    if d_audit_wash.nil? then
      #新規
      d_audit_wash = DAuditWash.new
      
      d_audit_wash.audit_date_from   = params['dt1'][:audit_date_from]
      d_audit_wash.audit_date_to     = params['dt1'][:audit_date_to]
      d_audit_wash.audit_class       = session[:audit_class]
      d_audit_wash.m_shop_id         = params['dt1'][:m_shop_id]
      d_audit_wash.kakutei_flg       = 0
      d_audit_wash.kakunin_flg       = 0
      d_audit_wash.kakunin_user_id   = 0
      d_audit_wash.kakunin_date      = nil
      d_audit_wash.approve_id1       = 0
      d_audit_wash.approve_date1     = nil
      d_audit_wash.approve_id2       = 0
      d_audit_wash.approve_date2     = nil
      d_audit_wash.approve_id3       = 0
      d_audit_wash.approve_date3     = nil
      d_audit_wash.approve_id4       = 0
      d_audit_wash.approve_date4     = nil
      d_audit_wash.approve_id5       = 0
      d_audit_wash.approve_date5     = nil
      d_audit_wash.confirm_shop_id   = params[:confirm][:shop_id]
      d_audit_wash.confirm_user_id   = params[:confirm][:user_id]
      d_audit_wash.comment           = ''
      d_audit_wash.created_user_id   = current_user.id
      d_audit_wash.created_at        = upd_time
      d_audit_wash.updated_user_id   = current_user.id
      d_audit_wash.updated_at        = upd_time
    else
      #更新
      d_audit_wash.confirm_shop_id   = params[:confirm][:shop_id]
      d_audit_wash.confirm_user_id   = params[:confirm][:user_id]
      d_audit_wash.updated_user_id   = current_user.id
      d_audit_wash.updated_at        = upd_time
    end
    d_audit_wash.save!

    @id = d_audit_wash.id #redirect時のために保存しておく
    
    #洗車機監査詳細データUpdate
    rec_no = 1
    until params["dt#{rec_no}"].nil?
      dt_rec = params["dt#{rec_no}"]
      
      d_audit_wash_detail = DAuditWashDetail.find(:first, 
                                                  :conditions => ["d_audit_wash_id=? AND m_wash_id=? AND wash_no=?",
                                                                    d_audit_wash.id,
                                                                    dt_rec[:m_wash_id],
                                                                    dt_rec[:wash_no]])
                                                                    
      if d_audit_wash_detail.nil? then
        #新規
        d_audit_wash_detail = DAuditWashDetail.new
        
        d_audit_wash_detail.d_audit_wash_id = d_audit_wash.id
        d_audit_wash_detail.m_wash_id = dt_rec[:m_wash_id]
        d_audit_wash_detail.wash_no = dt_rec[:wash_no]
        if dt_rec[:wash_no].to_i != 99 then
          #通常明細
          d_audit_wash_detail.meter = dt_rec[:t_meter]
          d_audit_wash_detail.uriage = dt_rec[:k_uri]
          d_audit_wash_detail.error_money = 0
        else
          #合計明細
          d_audit_wash_detail.meter = dt_rec[:g_uri]
          d_audit_wash_detail.uriage = 0
          d_audit_wash_detail.error_money = dt_rec[:gosa]
        end
        d_audit_wash_detail.created_user_id   = current_user.id
        d_audit_wash_detail.created_at        = upd_time
        d_audit_wash_detail.updated_user_id   = current_user.id
        d_audit_wash_detail.updated_at        = upd_time
      else
        #更新
        if dt_rec[:wash_no].to_i != 99 then
          #通常明細
          d_audit_wash_detail.meter = dt_rec[:t_meter]
          d_audit_wash_detail.error_money = 0
        else
          #合計明細
          d_audit_wash_detail.meter = dt_rec[:g_uri]
          d_audit_wash_detail.error_money = dt_rec[:gosa]
        end
        d_audit_wash_detail.updated_user_id   = current_user.id
        d_audit_wash_detail.updated_at         = upd_time
      end
      d_audit_wash_detail.save!
      
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
                     d_wash_sales     a 
          inner join d_washsale_items b
        on 
              a.id = b.d_wash_sale_id
        where 
                a.sale_date  >=  '#{params[:dialog_gosa][:sale_date_from]}' 
            and a.sale_date  <=  '#{params[:dialog_gosa][:sale_date_to]}'
            and a.m_shop_id  =  #{params[:dialog_gosa][:m_shop_id]} 
            and b.m_wash_id   =  #{params[:dialog_gosa][:m_wash_id]}
            and b.wash_no     =  99
            and b.error_money >  0
        order by
            a.sale_date
     
     SQL
    
    @d_wash_sales = DWashSale.find_by_sql(sql)
    
  end
  
private
  
  # _form用データ読込
  def read_from
  
    #Viewに渡す配列
    @dt = Array.new
      
    #洗車監査データRead
    d_audit_wash = DAuditWash.find(:first, 
                                   :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      @audit_date_from.gsub("/",""),
                                                      session[:audit_class],
                                                      @m_shop_id])
    
    @d_audit_wash = DAuditWash.find(:first, 
                                    :conditions => ["audit_date_from=? AND audit_class=? AND m_shop_id=?",
                                                      @audit_date_from.gsub("/",""),
                                                      session[:audit_class],
                                                      @m_shop_id])
    
    #前回監査データRead
    d_audit_wash_z = DAuditWash.find(:first, 
                                     :conditions => ["audit_date_from<? AND m_shop_id=?",
                                                        @audit_date_from.gsub("/",""),
                                                        @m_shop_id],
                                     :order => "audit_date_from desc")
    
    #洗車マスタRead
    m_wash = MWash.find(:all, 
                        :conditions=>[ "deleted_flg=?", 0], 
                        :order=>"wash_cd")
    
    for m_wash_rec in m_wash
            
      k_uri_sum = 0 #洗車種類毎の売上合計
            
      for num in 1 .. m_wash_rec.max_num

        #今回監査明細READ
        d_audit_wash_detail = nil
        if not(d_audit_wash.nil?) then 
          d_audit_wash_detail = DAuditWashDetail.find(:first,
                                                      :conditions => ["d_audit_wash_id=? AND m_wash_id=? AND wash_no=?",
                                                                        d_audit_wash.id,
                                                                        m_wash_rec.id,
                                                                        num])
        end        
        
        #前回監査明細READ
        d_audit_wash_detail_z = nil
        if not(d_audit_wash_z.nil?) then 
          d_audit_wash_detail_z = DAuditWashDetail.find(:first,
                                                        :conditions => ["d_audit_wash_id=? AND m_wash_id=? AND wash_no=?",
                                                                        d_audit_wash_z.id,
                                                                        m_wash_rec.id,
                                                                        num])
        end
       
        #売上READ
        d_wash_sales_sum = nil
        if d_audit_wash_detail.nil? then  
          
          sql = <<-SQL
                    select 
                        coalesce(sum(b.meter), 0) as sum_meter
                    from 
                                  d_wash_sales     a 
                       inner join d_washsale_items b
                    on 
                        a.id = b.d_wash_sale_id
                    where 
                           a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
                       and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
                       and a.m_shop_id  =   #{@m_shop_id} 
                       and b.m_wash_id   =  #{m_wash_rec.id}
                       and b.wash_no     =  #{num}
                SQL
                
          d_wash_sales_sum = DWashSale.find_by_sql(sql)[0]
           
        end
         
        #明細レコード定義
        dt_rec = Hash.new 
        dt_rec[:audit_date_from] = @audit_date_from.gsub("/","") #d_audit_washes.audit_date_from
        dt_rec[:audit_date_to] = @audit_date_to.gsub("/","")     #d_audit_washes.audit_date_to
        dt_rec[:audit_class] = session[:audit_class]             #d_audit_washes.audit_class
        dt_rec[:m_shop_id] = @m_shop_id           #d_audit_washes.m_shop_id
        dt_rec[:m_wash_id] = m_wash_rec.id        #d_audit_wash_details.m_wash_id
        dt_rec[:wash_cd]   = m_wash_rec.wash_cd   #洗車機CD
        dt_rec[:wash_name] = m_wash_rec.wash_name #洗車機名
        dt_rec[:max_num]   = m_wash_rec.max_num   #洗車機最大数
        dt_rec[:wash_no] = num               #d_audit_wash_details.wash_no
        dt_rec[:t_meter] = 0                 #当日メータ(明細のみ)
        dt_rec[:z_meter] = 0                 #前回メータ(明細のみ)
        dt_rec[:k_uri] = 0                   #計算上売上高
        dt_rec[:g_uri] = 0                   #現金売上高(合計行のみ)
        dt_rec[:gosa] = 0                    #誤差(合計行のみ)
        
        #当日メータ(優先順位：登録済の詳細、売上集計)
        if not(d_audit_wash_detail.nil?) then
          dt_rec[:t_meter]   = d_audit_wash_detail.meter       
        else
          dt_rec[:t_meter]   = d_wash_sales_sum.sum_meter.to_i 
        end
        
        #前回メータ
        if not(d_audit_wash_z.nil?) then
          dt_rec[:z_meter]   = d_audit_wash_detail_z.meter #前回監査登録済
        else
          dt_rec[:z_meter]   = 0 #前回監査なし          
        end
        
        #計算上売上高(当日メータ - 前回メータ)
        #if dt_rec[:t_meter] < dt_rec[:z_meter] then
        #  dt_rec[:k_uri] = dt_rec[:t_meter] #故障の場合は0から再カウント
        #else
        #  dt_rec[:k_uri] = dt_rec[:t_meter] - dt_rec[:z_meter]
        #end
        
        #計算上売上高(優先順位：登録済の詳細、(今回メータ - 前回メータ)*単価)
        if not(d_audit_wash_detail.nil?) then
          dt_rec[:k_uri] = d_audit_wash_detail.uriage
        else
          if dt_rec[:t_meter] < dt_rec[:z_meter] then
            dt_rec[:k_uri] = dt_rec[:t_meter] #故障の場合は0から再カウント
          else
            dt_rec[:k_uri] = dt_rec[:t_meter] - dt_rec[:z_meter]
          end
          dt_rec[:k_uri] *= m_wash_rec.price
        end
        
        #売上集計
        k_uri_sum += dt_rec[:k_uri]
        
        dt_rec[:g_uri]     = 0 #合計行のみ
        dt_rec[:gosa]      = 0 #合計行のみ
        @dt.push dt_rec
      
      end #for num in 1 .. m_wash_rec.max_num
      
      #今回監査明細READ(合計行)
      d_audit_wash_detail99 = nil
      if not(d_audit_wash.nil?) then
        
        d_audit_wash_detail99 = DAuditWashDetail.find(:first,
                                                      :conditions => ["d_audit_wash_id=? AND m_wash_id=? AND wash_no=99",
                                                                        d_audit_wash.id,
                                                                        m_wash_rec.id])
                                                                        
      end
      
      #売上READ(合計行)
      d_wash_sales_sum99 = nil
      if d_audit_wash_detail99.nil? then
          
          sql = <<-SQL
                    select 
                        coalesce(sum(b.meter), 0)       as sum_meter
                       ,coalesce(sum(b.error_money), 0) as sum_error_money
                    from 
                                  d_wash_sales     a 
                       inner join d_washsale_items b
                    on 
                        a.id = b.d_wash_sale_id
                    where 
                           a.sale_date  >=  '#{@audit_date_from.gsub("/","")}' 
                       and a.sale_date  <=  '#{@audit_date_to.gsub("/","")}'
                       and a.m_shop_id   =  #{@m_shop_id} 
                       and b.m_wash_id   =  #{m_wash_rec.id}
                       and b.wash_no     =  99
                SQL
                
           d_wash_sales_sum99 = DWashSale.find_by_sql(sql)[0]
           
      end  
      
      #合計レコード定義
      dt_rec = Hash.new 
      dt_rec[:audit_date_from] = @audit_date_from.gsub("/","")    #d_audit_washes.audit_date_from
      dt_rec[:audit_date_to] = @audit_date_to.gsub("/","")        #d_audit_washes.audit_date_to
      dt_rec[:audit_class] = session[:audit_class]                #d_audit_washes.audit_class
      dt_rec[:m_shop_id] = @m_shop_id           #d_audit_washes.m_shop_id
      dt_rec[:m_wash_id] = m_wash_rec.id        #d_audit_wash_details.m_wash_id
      dt_rec[:wash_cd]   = m_wash_rec.wash_cd   #洗車機CD
      dt_rec[:wash_name] = m_wash_rec.wash_name #洗車機名
      dt_rec[:max_num]   = m_wash_rec.max_num   #洗車機最大数
      dt_rec[:wash_no] = 99                #d_audit_wash_details.wash_no
      dt_rec[:t_meter] = 0                 #当日メータ(明細のみ)
      dt_rec[:z_meter] = 0                 #前回メータ(明細のみ)
      dt_rec[:k_uri] = k_uri_sum           #計算上売上高
      dt_rec[:g_uri] = 0                   #現金売上高(合計行のみ)
      dt_rec[:gosa] = 0                    #誤差(合計行のみ)
      
      if not(d_audit_wash_detail99.nil?) then
        #前回登録済み
        dt_rec[:g_uri]     = d_audit_wash_detail99.meter
        dt_rec[:gosa]      = d_audit_wash_detail99.error_money
      else
        #売上集計
        dt_rec[:g_uri]     = d_wash_sales_sum99.sum_meter.to_i
        dt_rec[:gosa]      = d_wash_sales_sum99.sum_error_money.to_i
      end 
      
      @dt.push dt_rec
    
    end #for m_wash_rec in m_wash  
  
  end
  
  # from～toのコンボ用データ読込
  def load_from_to(audit_class, m_shop_id)
    
    #監査日FromTo読み込み
    @from = Array.new    
    @to   = Array.new
    a_audit_washs = DAuditWash.find(:all, 
                                    :conditions => ["audit_class=? AND m_shop_id=?", 
                                                    audit_class,
                                                    m_shop_id],      
                                    :order => "audit_date_from desc")
    
    if a_audit_washs.length == 0 then
      @from.push '0000/00/00'
      @to.push   ''  
    else
      @from.push Date.strptime(a_audit_washs[0].audit_date_to, "%Y%m%d").next.strftime('%Y/%m/%d')
      @to.push   ''

      for d_audit_wash_rec in a_audit_washs
        if d_audit_wash_rec.audit_date_from == '00000000' then
          @from.push '0000/00/00'
        else
          @from.push Date.strptime(d_audit_wash_rec.audit_date_from, "%Y%m%d").strftime('%Y/%m/%d')
        end
        @to.push   Date.strptime(d_audit_wash_rec.audit_date_to, "%Y%m%d").strftime('%Y/%m/%d')
      end

    end    
    
  end
  
end
