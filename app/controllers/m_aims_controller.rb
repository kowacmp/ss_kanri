class MAimsController < ApplicationController
  # GET /m_aims
  # GET /m_aims.json
  def index
    @m_aims = MAim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_aims }
    end
  end

  # GET /m_aims/1
  # GET /m_aims/1.json
  def show
    @m_aim = MAim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_aim }
    end
  end

  # GET /m_aims/new
  # GET /m_aims/new.json
  def new
    @m_aim = MAim.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_aim }
    end
  end

  # GET /m_aims/1/edit
  def edit
    @m_aim = MAim.find(params[:id])
  end

  # POST /m_aims
  # POST /m_aims.json
  def create
    @m_aim = MAim.new(params[:m_aim])

    respond_to do |format|
      if @m_aim.save
        format.html { redirect_to @m_aim, notice: 'M aim was successfully created.' }
        format.json { render json: @m_aim, status: :created, location: @m_aim }
      else
        format.html { render action: "new" }
        format.json { render json: @m_aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_aims/1
  # PUT /m_aims/1.json
  def update
    @m_aim = MAim.find(params[:id])

    respond_to do |format|
      if @m_aim.update_attributes(params[:m_aim])
        format.html { redirect_to @m_aim, notice: 'M aim was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_aims/1
  # DELETE /m_aims/1.json
  def destroy
    @m_aim = MAim.find(params[:id])
    @m_aim.destroy

    respond_to do |format|
      format.html { redirect_to m_aims_url }
      format.json { head :ok }
    end
  end
end
