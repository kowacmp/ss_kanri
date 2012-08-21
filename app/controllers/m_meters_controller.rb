class MMetersController < ApplicationController
  # GET /m_meters
  # GET /m_meters.json
  def index
    p "meter index----------------"
    @m_meters = MMeter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_meters }
    end
  end

  # GET /m_meters/1
  # GET /m_meters/1.json
  def show
    p "meter show------------------------"
    @m_meter = MMeter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_meter }
    end
  end

  # GET /m_meters/new
  # GET /m_meters/new.json
  def new
    
    p "meter new-------------------------------"
    
    
    @m_shop_id = params[:id]
    
    @m_oil_first = MOil.find(:first, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')
    #@m_oil_id = 1
    
    #@m_oil_id = @m_oil_first.id
    #@m_oil_name = @m_oil_first.oil_name
    
    
    @m_meter = MMeter.new

    @m_codes = MCode.find(:all,:conditions=>["kbn='7'"],:order=>'code')
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')
    
    sql_where = "m_shop_id = ?"
    sql_where = sql_where + " and m_oil_id = ?"
    sql_where = sql_where + " and deleted_flg = ?"
    
    @m_tanks = MTank.find(:all,:conditions => [sql_where,@m_shop_id,@m_oil_first,0], :order => 'tank_no')
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_meter }
    end
  end

  # GET /m_meters/1/edit
  def edit
    @m_meter = MMeter.find(params[:id])
  end

  # POST /m_meters
  # POST /m_meters.json
  def create
    p "meter create------------------------"
    if params[:m_meter]
      params[:m_meter].each do |key,value| 
        
        if value
          value.each do |key2,value2| 
            
            @m_meter = MMeter.find(:first,:conditions=>["id = ?",value2['id']])
            
            if @m_meter == nil then
                @m_meter = MMeter.new(value2)
                #@m_meter.m_oil_id = params[:m_oil][:m_oil_id]
                #タンクが選択されていれば保存
                if value2[:m_tank_id] == ""
                else
                  @m_meter.save
                end  
            else
                #タンクが選択されていれば更新、なければ削除
                if value2[:m_tank_id] == ""
                  @m_meter.destroy
                else
                  @m_meter.update_attributes(value2)
                end 
            end
            
          end
        end
        
      end
    end
    
    redirect_to :controller => "m_shops", :action => "index"
    
    
    #@m_meter = MMeter.new(params[:m_meter])

    #respond_to do |format|
      #if @m_meter.save
      #  format.html { redirect_to @m_meter, notice: 'M meter was successfully created.' }
      #  format.json { render json: @m_meter, status: :created, location: @m_meter }
      #else
      #  format.html { render action: "new" }
      #  format.json { render json: @m_meter.errors, status: :unprocessable_entity }
      #end
    #end
  end

  # PUT /m_meters/1
  # PUT /m_meters/1.json
  def update
    @m_meter = MMeter.find(params[:id])

    respond_to do |format|
      if @m_meter.update_attributes(params[:m_meter])
        format.html { redirect_to @m_meter, notice: 'M meter was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_meters/1
  # DELETE /m_meters/1.json
  def destroy
    @m_meter = MMeter.find(params[:id])
    @m_meter.destroy

    respond_to do |format|
      format.html { redirect_to m_meters_url }
      format.json { head :ok }
    end
  end
  
  
  def search 
    p "search-----------------------------------"
    p params[:m_shop][:m_shop_id]
    
    @m_shop_id = 1
    @m_oil_id = params[:m_oil][:m_oil_id]
    
    @m_oil_first = MOil.find(@m_oil_id)
    
    @m_meter = MMeter.new

    @m_codes = MCode.find(:all,:conditions=>["kbn='7'"],:order=>'code')
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')
    
    sql_where = "m_shop_id = ?"
    sql_where = sql_where + " and m_oil_id = ?"
    sql_where = sql_where + " and deleted_flg = ?"
    
    @m_tanks = MTank.find(:all,:conditions => [sql_where,@m_shop_id,@m_oil_id,0], :order => 'tank_no')
    
  end
  
  
end
