class MGetPointsController < ApplicationController
  # GET /m_get_points
  # GET /m_get_points.json
  def index
    
    select_sql = "select a.*, b.code_name as rank_name "
    select_sql << " from m_get_points a " 
    select_sql << " left join (select * from m_codes where kbn='rank') b on a.rank = cast(b.code as integer) "
    
    condition_sql = ""
    
    @m_get_points = MGetPoint.find_by_sql("#{select_sql} #{condition_sql} order by a.rank,a.league_rank")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_get_points }
    end
  end

  # GET /m_get_points/1
  # GET /m_get_points/1.json
  def show
    @m_get_point = MGetPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_get_point }
    end
  end

  # GET /m_get_points/new
  # GET /m_get_points/new.json
  def new
    @m_get_point = MGetPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_get_point }
    end
  end

  # GET /m_get_points/1/edit
  def edit
    @m_get_point = MGetPoint.find(params[:id])
  end

  # POST /m_get_points
  # POST /m_get_points.json
  def create
    @m_get_point = MGetPoint.new(params[:m_get_point])

    respond_to do |format|
      if @m_get_point.save
        format.html { redirect_to :controller => "m_get_points", :action => "index" }
        #format.html { redirect_to @m_get_point, notice: 'M get point was successfully created.' }
        format.json { render json: @m_get_point, status: :created, location: @m_get_point }
      else
        format.html { render action: "new" }
        format.json { render json: @m_get_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_get_points/1
  # PUT /m_get_points/1.json
  def update
    @m_get_point = MGetPoint.find(params[:id])

    respond_to do |format|
      if @m_get_point.update_attributes(params[:m_get_point])
        format.html { redirect_to :controller => "m_get_points", :action => "index" }
        #format.html { redirect_to @m_get_point, notice: 'M get point was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_get_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_get_points/1
  # DELETE /m_get_points/1.json
  def destroy
    @m_get_point = MGetPoint.find(params[:id])
    @m_get_point.destroy

    respond_to do |format|
      format.html { redirect_to m_get_points_url }
      format.json { head :ok }
    end
  end
end
