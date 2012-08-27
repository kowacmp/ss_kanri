class MApprovalsController < ApplicationController
  # GET /m_approvals
  # GET /m_approvals.json
  def index
    @m_approvals = MApproval.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_approvals }
    end
  end

  # GET /m_approvals/1
  # GET /m_approvals/1.json
  def show
    @m_approval = MApproval.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_approval }
    end
  end

  # GET /m_approvals/new
  # GET /m_approvals/new.json
  def new
    @m_approval = MApproval.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_approval }
    end
  end

  # GET /m_approvals/1/edit
  def edit
    @m_approval = MApproval.find(params[:id])
  end

  # POST /m_approvals
  # POST /m_approvals.json
  def create
    @m_approval = MApproval.new(params[:m_approval])

    respond_to do |format|
      if @m_approval.save
        format.html { redirect_to @m_approval, notice: 'M approval was successfully created.' }
        format.json { render json: @m_approval, status: :created, location: @m_approval }
      else
        format.html { render action: "new" }
        format.json { render json: @m_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_approvals/1
  # PUT /m_approvals/1.json
  def update
    @m_approval = MApproval.find(params[:id])

    respond_to do |format|
      if @m_approval.update_attributes(params[:m_approval])
        format.html { redirect_to @m_approval, notice: 'M approval was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_approvals/1
  # DELETE /m_approvals/1.json
  def destroy
    @m_approval = MApproval.find(params[:id])
    @m_approval.destroy

    respond_to do |format|
      format.html { redirect_to m_approvals_url }
      format.json { head :ok }
    end
  end
end
