class MAuditChecksController < ApplicationController
  # GET /m_audit_checks
  # GET /m_audit_checks.json
  def index
    @m_audit_checks = MAuditCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_audit_checks }
    end
  end

  # GET /m_audit_checks/1
  # GET /m_audit_checks/1.json
  def show
    @m_audit_check = MAuditCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_audit_check }
    end
  end

  # GET /m_audit_checks/new
  # GET /m_audit_checks/new.json
  def new
    @m_audit_check = MAuditCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_audit_check }
    end
  end

  # GET /m_audit_checks/1/edit
  def edit
    @m_audit_check = MAuditCheck.find(params[:id])
  end

  # POST /m_audit_checks
  # POST /m_audit_checks.json
  def create
    @m_audit_check = MAuditCheck.new(params[:m_audit_check])

    respond_to do |format|
      if @m_audit_check.save
        format.html { redirect_to @m_audit_check, notice: 'M audit check was successfully created.' }
        format.json { render json: @m_audit_check, status: :created, location: @m_audit_check }
      else
        format.html { render action: "new" }
        format.json { render json: @m_audit_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_audit_checks/1
  # PUT /m_audit_checks/1.json
  def update
    @m_audit_check = MAuditCheck.find(params[:id])

    respond_to do |format|
      if @m_audit_check.update_attributes(params[:m_audit_check])
        format.html { redirect_to @m_audit_check, notice: 'M audit check was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_audit_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_audit_checks/1
  # DELETE /m_audit_checks/1.json
  def destroy
    @m_audit_check = MAuditCheck.find(params[:id])
    @m_audit_check.destroy

    respond_to do |format|
      format.html { redirect_to m_audit_checks_url }
      format.json { head :ok }
    end
  end
end
