class DSalesController < ApplicationController
  
  include ApplicationHelper;
  
  # GET /d_sales
  # GET /d_sales.json
  def index
    
  
    @m_shop_id = current_user.m_shop_id
    @head = DSale.new
p "params[:input_day]=#{params[:input_day]}"
    if params[:input_day] == nil
       @head[:input_day] = Time.now.localtime.strftime("%Y/%m/%d")
    else
       @head[:input_day] = params[:input_day]
    end
p "@head[:input_day]=#{@head[:input_day]}"
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
       
    respond_to do |format|
      if params[:remote]
        format.html { render :partial => 'form'  }
      else
        format.html # index.html.erb
      end
      format.json { render json: @d_sales }
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
    @d_sale = DSale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_sale }
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

    
    
    respond_to do |format|
      if @d_sale.save
        update_d_sale_item(params, @d_sale.id)
        #format.html { redirect_to @d_sale, notice: 'D sale was successfully created.' }
        input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
        format.html { redirect_to :controller => "d_sales", :action => "index", :input_day => input_day }
        format.json { render json: @d_sale, status: :created, location: @d_sale }
      else
        format.html { render action: "new" }
        format.json { render json: @d_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_sales/1
  # PUT /d_sales/1.json
  def update
    @d_sale = DSale.find(params[:id])

    
    
    respond_to do |format|
      if @d_sale.update_attributes(params[:d_sale])
        update_d_sale_item(params, @d_sale.id)
        #format.html { redirect_to @d_sale, notice: 'D sale was successfully updated.' }
        input_day = @d_sale.sale_date.to_s[0,4] + "/" + @d_sale.sale_date.to_s[4,2] + "/" + @d_sale.sale_date.to_s[6,2]
        format.html { redirect_to :controller => "d_sales", :action => "index", :input_day => input_day }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
    @d_sale_item = DSaleItem.find(params[:id])
    @d_sale_item.destroy
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
          if pay_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.item_class = 0
            d_sale_item.created_user_id = current_user.id
            
            update_flg = 0
            update_flg = 1 unless pay_item["m_item_id"].blank?
            update_flg = 1 unless pay_item["item_money"].blank?
          else
            #update
            d_sale_item = DSaleItem.find(pay_item["id"])
            
            update_flg = 1 if d_sale_item.m_item_id != pay_item["m_item_id"]
            update_flg = 1 if d_sale_item.item_money != pay_item["item_money"]
          end    
          
          if update_flg == 1
            d_sale_item.m_item_id = pay_item["m_item_id"]
            d_sale_item.item_money = pay_item["item_money"]
            
            d_sale_item.updated_user_id = current_user.id
            d_sale_item.save
          end
    }

    #入金
    10.times{ |i|
          recive_item = params[:recive_item][i.to_s]
          if recive_item["id"] == ""
            #insert
            d_sale_item = DSaleItem.new
            d_sale_item.d_sale_id = d_sale_id
            d_sale_item.item_class = 1
            d_sale_item.created_user_id = current_user.id
            
            update_flg = 0
            update_flg = 1 unless recive_item["m_item_id"].blank?
            update_flg = 1 unless recive_item["item_money"].blank?
          else
            #update
            d_sale_item = DSaleItem.find(recive_item["id"])
            
            update_flg = 1 if d_sale_item.m_item_id != recive_item["m_item_id"]
            update_flg = 1 if d_sale_item.item_money != recive_item["item_money"]
          end    
          
          if update_flg == 1
            d_sale_item.m_item_id = recive_item["m_item_id"]
            d_sale_item.item_money = recive_item["item_money"]
            
            d_sale_item.updated_user_id = current_user.id
            d_sale_item.save
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
            d_sale_item.save
          end
    }
  end
end
