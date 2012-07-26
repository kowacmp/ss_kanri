class MInfoCostsController < ApplicationController
  # GET /m_info_costs
  # GET /m_info_costs.json
  def index
    #@m_info_costs = MInfoCost.all
    @m_info_costs = MInfoCost.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'users_id')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_info_costs }
    end
  end

  # GET /m_info_costs/1
  # GET /m_info_costs/1.json
  def show
    @m_info_cost = MInfoCost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_info_cost }
    end
  end

  # GET /m_info_costs/new
  # GET /m_info_costs/new.json
  def new
    @m_info_cost = MInfoCost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_info_cost }
    end
  end

  # GET /m_info_costs/1/edit
  def edit
    @m_info_cost = MInfoCost.find(params[:id])
  end

  # POST /m_info_costs
  # POST /m_info_costs.json
  def create
    @m_info_cost = MInfoCost.new(params[:m_info_cost])

    respond_to do |format|
      if @m_info_cost.save
        format.html { redirect_to @m_info_cost, notice: 'M info cost was successfully created.' }
        format.json { render json: @m_info_cost, status: :created, location: @m_info_cost }
      else
        format.html { render action: "new" }
        format.json { render json: @m_info_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_info_costs/1
  # PUT /m_info_costs/1.json
  def update
    @m_info_cost = MInfoCost.find(params[:id])

    respond_to do |format|
      if @m_info_cost.update_attributes(params[:m_info_cost])
        format.html { redirect_to @m_info_cost, notice: 'M info cost was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_info_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_info_costs/1
  # DELETE /m_info_costs/1.json
  def destroy
    @m_info_cost = MInfoCost.find(params[:id])
    #@m_info_cost.destroy
    if @m_info_cost.deleted_flg == 1
      @m_info_cost.update_attributes(:deleted_flg => 0)
    else
      @m_info_cost.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      format.html { redirect_to m_info_costs_url }
      format.json { head :ok }
    end
  end
  
  def delete_index
    if params[:check][:deleted_flg] == "true"
      @m_info_costs = MInfoCost.find(:all, :order => 'users_id')
    else
      @m_info_costs = MInfoCost.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'users_id')
    end
  end
  
end
