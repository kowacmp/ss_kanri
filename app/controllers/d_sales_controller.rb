class DSalesController < ApplicationController
  
  include ApplicationHelper;
  
  # GET /d_sales
  # GET /d_sales.json
  def index

    @head = DSale.new

    if params[:input_day] == nil
      @head[:input_day] = Time.now.localtime.strftime("%Y/%m/%d")
      @head[:input_shop_kbn] = nil
    else
      @head[:input_day] = params[:input_day]
      @head[:input_shop_kbn] = params[:input_shop_kbn]
    end
    
    select_sql = "select b.shop_cd, b.shop_name, b.shop_kbn "
    select_sql << " , a.id, a.sale_date, a.created_user_id, a.kakutei_flg "
    select_sql << " , c.account, c.user_name "
    select_sql << " , d.code_name shop_kbn_name " 
    select_sql << " from m_shops b " 
    select_sql << " left join (select * from d_sales where sale_date = '#{@head[:input_day].to_s.gsub("/", "")}') a on a.m_shop_id = b.id " 
    select_sql << " left join users c on a.created_user_id = c.id " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') d on b.shop_kbn = cast(d.code as integer) "

    if @head[:input_shop_kbn].blank?
    else
      condition_sql = "where b.shop_kbn = " + @head[:input_shop_kbn]
    end    
         
    @result_datas = DSale.find_by_sql("#{select_sql} #{condition_sql} order by shop_cd")
    
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

    @m_shop_id = current_user.m_shop_id
    @head = DSale.new

    if params[:input_day] == nil
       @head[:input_day] = Time.now.localtime.strftime("%Y/%m/%d")
    else
       @head[:input_day] = params[:input_day]
    end

    #データ取得
    @d_sale = DSale.find(:first,
       :conditions=>["m_shop_id = ? and sale_date = ? ", current_user.m_shop_id, @head[:input_day].to_s.gsub("/", "")])
    if @d_sale == nil 
      @d_sale = DSale.new
      @d_sale.m_shop_id = @m_shop_id
      @d_sale.sale_date = @head[:input_day].to_s.gsub("/", "")
      @d_sale.kakutei_flg = 0
    end
    
    #前日データを取得
    zenjitu = @d_sale.sale_date
    zenjitu = (Date.new(zenjitu.to_s[0,4].to_i, zenjitu.to_s[4,2].to_i, zenjitu.to_s[6,2].to_i) - 1).strftime("%Y%m%d")
    
    @zenjitu_d_sale = DSale.find(:first,
       :conditions=>["m_shop_id = ? and sale_date = ? ", current_user.m_shop_id, zenjitu])
    if @zenjitu_d_sale == nil 
      @zenjitu_d_sale = DSale.new
    end
       
    #固定釣銭機情報を取得
    taisyo_ym = (@head[:input_day].to_s.gsub("/", "")).to_s[0,6]
    @m_fix_money = MFixMoney.find(:first, :conditions=>["m_shop_id = ? and start_month <= ? and end_month >= ? ", current_user.m_shop_id, taisyo_ym.to_i, taisyo_ym.to_i])
    
    if @m_fix_money == nil
      @m_fix_money = MFixMoney.new  
    end
    
    respond_to do |format|
      if params[:remote]
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
        input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
        format.html { redirect_to :controller => "d_sales", :action => "new", :input_day => input_day }
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
        input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
        format.html { redirect_to :controller => "d_sales", :action => "new", :input_day => input_day }
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
    
  #D_SALE_IMTES update
  def update_d_sale_item(params, d_sale_id)

    #出金
    10.times{ |i|
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
    10.times{ |i|
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
    
    p "params[:kbn]=#{params[:kbn]}"
    
    if params[:kbn] == "lock"
      kakutei_flg = 1
    else
      kakutei_flg = 0
    end
    
    update_sql = "update d_sales "
    update_sql << " set kakutei_flg = #{kakutei_flg} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = #{Time.now.to_datetime} "
    update_sql << " where  "
    update_sql << ""
    update_sql << ""
    
    ActiveRecord::Base::connection.execute(update_sql)
    
  end
  
end
