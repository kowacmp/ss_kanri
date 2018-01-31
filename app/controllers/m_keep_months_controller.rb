class MKeepMonthsController < ApplicationController
  # GET /m_keep_months
  # GET /m_keep_months.json
  def index
    @m_keep_months = MKeepMonth.find(:all, :order => "display_order")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_keep_months }
    end
  end

  # GET /m_keep_months/1
  # GET /m_keep_months/1.json
  def show
    @m_keep_month = MKeepMonth.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_keep_month }
    end
  end

  # GET /m_keep_months/new
  # GET /m_keep_months/new.json
  def new
    @m_keep_month = MKeepMonth.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_keep_month }
    end
  end

  # GET /m_keep_months/1/edit
  def edit
    @m_keep_month = MKeepMonth.find(params[:id])
  end

  # POST /m_keep_months
  # POST /m_keep_months.json
  def create
    @m_keep_month = MKeepMonth.new(params[:m_keep_month])

    respond_to do |format|
      if @m_keep_month.save
        format.html { redirect_to @m_keep_month, notice: 'M keep month was successfully created.' }
        format.json { render json: @m_keep_month, status: :created, location: @m_keep_month }
      else
        format.html { render action: "new" }
        format.json { render json: @m_keep_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_keep_months/1
  # PUT /m_keep_months/1.json
  def update
    @m_keep_month = MKeepMonth.find(params[:id])

    respond_to do |format|
      if @m_keep_month.update_attributes(params[:m_keep_month])
        format.html { redirect_to :controller => "m_keep_months", :action => "index" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_keep_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_keep_months/1
  # DELETE /m_keep_months/1.json
  def destroy
    @m_keep_month = MKeepMonth.find(params[:id])
    @m_keep_month.destroy

    respond_to do |format|
      format.html { redirect_to m_keep_months_url }
      format.json { head :ok }
    end
  end
end
