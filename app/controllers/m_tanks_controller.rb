class MTanksController < ApplicationController
  # GET /m_tanks
  # GET /m_tanks.json
  def index
    @m_tanks = MTank.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_tanks }
    end
  end

  # GET /m_tanks/1
  # GET /m_tanks/1.json
  def show
    @m_tank = MTank.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_tank }
    end
  end

  # GET /m_tanks/new
  # GET /m_tanks/new.json
  def new
    @m_tank = MTank.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_tank }
    end
  end

  # GET /m_tanks/1/edit
  def edit
    @m_tank = MTank.find(params[:id])
  end

  # POST /m_tanks
  # POST /m_tanks.json
  def create
    @m_tank = MTank.new(params[:m_tank])

    respond_to do |format|
      if @m_tank.save
        format.html { redirect_to @m_tank, notice: 'M tank was successfully created.' }
        format.json { render json: @m_tank, status: :created, location: @m_tank }
      else
        format.html { render action: "new" }
        format.json { render json: @m_tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_tanks/1
  # PUT /m_tanks/1.json
  def update
    @m_tank = MTank.find(params[:id])

    respond_to do |format|
      if @m_tank.update_attributes(params[:m_tank])
        format.html { redirect_to @m_tank, notice: 'M tank was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_tank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_tanks/1
  # DELETE /m_tanks/1.json
  def destroy
    @m_tank = MTank.find(params[:id])
    @m_tank.destroy

    respond_to do |format|
      format.html { redirect_to m_tanks_url }
      format.json { head :ok }
    end
  end
end
