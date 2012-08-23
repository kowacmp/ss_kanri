class DAimsController < ApplicationController
  # GET /d_aims
  # GET /d_aims.json
  def index
    @d_aims = DAim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_aims }
    end
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
    p Time.now
    #@today = Time.now
    #@end_day = @today + 6.days
    @today = Date.new(2012,8,1)
    
    @m_shop = MShop.find(current_user.m_shops_id)

    @m_aims = MAim.find(:all,:order=>"aim_code")


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
    
    p "create-----------"
    p params[:d_aim]
    p "-----------------"
    
    if params[:d_aim]
      params[:d_aim].each do |key,value| 
        
            @d_aim = DAim.find(:first,:conditions=>["id = ?",value['id']])
            
            if @d_aim == nil then
                @d_aim = DAim.new(value)
                #@m_meter.m_oil_id = params[:m_oil][:m_oil_id]
                #タンクが選択されていれば保存
                if value2[:m_tank_id] == ""
                else
                  @d_aim.save
                end  
            else
                #タンクが選択されていれば更新、なければ削除
                if value2[:m_tank_id] == ""
                  @d_aim.destroy
                else
                  @d_aim.update_attributes(value)
                end 
            end
            
      end
    end
    
    
    
    
    #@d_aim = DAim.new(params[:d_aim])

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
end
