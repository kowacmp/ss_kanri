class MCostNamesController < ApplicationController
  # GET /m_cost_names
  # GET /m_cost_names.json
  def index
    #@m_cost_names = MCostName.all
    
    select_sql = "select a.*, b.shop_cd,b.shop_name "
    select_sql << " ,(case a.monthly_name1 when '' then 0 else 1 end + case a.monthly_name2 when '' then 0 else 1 end + "
    select_sql << "   case a.monthly_name3 when '' then 0 else 1 end + case a.monthly_name4 when '' then 0 else 1 end + "
    select_sql << "   case a.monthly_name5 when '' then 0 else 1 end + case a.monthly_name6 when '' then 0 else 1 end "
    select_sql << "   ) as monthly_name_count "
    select_sql << " ,(case a.hour_name1 when '' then 0 else 1 end + case a.hour_name2 when '' then 0 else 1 end + "
    select_sql << "   case a.hour_name3 when '' then 0 else 1 end + case a.hour_name4 when '' then 0 else 1 end + "
    select_sql << "   case a.hour_name5 when '' then 0 else 1 end + case a.hour_name6 when '' then 0 else 1 end "
    select_sql << "   ) as hour_name_count "
    select_sql << " ,(case a.day_name1 when '' then 0 else 1 end + case a.day_name2 when '' then 0 else 1 end "
    select_sql << "   ) as day_name_count "
    select_sql << " ,(case a.input_name1 when '' then 0 else 1 end + case a.input_name2 when '' then 0 else 1 end + "
    select_sql << "   case a.input_name3 when '' then 0 else 1 end + case a.input_name4 when '' then 0 else 1 end "
    select_sql << "   ) as input_name_count "
    select_sql << " from m_cost_names a " 
    select_sql << " left join (select * from m_shops) b on a.m_shop_id = b.id "
    
    condition_sql = ""
    
    @m_cost_names = MCostName.find_by_sql("#{select_sql} #{condition_sql} order by b.shop_cd")
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_cost_names }
    end
  end

  # GET /m_cost_names/1
  # GET /m_cost_names/1.json
  def show
    @m_cost_name = MCostName.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_cost_name }
    end
  end

  # GET /m_cost_names/new
  # GET /m_cost_names/new.json
  def new
    @m_cost_name = MCostName.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_cost_name }
    end
  end

  # GET /m_cost_names/1/edit
  def edit
    @m_cost_name = MCostName.find(params[:id])
  end

  # POST /m_cost_names
  # POST /m_cost_names.json
  def create
    @m_cost_name = MCostName.new(params[:m_cost_name])

    respond_to do |format|
      if @m_cost_name.save
        format.html { redirect_to :controller => "m_cost_names", :action => "index" }
        #format.html { redirect_to @m_cost_name, notice: 'M cost name was successfully created.' }
        format.json { render json: @m_cost_name, status: :created, location: @m_cost_name }
      else
        format.html { render action: "new" }
        format.json { render json: @m_cost_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_cost_names/1
  # PUT /m_cost_names/1.json
  def update
    @m_cost_name = MCostName.find(params[:id])

    respond_to do |format|
      if @m_cost_name.update_attributes(params[:m_cost_name])
        format.html { redirect_to :controller => "m_cost_names", :action => "index" }
        #format.html { redirect_to @m_cost_name, notice: 'M cost name was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_cost_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_cost_names/1
  # DELETE /m_cost_names/1.json
  def destroy
    @m_cost_name = MCostName.find(params[:id])
    @m_cost_name.destroy

    respond_to do |format|
      format.html { redirect_to m_cost_names_url }
      format.json { head :ok }
    end
  end
end
