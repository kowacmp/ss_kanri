# -*- coding:utf-8 -*-
class DSalesController < ApplicationController
  
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper
  include DSalesHelper
  
  # GET /d_sales
  # GET /d_sales.json
  def index

    @head = DSale.new

    if params[:input_day] == nil
      # UPDATE 2012.09.29 日付の規定値を前日にする
      #@head[:input_day] = Time.now.localtime.strftime("%Y/%m/%d")
      @head[:input_day] = (Time.now - 60*60*24).localtime.strftime("%Y/%m/%d")
      @head[:input_shop_kbn] = nil
    else
      @head[:input_day] = params[:input_day]
      @head[:input_shop_kbn] = params[:input_shop_kbn]
    end
    
    #対象データを取得
    @result_datas = result_datas_get(@head[:input_day], @head[:input_shop_kbn])
    
    respond_to do |format|
      if params[:remote]
        format.html { render :partial => 'result'  }
      else
        format.html 
      end
      format.json { render json: @d_sale }
    end
  end

  # GET /d_sales/1
  # GET /d_sales/1.json
  def show
    @d_sale = DSale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_sale }
    end
  end

  # GET /d_sales/new
  # GET /d_sales/new.json
  def new
p params
    @head = DSale.new
        
    #売上入力確認から飛んできた時は、IDがくるのでIDでデータを取得する
    if params[:from_view] == "index" 
       @head[:input_shop_kbn] = params[:input_shop_kbn]
       @head[:from_view] = params[:from_view]
    end
    if params[:id] != nil
       key_data =  DSale.find(params[:id])
       params[:m_shop_id] = key_data.m_shop_id
       params[:input_day] = key_data.sale_date.to_s[0,4] + "/" + key_data.sale_date.to_s[4,2] + "/" + key_data.sale_date.to_s[6,2]
    end
    
    
    if params[:m_shop_id] == nil
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:m_shop_id]
    end

    if params[:input_day] == nil
      #UPDATE 2012.09.29 日付の規定値を前日にする
      #@head[:input_day] = Time.now.localtime.strftime("%Y/%m/%d")
      @head[:input_day] = (Time.now - 60*60*24).localtime.strftime("%Y/%m/%d")
    else
       @head[:input_day] = params[:input_day]
    end

#p "m_shop_id=#{@m_shop_id}"
#p "sale_date=" + @head[:input_day].to_s.gsub("/", "")
    #データ取得
    @d_sale = DSale.find(:first,
       :conditions=>["m_shop_id = ? and sale_date = ? ", @m_shop_id, @head[:input_day].to_s.gsub("/", "")])
#p "@d_sale=#{@d_sale}"       
    new_record_flg = false #新規か更新かを判断するフラグ
    if @d_sale == nil 
      @d_sale = DSale.new
      @d_sale.m_shop_id = @m_shop_id
      @d_sale.sale_date = @head[:input_day].to_s.gsub("/", "")
      @d_sale.kakutei_flg = 0
      
      new_record_flg = true
    end
    
    #前日データを取得
    zenjitu = @d_sale.sale_date
    zenjitu = (Date.new(zenjitu.to_s[0,4].to_i, zenjitu.to_s[4,2].to_i, zenjitu.to_s[6,2].to_i) - 1).strftime("%Y%m%d")
    
    @zenjitu_d_sale = DSale.find(:first,
       :conditions=>["m_shop_id = ? and sale_date = ? ", @m_shop_id, zenjitu])
    if @zenjitu_d_sale == nil 
      @zenjitu_d_sale = DSale.new
    end
 
    #固定釣銭機情報を取得
    taisyo_m = (@head[:input_day].to_s.gsub("/", "")).to_s[4,2].to_i
    m_fix_moneys = MFixMoney.find(:all, :conditions=>["m_shop_id = ? ", @m_shop_id])    
    @m_fix_money = MFixMoney.new
    
    m_fix_moneys.each_with_index {|data, i|
      
      if data.start_month > data.end_month
        if (taisyo_m >= data.start_month and taisyo_m <= 12) or 
           (taisyo_m >= 1 and taisyo_m <= data.end_month)
          @m_fix_money = data 
          break
        end
      else
        if taisyo_m >= data.start_month and taisyo_m <= data.end_month
          @m_fix_money = data
          break
        end
      end
 
    }
    
    
    if @m_fix_money == nil
      @m_fix_money = MFixMoney.new  
    end
    # 2012/09/24 oda 算出項目がnilの場合、算出不可 start
    #売上1
    if @d_sale.sale_money1 == nil
      @d_sale.sale_money1=0
    end
    #売上2
    if @d_sale.sale_money2 == nil
      @d_sale.sale_money2=0
    end
    #売上3
    if @d_sale.sale_money3 == nil
      @d_sale.sale_money3=0
    end
    #ﾌﾟﾘｶ
    if @d_sale.sale_purika == nil
      @d_sale.sale_purika=0
    end
    #ass
    if @d_sale.sale_ass == nil
      @d_sale.sale_ass=0
    end
    #釣銭機1
    if @d_sale.sale_change1 == nil
      @d_sale.sale_change1=0
    end
    #釣銭機2
    if @d_sale.sale_change2 == nil
      @d_sale.sale_change2=0
    end
    #釣銭機3
    if @d_sale.sale_change3 == nil
      @d_sale.sale_change3=0
    end
    #翌日出前
    if @d_sale.sale_am_out == nil
      @d_sale.sale_am_out=0
    end
    #当日出
    if @d_sale.sale_today_out == nil
      @d_sale.sale_today_out=0
    end
    #翌日出後
    if @d_sale.sale_pm_out == nil
      @d_sale.sale_pm_out=0
    end
    #前日翌日出後
    if @zenjitu_d_sale.sale_pm_out == nil
      @zenjitu_d_sale.sale_pm_out=0
    end
    
    #その他売上
    if @d_sale.sale_etc == nil
      @d_sale.sale_etc=0
    end
    
    #ブランクのはマスタから固定金庫をセット  
    if @d_sale.sale_cashbox == 0 and new_record_flg == true
      @d_sale.sale_cashbox = @m_fix_money.total_cash_box.to_i 
    end
    
    
    # 2012/09/24 oda 算出項目がnilの場合、算出不可 end
    @syo_total=@d_sale.sale_money1.to_i + @d_sale.sale_money2.to_i + @d_sale.sale_money3.to_i + @d_sale.sale_purika.to_i + @d_sale.recive_money.to_i - @d_sale.pay_money.to_i 
    # 2012/09/28 算出式変更 翌日出前を加算 oda
    #@total = @syo_total.to_i + @zenjitu_d_sale.sale_cashbox.to_i + @zenjitu_d_sale.sale_changebox.to_i + @d_sale.sale_ass.to_i
    #@total = @syo_total.to_i + @zenjitu_d_sale.sale_cashbox.to_i + (@zenjitu_d_sale.sale_changebox.to_i - (@zenjitu_d_sale.sale_am_out.to_i + @zenjitu_d_sale.sale_pm_out.to_i) + (@d_sale.sale_am_out.to_i + @d_sale.sale_pm_out.to_i)) + @d_sale.sale_ass.to_i
    # 2012/09/30 合計 算出式変更 nishimura <<<
    #@total = @syo_total.to_i + @zenjitu_d_sale.sale_cashbox.to_i + (@zenjitu_d_sale.sale_changebox.to_i - (@zenjitu_d_sale.sale_am_out.to_i + @zenjitu_d_sale.sale_pm_out.to_i) + (@d_sale.sale_am_out.to_i + @d_sale.sale_pm_out.to_i)) + @d_sale.sale_ass.to_i
    @total = @syo_total.to_i + @zenjitu_d_sale.sale_cashbox.to_i + (@zenjitu_d_sale.sale_changebox.to_i - @zenjitu_d_sale.sale_am_out.to_i - @zenjitu_d_sale.sale_pm_out.to_i) + @d_sale.sale_ass.to_i
    # 2012/09/30 合計 算出式変更 nishimura >>>
    # 2012/09/25 ﾚｲｱｳﾄ修正 小田 start
    #@sale_change_total = @d_sale.sale_change1.to_i + @d_sale.sale_change2.to_i + @d_sale.sale_change3.to_i 
    @sale_change_total = @d_sale.sale_change1.to_i + @d_sale.sale_change2.to_i + @d_sale.sale_change3.to_i + @d_sale.sale_etc.to_i
    # 2012/09/25 ﾚｲｱｳﾄ修正 小田 end
    # 2012/09/28 算出式変更 翌日出前+翌日出後を加算 oda
    #@changebox_aridaka = @zenjitu_d_sale.sale_pm_out.to_i + @d_sale.sale_today_out.to_i + @sale_change_total - @syo_total - @d_sale.sale_ass.to_i - @zenjitu_d_sale.sale_pm_out.to_i 
    @changebox_aridaka = (@d_sale.sale_pm_out.to_i + @d_sale.sale_am_out.to_i) + @zenjitu_d_sale.sale_pm_out.to_i + @d_sale.sale_today_out.to_i + @sale_change_total - @syo_total - @d_sale.sale_ass.to_i - @zenjitu_d_sale.sale_pm_out.to_i 

    # 2012/09/30 算出式変更 釣銭有高1 + 釣銭有高2 + 当日出 nishimura
    #@cash_aridaka = @m_fix_money.total_cash_box.to_i + @changebox_aridaka.to_i + @d_sale.sale_today_out.to_i + @d_sale.sale_am_out.to_i + @d_sale.sale_pm_out.to_i 
    @cash_aridaka = @d_sale.sale_cashbox.to_i + @sale_change_total.to_i + @d_sale.sale_today_out.to_i
    #@cash_aridaka = @m_fix_money.total_cash_box.to_i + @changebox_aridaka.to_i + @d_sale.sale_today_out.to_i + @d_sale.sale_pm_out.to_i 

    
    #@d_sale.sale_changebox = @changebox_aridaka #釣銭機固定金庫
    @d_sale.sale_changebox = @sale_change_total #釣銭有高2    
    @d_sale.exist_money = @cash_aridaka #現金有高
    @d_sale.over_short = @cash_aridaka - @total #過不足
    
    respond_to do |format|
      if params[:remote]
        p "@d_sale=#{@d_sale.sale_money1}"
        format.html { render :partial => 'form'  }
      else
        format.html 
      end
      format.json { render json: @d_sales }
    end 
  end

  # GET /d_sales/1/edit
  def edit
    @d_sale = DSale.find(params[:id])
    
  end

  # POST /d_sales
  # POST /d_sales.json
  def create
    p "create params[:d_sale]=#{params[:d_sale]}"
    @d_sale = DSale.new(params[:d_sale])

    @d_sale.created_user_id = current_user.id
    @d_sale.updated_user_id = current_user.id
    
    respond_to do |format|
      if @d_sale.save
        update_d_sale_item(params, @d_sale.id)
        #format.html { redirect_to @d_sale, notice: 'D sale was successfully created.' }
        
        #2012/09/29 nishimura <<<<<<<<<<<<<<<<<<<<<
        #input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
        #format.html { redirect_to :controller => "d_sales", :action => "new", :input_day => input_day }
        if params[:head_from_view] == "index"
          format.html { redirect_to :controller => "d_sales", :action => "new", :id => @d_sale.id, :input_shop_kbn=>params[:head_input_shop_kbn], :from_view=>params[:head_from_view]  }
        else
          input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
          format.html { redirect_to :controller => "d_sales", :action => "new", :input_day => input_day }
        end
        #2012/09/29 nishimura >>>>>>>>>>>>>>>>>>>>
        format.json { render json: @d_sale, status: :created, location: @d_sale }
      else
        format.html { render action: "index" }
        format.json { render json: @d_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_sales/1
  # PUT /d_sales/1.json
  def update
    @d_sale = DSale.find(params[:id])


    @d_sale.updated_user_id = current_user.id
    
    respond_to do |format|
      if @d_sale.update_attributes(params[:d_sale])
        update_d_sale_item(params, @d_sale.id)
        #format.html { redirect_to @d_sale, notice: 'D sale was successfully updated.' }
        
        if params[:head_from_view] == "index"
          format.html { redirect_to :controller => "d_sales", :action => "new", :id => @d_sale.id, :input_shop_kbn=>params[:head_input_shop_kbn], :from_view=>params[:head_from_view]  }
        else
          input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
          format.html { redirect_to :controller => "d_sales", :action => "new", :input_day => input_day } 
        end
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @d_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_sales/1
  # DELETE /d_sales/1.json
  def destroy
    @d_sale = DSale.find(params[:id])
    @d_sale.destroy

    respond_to do |format|
      format.html { redirect_to d_sales_url }
      format.json { head :ok }
    end
  end

  def destroy_d_sale_item
    #@d_sale_item = DSaleItem.find(params[:id])
    #@d_sale_item.destroy
    @index = params[:index]
    @kbn = params[:kbn]
    
    respond_to do |format|
      #format.html { redirect_to d_sales_url }
      #format.json { head :ok }
      format.js { render :layout => false }
    end
  end
  
  #売上現金管理表
  def report_view
    
    #p "report_view"
    
    @head = DSale.new
        
    if params[:from_controller] == "d_sale_approves"
      key_data = DSaleReport.find(params[:id])
      @head[:m_shop_id] = key_data.m_shop_id
      @head[:input_day] = key_data.sale_date.to_s[0,4] + "/" + key_data.sale_date.to_s[4,2] + "/01"
      @head[:input_ym] = params[:header][:ym]
      @head[:input_shop_kbn] = params[:header][:shop_kbn]
      @head[:input_zumi_flg] = params[:header][:zumi_flg]
    else
      key_data =  DSale.find(params[:id])
      @head[:m_shop_id] = key_data.m_shop_id
      @head[:input_day] = key_data.sale_date.to_s[0,4] + "/" + key_data.sale_date.to_s[4,2] + "/" + key_data.sale_date.to_s[6,2]
      @head[:input_shop_kbn] = params[:input_shop_kbn]
    end
    
    @from_controller = params[:from_controller]

    #決算月を取得
    m_shop = MShop.find(@head[:m_shop_id])
    #前月を取得
    date = Date.new(key_data.sale_date.to_s[0,4].to_i, key_data.sale_date.to_s[4,2].to_i, 1) -1
    end_ym = date.strftime("%Y%m")
#p ">>>>>>>>>>>>> key_data.sale_date.to_s[4,2]=#{key_data.sale_date.to_s[4,2]}"
#p ">>>>>>>>>>>>> end_ym=#{end_ym}"
#p ">>>>>>>>>>>>> m_shop.settling_month=#{m_shop.settling_month}"

#UPDATE BEGIN 2012.12.07 前月末現金有高, 前月末過不足の計算方法を修正
=begin
    #前月が決算月の場合は前月なし
    if m_shop.settling_month.blank? or m_shop.settling_month.to_i == end_ym.to_s[4,2].to_i 
      @d_sale_zengetumatu = DSale.new
    else
      
      #開始年月
      if m_shop.settling_month != 12 and
         key_data.sale_date.to_s[4,2].to_i <= m_shop.settling_month
        start_y = key_data.sale_date.to_s[0,4].to_i - 1
      else
        start_y = key_data.sale_date.to_s[0,4].to_i
      end
      if m_shop.settling_month == 12
        start_m = 1
      else
        start_m = m_shop.settling_month + 1
      end
      date = Date.new(start_y.to_i, start_m, 1) 
      start_ym = date.strftime("%Y%m")
 #     p ">>>>>>>>>>>>>> start_ym=#{start_ym}"     
      
      select_sql = "select sum(exist_money) exist_money, sum(over_short) over_short from d_sales where m_shop_id = ? and sale_date between ? and ?"
      @d_sale_zengetumatu = DSale.find_by_sql([select_sql, @head[:m_shop_id], start_ym.to_s + '01', end_ym.to_s + '31' ])
      
      unless @d_sale_zengetumatu[0]
          @d_sale_zengetumatu = DSale.new
      else
          @d_sale_zengetumatu = @d_sale_zengetumatu[0]
      end
    end
    
#    @d_sale_zengetumatu = DSale.find(:first, :conditions=>["m_shop_id = ? and sale_date = ?", @head[:m_shop_id], zengetumatu]) 
#    
#    unless @d_sale_zengetumatu 
#        @d_sale_zengetumatu = DSale.new
#    end    
=end

    @d_sale_zengetumatu = DSale.new
    
    # 前月末現金有高は前月データ末尾の現金有高とする
    d_condtion = ["m_shop_id = ? and sale_date <= ?", @head[:m_shop_id], end_ym.to_s + '31']
    d_sale_last = DSale.find(:first, :conditions => d_condtion, :order => "sale_date desc")
    if d_sale_last.blank? 
      @d_sale_zengetumatu.exist_money = 0
    else
      @d_sale_zengetumatu.exist_money = d_sale_last.exist_money.to_i
    end
    
    # 前月末過不足は期首～前月までの過不足金の計
    if m_shop.settling_month.blank? or m_shop.settling_month.to_i == end_ym.to_s[4,2].to_i 
      @d_sale_zengetumatu.over_short = 0 # 今月が期首のため前月末は0とする
    else
      
      #開始年月
      if m_shop.settling_month != 12 and
         key_data.sale_date.to_s[4,2].to_i <= m_shop.settling_month
        start_y = key_data.sale_date.to_s[0,4].to_i - 1
      else
        start_y = key_data.sale_date.to_s[0,4].to_i
      end
      if m_shop.settling_month == 12
        start_m = 1
      else
        start_m = m_shop.settling_month + 1
      end
      date = Date.new(start_y.to_i, start_m, 1) 
      start_ym = date.strftime("%Y%m")
      
      d_condtion = ["m_shop_id = ? and sale_date between ? and ?", @head[:m_shop_id], start_ym + '01', end_ym.to_s + '31']
      @d_sale_zengetumatu.over_short = DSale.sum(:over_short, :conditions => d_condtion).to_i
      
    end
    
#UPDATE BEGIN 2012.12.07 前月末現金有高, 前月末過不足の計算方法を修正

    #その他売上合計
    select_sql = "select sum(a.item_money) item_money "
    select_sql << " from d_sale_items a inner join d_sales b on a.d_sale_id = b.id "
    select_sql << " where a.item_class = 4 and b.m_shop_id= #{@head[:m_shop_id]} and b.sale_date between '#{key_data.sale_date.to_s[0,6]}01' and '#{key_data.sale_date.to_s[0,6]}99' "
    @etc_item_total = DSaleItem.find_by_sql(select_sql)
    @etc_item_total = @etc_item_total[0]
    
    #印刷場合は出力ロジックへ
    if params[:output] == "print"
      report_print #印刷
    else
      respond_to do |format|
        format.html 
        format.json { render json: @d_sale }
      end 
    end   
  end
     
  #D_SALE_IMTES update
  def update_d_sale_item(params, d_sale_id)

    #出金
    20.times{ |i|
          pay_item = params[:pay_item][i.to_s]
          update_flg = 0
          
          if pay_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.item_class = 0
            d_sale_item.created_user_id = current_user.id
            
            
            update_flg = 1 unless pay_item["m_item_id"].blank?
            update_flg = 1 unless pay_item["item_money"].blank?
            update_flg = 1 unless pay_item["item_name"].blank?
            
          else
            #update
            d_sale_item = DSaleItem.find(pay_item["id"])
            
            update_flg = 1 if d_sale_item.m_item_id != pay_item["m_item_id"]
            update_flg = 1 if d_sale_item.item_money != pay_item["item_money"]
            update_flg = 1 if d_sale_item.item_name != pay_item["item_name"]
            
          end    
          
          if update_flg == 1
            d_sale_item.m_item_id = pay_item["m_item_id"]
            d_sale_item.item_money = pay_item["item_money"]
            d_sale_item.item_name = pay_item["item_name"]
            
            d_sale_item.updated_user_id = current_user.id
            
            #内容が空だったら削除する
            if d_sale_item.m_item_id.blank? and 
              d_sale_item.item_money.blank? and
              d_sale_item.item_name.blank?
              d_sale_item.destroy
            else
              d_sale_item.save
            end
            
          end
    }

    #入金
    20.times{ |i|
          recive_item = params[:recive_item][i.to_s]
          update_flg = 0
          
          if recive_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.item_class = 1
            d_sale_item.created_user_id = current_user.id
            
            update_flg = 1 unless recive_item["m_item_id"].blank?
            update_flg = 1 unless recive_item["item_money"].blank?
            update_flg = 1 unless recive_item["item_name"].blank?
            
          else
            #update
            d_sale_item = DSaleItem.find(recive_item["id"])
            
            update_flg = 1 if d_sale_item.m_item_id != recive_item["m_item_id"]
            update_flg = 1 if d_sale_item.item_money != recive_item["item_money"]
            update_flg = 1 if d_sale_item.item_name != recive_item["item_name"]
            
          end    
          
          if update_flg == 1
            d_sale_item.m_item_id = recive_item["m_item_id"]
            d_sale_item.item_money = recive_item["item_money"]
            d_sale_item.item_name = recive_item["item_name"]
            
            d_sale_item.updated_user_id = current_user.id
                        
            #内容が空だったら削除する
            if d_sale_item.m_item_id.blank? and 
              d_sale_item.item_money.blank? and
              d_sale_item.item_name.blank?
              d_sale_item.destroy
            else
              d_sale_item.save
            end

          end
    }
    #その他
    10.times{ |i|
          etc_item = params[:etc_item][i.to_s]
          update_flg = 0
          
          if etc_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.created_user_id = current_user.id
            
            update_flg = 1 unless etc_item["m_item_id"].blank?
            update_flg = 1 unless etc_item["item_money"].blank?
            update_flg = 1 unless etc_item["item_name"].blank?
            
          else
            #update
            d_sale_item = DSaleItem.find(etc_item["id"])
            
            update_flg = 1 if d_sale_item.m_item_id != etc_item["m_item_id"]
            update_flg = 1 if d_sale_item.item_money != etc_item["item_money"]
            update_flg = 1 if d_sale_item.item_name != etc_item["item_name"]
            
          end    
          
          if update_flg == 1
            
            d_sale_item.m_item_id = etc_item["m_item_id"]
            #内訳種別はm_item_idから取得する
            unless d_sale_item.m_item_id.blank?
              m_item = MItem.find(d_sale_item.m_item_id)
            else
              m_item = MItem.new
            end
            d_sale_item.item_class = m_item.item_class
            d_sale_item.item_money = etc_item["item_money"]
            d_sale_item.item_name = etc_item["item_name"]
            
            d_sale_item.updated_user_id = current_user.id
                        
            #内容が空だったら削除する
            if d_sale_item.m_item_id.blank? and 
              d_sale_item.item_money.blank? and
              d_sale_item.item_name.blank?
              d_sale_item.destroy
            else
              d_sale_item.save
            end

          end
    }
    
    #プリカ
    10.times{ |i|
          purika_item = params[:purika_item][i.to_s]
          if purika_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.item_class = 2
            d_sale_item.created_user_id = current_user.id
            
            update_flg = 0
            update_flg = 1 unless purika_item["item_name"].blank?
            update_flg = 1 unless purika_item["m_shop_id"].blank?
            update_flg = 1 unless purika_item["item_money"].blank?
          else
            #update
            d_sale_item = DSaleItem.find(purika_item["id"])
            
            update_flg = 1 if d_sale_item.item_name != purika_item["item_name"]
            update_flg = 1 if d_sale_item.m_shop_id != purika_item["m_shop_id"]
            update_flg = 1 if d_sale_item.item_money != purika_item["item_money"]
          end    
          
          if update_flg == 1
            d_sale_item.item_name = purika_item["item_name"].strip
            d_sale_item.m_shop_id = purika_item["m_shop_id"]
            d_sale_item.item_money = purika_item["item_money"]
            
            d_sale_item.updated_user_id = current_user.id
            
            #内容が空だったら削除する
            if d_sale_item.item_name.blank? and 
              d_sale_item.m_shop_id.blank? and
              d_sale_item.item_money.blank?
              d_sale_item.destroy
            else
              d_sale_item.save
            end

          end
    }
  end
  
  #ロック／解除
  def lock
    p "params[:id]=#{params[:id]}"
    p "params[:kakutei_flg]=#{params[:kakutei_flg]}"
    
    d_sale = DSale.find(params[:id])
    if params[:kakutei_flg] == "checked" 
      d_sale.kakutei_flg = 1 #ロックする
    else
      d_sale.kakutei_flg = 0 #解除する
    end
    d_sale.updated_user_id = current_user.id
    d_sale.save
  end
  
  #すべてロック／解除
  def all_lock
    p "params[:input_day]=#{params[:input_day]}"
    p "params[:input_shop_kbn]=#{params[:input_shop_kbn]}"
    p "params[:kakutei_flg]=#{params[:kakutei_flg]}"
    @head = DSale.new
    @head[:input_day] = params[:input_day]
    @head[:input_shop_kbn] = params[:input_shop_kbn]

    if params[:kakutei_flg] == "checked" 
      @all_kakutei_flg = 1
    else
      @all_kakutei_flg = 0
    end    
        
    update_sql = "update d_sales "
    update_sql << " set kakutei_flg = #{@all_kakutei_flg} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where sale_date = '#{@head[:input_day].to_s.gsub("/", "")}' "
    unless @head[:input_shop_kbn].blank?
      update_sql << " and m_shop_id in (select id from m_shops where shop_kbn = #{@head[:input_shop_kbn]}) "
    end
    
    ActiveRecord::Base::connection.execute(update_sql)
    
    #対象データを取得
    @result_datas = result_datas_get(@head[:input_day], @head[:input_shop_kbn])
    
    respond_to do |format|
      format.html { render :partial => 'result'  }
    end 
    
  end
  
  private
  
  #売上入力状況一覧の表示対象データを取得
  def result_datas_get(input_day, input_shop_kbn)
    select_sql = "select b.shop_cd, b.shop_name, b.shop_kbn "
    select_sql << " , a.id, a.sale_date, a.created_user_id, a.kakutei_flg "
    select_sql << " , c.account, c.user_name "
    select_sql << " , d.code_name shop_kbn_name " 
    select_sql << " from m_shops b " 
    select_sql << " left join (select * from d_sales where sale_date = '#{input_day.to_s.gsub("/", "")}') a on a.m_shop_id = b.id " 
    select_sql << " left join users c on a.created_user_id = c.id " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') d on b.shop_kbn = cast(d.code as integer) "

    condition_sql = " where b.deleted_flg = 0 "
    condition_sql << " and b.shop_kbn <> 9 " #2012/10/01 nishimura
    if input_shop_kbn.blank?
    else
      condition_sql << " and b.shop_kbn = " + input_shop_kbn
    end    
         
    #p "select_sql=#{select_sql}"
    return DSale.find_by_sql("#{select_sql} #{condition_sql} order by shop_cd")    
  end
  
  #売上管理表印刷
  def report_print
    #データセット
    m_shop = MShop.find(@head[:m_shop_id])
    
    #フッター出力項目退避エリア
    footer = Hash::new
    footer[:cash_money] = ""
    footer[:coin_tesuryo] = ""
    footer[:suito_zan] = ""
    footer[:uketori_tesuryo] = "" #2012/10/02 nishimura
   
    d_sale_total = Hash::new #合計データ
    d_sale_total = calc_total(d_sale_total,true) #初期化
    
    #設計ファイルOPEN
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_sale_report.tlf')
 
   report.layout.config.list(:report_list) do
    # フッターに合計をセット.
      events.on :footer_insert do |e|
        e.section.item(:footer_cash_money).value(footer[:cash_money])
        e.section.item(:footer_coin_tesuryo).value(footer[:coin_tesuryo])
        e.section.item(:footer_suito_zan).value(footer[:suito_zan])
        e.section.item(:footer_uketori_tesuryo).value(footer[:uketori_tesuryo]) #2012/10/02 nishimura
        e.section.item(:footer_d_sale_kei).value(footer[:d_sale_kei])
        e.section.item(:footer_over_short).value(footer[:over_short])
        
        e.section.item(:total_day).value("計")
        e.section.item(:total_sale_money).value((d_sale_total[:sale_money].to_i)) 
        e.section.item(:total_sale_purika).value((d_sale_total[:sale_purika].to_i))
        e.section.item(:total_sonota_money).value((d_sale_total[:sonota_money].to_i))
        e.section.item(:total_recive_money).value((d_sale_total[:recive_money].to_i))
        e.section.item(:total_pay_money).value((d_sale_total[:pay_money].to_i))
        e.section.item(:total_d_sale_syokei).value((d_sale_total[:d_sale_syokei].to_i))
        e.section.item(:total_sale_ass).value((d_sale_total[:sale_ass].to_i))
        e.section.item(:total_d_sale_ass).value((d_sale_total[:d_sale_ass].to_i))
        e.section.item(:total_d_sale_sale_out).value((d_sale_total[:sale_today_out].to_i))
        e.section.item(:total_sale_out).value((d_sale_total[:sale_am_out].to_i + d_sale_total[:sale_pm_out].to_i))
        e.section.item(:total_d_sale_sale).value(d_sale_total[:sale_today_out].to_i + d_sale_total[:sale_am_out].to_i + d_sale_total[:sale_pm_out].to_i)
        e.section.item(:total_calc_exist_money).value((d_sale_total[:d_sale_calc_aridaka].to_i))
        e.section.item(:total_exist_money).value((d_sale_total[:d_sale_cash_aridaka].to_i))
        e.section.item(:total_over_short).value((d_sale_total[:kabusoku].to_i))
        
        #2012/10/02 出金誤差追加 nishimura <<<
        error_money_total = d_sale_total[:sale_am_out].to_i + d_sale_total[:sale_pm_out].to_i + d_sale_total[:sale_today_out].to_i - 
                              d_sale_total[:d_sale_syokei].to_i - d_sale_total[:sale_ass].to_i
        e.section.item(:total_error_money).value((error_money_total))
                
      end #events.on
    end

    report.start_new_page

    report.page.list(:report_list).header do |h|
      h.item(:title).value("#{m_shop.shop_name} 売上・現金管理表")
      h.item(:sale_date).value("#{@head[:input_day][0,4]}年#{@head[:input_day][5,2]}月")
      h.item(:zengetumatu_exist_money).value(num_fmt(@d_sale_zengetumatu.exist_money))
      h.item(:zengetumatu_over_short).value(num_fmt(@d_sale_zengetumatu.over_short))
    end
    
    
    #繰り返し
    loopcnt = (Date.new(@head[:input_day].to_s[0,4].to_i, @head[:input_day].to_s[5,2].to_i, -1)).strftime("%d").to_i 
    loopcnt.times { |i| 
      select_day = Date.new(@head[:input_day].to_s[0,4].to_i, @head[:input_day].to_s[5,2].to_i, i + 1)        
      @d_sale, @zenjitu_d_sale = get_d_sales_data(select_day.strftime("%Y%m%d"))
      
                       
      #明細データセット
      report.page.list(:report_list).add_row do |row|
        
        row.item(:day).value(i + 1)
        row.item(:week).value(day_of_the_week(select_day.wday))
        if @d_sale
          row.item(:sale_money).value(num_fmt(@d_sale.sale_money)) 
          row.item(:sale_purika).value(num_fmt(@d_sale.sale_purika))
          row.item(:purika_tesuryo).value(num_fmt(@d_sale.purika_tesuryo))
          row.item(:sonota_money).value(num_fmt(@d_sale.sonota_money))
          row.item(:recive_money).value(num_fmt(@d_sale.recive_money))
          row.item(:pay_money).value(num_fmt(@d_sale.pay_money))
          row.item(:d_sale_syokei).value(num_fmt(@d_sale_syokei))
          row.item(:sale_ass).value(num_fmt(@d_sale.sale_ass))
          row.item(:d_sale_ass).value(num_fmt(@d_sale_ass))
          #row.item(:zenjitu_d_sale_sale_pm_out).value(num_fmt(@zenjitu_d_sale.sale_pm_out))
          row.item(:zenjitu_d_sale_sale_pm_out).value(0)
          row.item(:sale_today_out).value(num_fmt(@d_sale.sale_today_out))
          row.item(:sale_am_out).value(num_fmt(@d_sale.sale_am_out))
          row.item(:sale_pm_out).value(num_fmt(@d_sale.sale_pm_out))
          row.item(:calc_exist_money).value(num_fmt(@calc_exist_money))
          row.item(:exist_money).value(num_fmt(@d_sale.exist_money))
          row.item(:over_short).value(num_fmt(@d_sale.over_short))
          
          #2012/10/02 出金誤差追加 nishimura <<<
          error_money = @d_sale.sale_am_out + @d_sale.sale_pm_out + @d_sale.sale_today_out - 
                          @d_sale_syokei - @d_sale.sale_ass
          row.item(:error_money).value(num_fmt(error_money)) 
          #2012/10/02 出金誤差追加 nishimura >>>
          
        end
        d_sale_total = calc_total(d_sale_total)
      end
    }
    #合計行
#    report.page.list(:report_list).add_row do |row|
#      row.item(:day).value("計")
#      row.item(:sale_money).value(num_fmt(d_sale_total[:sale_money])) 
#      row.item(:sale_purika).value(num_fmt(d_sale_total[:sale_purika]))
#      row.item(:purika_tesuryo).value(num_fmt(d_sale_total[:purika_tesuryo]))
#      row.item(:sonota_money).value(num_fmt(d_sale_total[:sonota_money]))
#      row.item(:recive_money).value(num_fmt(d_sale_total[:recive_money]))
#      row.item(:pay_money).value(num_fmt(d_sale_total[:pay_money]))
#      row.item(:d_sale_syokei).value(num_fmt(d_sale_total[:d_sale_syokei]))
#      row.item(:sale_ass).value(num_fmt(d_sale_total[:sale_ass]))
#      row.item(:d_sale_ass).value(num_fmt(d_sale_total[:d_sale_ass]))
#      row.item(:zenjitu_d_sale_sale_pm_out).value(num_fmt(d_sale_total[:zenjitu_d_sale_sale_pm_out]))
#      row.item(:sale_today_out).value(num_fmt(d_sale_total[:sale_today_out]))
#      row.item(:sale_am_out).value(num_fmt(d_sale_total[:sale_am_out]))
#      row.item(:sale_pm_out).value(num_fmt(d_sale_total[:sale_pm_out]))
#      row.item(:calc_exist_money).value(num_fmt(d_sale_total[:d_sale_calc_aridaka]))
#      row.item(:exist_money).value(num_fmt(d_sale_total[:d_sale_cash_aridaka]))
#      row.item(:over_short).value(num_fmt(d_sale_total[:kabusoku]))
#      
#      #2012/10/02 出金誤差追加 nishimura <<<
#      error_money_total = d_sale_total[:sale_am_out] + d_sale_total[:sale_pm_out] + d_sale_total[:sale_today_out] - 
#                            d_sale_total[:d_sale_syokei] - d_sale_total[:sale_ass]
#      row.item(:error_money).value(num_fmt(error_money_total))
#      #2012/10/02 出金誤差追加 nishimura >>>
#
#    end
    
    #フッターにセットする値をセット
    footer[:cash_money] = num_fmt(d_sale_total[:sale_money].to_i - d_sale_total[:purika_tesuryo].to_i)
    footer[:coin_tesuryo] = num_fmt(@etc_item_total.item_money.to_i)
    #footer[:suito_zan] = num_fmt(@d_sale_syokei.to_i + @d_sale_cash_aridaka.to_i)
    footer[:suito_zan] = num_fmt(@balance_money)
    footer[:uketori_tesuryo] = num_fmt(d_sale_total[:purika_tesuryo].to_i) #2012/10/02 nishimura
    footer[:d_sale_kei] = num_fmt(d_sale_total[:d_sale_syokei].to_i + d_sale_total[:sale_ass].to_i) 
    footer[:over_short] = num_fmt(@d_sale_zengetumatu.over_short.to_i + d_sale_total[:kabusoku].to_i)
    
    #PDF出力
    #タイトルセット
    pdf_title = "売上・現金管理表.pdf"
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応

    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'

  end
  
end
