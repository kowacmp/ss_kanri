class DAimsController < ApplicationController

  # GET /d_aims
  # GET /d_aims.json
  def index
    #@d_aims = DAim.all
    date = DateTime.now
    year = date.strftime("%Y")
    month = date.strftime("%m")
    
    #@month_last_day = Date.new(year.to_i,month.to_i,-1).day
    
    if params[:input_year] == nil or params[:input_month] == nil or params[:input_aim] == nil
       @year = year
       @month = month
       @month_first = Date.new(year.to_i,month.to_i,1)
       @search_aim = 1
       @month_last_day = Date.new(year.to_i,month.to_i,-1).day
       #2012/12/30 翌年度入力可対応
       @month_end = Date.new(year.to_i + 1,month.to_i,1)
    else
       @year = params[:input_year]
       @month = params[:input_month]
       @month_first = Date.new(params[:input_year].to_i,params[:input_month].to_i,1)
       @search_aim = params[:input_aim].to_i
       @month_last_day = Date.new(params[:input_year].to_i,params[:input_month].to_i,-1).day
       #2012/12/30 翌年度入力可対応
       @month_end = Date.new(params[:input_year].to_i,params[:input_month].to_i,1)
    end
    
    @d_aim = DAim.new
    
    if params[:input_shop_id] == nil
      @shop_id = current_user.m_shop_id
    else
      @shop_id = params[:input_shop_id]
    end
    
    @mode = params[:mode]
    
    @m_shop = MShop.find(@shop_id)

    #@m_aims = MAim.find(:all,:conditions=>["shop_kbn=? and input_kbn=? and deleted_flg=0",@m_shop.shop_kbn,@search_aim],:order=>"aim_code")

    select_sql = "select a.*, b.code_name as aim_tani_name "
    select_sql << " from m_aims a " 
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.aim_tani = cast(b.code as integer) "

    condition_sql = " where a.deleted_flg=0 "
    condition_sql << "  and a.shop_kbn=#{@m_shop.shop_kbn}"
    if @search_aim.to_i == 0
      condition_sql << "  and a.input_kbn=#{@search_aim}"
    end

    @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_aim }
    end


    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @d_aims }
    #end
  end

  # GET /d_aims/1
  # GET /d_aims/1.json
  def show
    @d_aim = DAim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_aim }
    end
  end

  # GET /d_aims/new
  # GET /d_aims/new.json
  def new
    @d_aim = DAim.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_aim }
    end
  end

  # GET /d_aims/1/edit
  def edit
    @d_aim = DAim.find(params[:id])
  end

  # POST /d_aims
  # POST /d_aims.json
  def create
    @search_aim = params[:search][:aim]
    
    if params[:d_aim]
      params[:d_aim].each do |key,value| 
        
        if @search_aim == "1"
          # 月毎の場合
          value.each do |key2,value2|
            @d_aim = DAim.find(:first,:conditions=>["id = ?",value2['id']])
            
            if @d_aim == nil then
                @d_aim = DAim.new(value2)
                @d_aim.created_user_id = current_user.id
                @d_aim.updated_user_id = current_user.id
                @d_aim.save
            else
                @d_aim.updated_user_id = current_user.id
                @d_aim.update_attributes(value2)
            end
          end
        else
          # 日毎の場合
          @d_aim = DAim.find(:first,:conditions=>["id = ?",value['id']])
          
          if @d_aim == nil then
              @d_aim = DAim.new(value)
              @d_aim.created_user_id = current_user.id
              @d_aim.updated_user_id = current_user.id
              @d_aim.save
          else
              @d_aim.updated_user_id = current_user.id
              @d_aim.update_attributes(value)
          end
        end
      end
    end
    
    
    respond_to do |format|
      input_year = params[:input][:year]
      input_month = params[:input][:month]
      input_aim = params[:input][:aim]
      input_shop_id = params[:input][:shop_id]
      format.html { redirect_to :controller => "d_aims", :action => "index", :input_year => input_year,
                                :input_month => input_month,:input_aim => input_aim,:input_shop_id => input_shop_id }
      format.json { render json: @d_aim, status: :created, location: @d_aim }
    end
    
    #respond_to do |format|
    #  if @d_aim.save
    #    format.html { redirect_to @d_aim, notice: 'D aim was successfully created.' }
    #    format.json { render json: @d_aim, status: :created, location: @d_aim }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @d_aim.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /d_aims/1
  # PUT /d_aims/1.json
  def update
    @d_aim = DAim.find(params[:id])

    respond_to do |format|
      if @d_aim.update_attributes(params[:d_aim])
        format.html { redirect_to @d_aim, notice: 'D aim was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_aims/1
  # DELETE /d_aims/1.json
  def destroy
    @d_aim = DAim.find(params[:id])
    @d_aim.destroy

    respond_to do |format|
      format.html { redirect_to d_aims_url }
      format.json { head :ok }
    end
  end
  
  
  def search 
    @search_aim = params[:search][:aim]
    
    year = params[:date][:year]
    month = params[:date][:month]
    
    @year = format("%04d",year)
    @month = format("%02d",month)
    
    @month_first = Date.new(year.to_i,month.to_i,1)
    @month_last_day = Date.new(year.to_i,month.to_i,-1).day
    
    @d_aim = DAim.new
    
    @mode = params[:input][:mode]
    
    @shop_id = params[:input][:shop_id]
    
    #@m_shop = MShop.find(current_user.m_shop_id)
    @m_shop = MShop.find(@shop_id)
    
    #@m_aims = MAim.find(:all,:conditions=>["shop_kbn=? and input_kbn=? and deleted_flg=0",@m_shop.shop_kbn,@search_aim],:order=>"aim_code")

    select_sql = "select a.*, b.code_name as aim_tani_name "
    select_sql << " from m_aims a " 
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.aim_tani = cast(b.code as integer) "

    condition_sql = " where a.deleted_flg=0 "
    condition_sql << "  and a.shop_kbn=#{@m_shop.shop_kbn}"
    if @search_aim.to_i == 0
      condition_sql << "  and a.input_kbn=#{@search_aim}"
    end

    @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")

  end
  
  
end
