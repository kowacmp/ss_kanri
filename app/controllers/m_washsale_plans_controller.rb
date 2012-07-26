class MWashsalePlansController < ApplicationController
  # GET /m_washsale_plans
  # GET /m_washsale_plans.json
  def index
    @m_washsale_plans = MWashsalePlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_washsale_plans }
    end
  end

  # GET /m_washsale_plans/1
  # GET /m_washsale_plans/1.json
  def show
    @m_washsale_plan = MWashsalePlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_washsale_plan }
    end
  end

  # GET /m_washsale_plans/new
  # GET /m_washsale_plans/new.json
  def new
    @m_washsale_plan = MWashsalePlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_washsale_plan }
    end
  end

  # GET /m_washsale_plans/1/edit
  def edit
    @m_washsale_plan = MWashsalePlan.find(params[:id])
  end

  # POST /m_washsale_plans
  # POST /m_washsale_plans.json
  def create
    @m_washsale_plan = MWashsalePlan.new(params[:m_washsale_plan])

    respond_to do |format|
      if @m_washsale_plan.save
        format.html { redirect_to @m_washsale_plan, notice: 'M washsale plan was successfully created.' }
        format.json { render json: @m_washsale_plan, status: :created, location: @m_washsale_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @m_washsale_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_washsale_plans/1
  # PUT /m_washsale_plans/1.json
  def update
    @m_washsale_plan = MWashsalePlan.find(params[:id])

    respond_to do |format|
      if @m_washsale_plan.update_attributes(params[:m_washsale_plan])
        format.html { redirect_to @m_washsale_plan, notice: 'M washsale plan was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_washsale_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_washsale_plans/1
  # DELETE /m_washsale_plans/1.json
  def destroy
    @m_washsale_plan = MWashsalePlan.find(params[:id])
    @m_washsale_plan.destroy

    respond_to do |format|
      format.html { redirect_to m_washsale_plans_url }
      format.json { head :ok }
    end
  end
end
