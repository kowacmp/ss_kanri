class DAuditCashboxesController < ApplicationController
  # GET /d_audit_chashboxes
  # GET /d_audit_chashboxes.json
  def index
    #@d_audit_chashboxes = DAuditChashbox.all
    #
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @d_audit_chashboxes }
    #end
    
    @d_audit_cashbox = DAuditCashbox.new()
    
  end

  def edit_kinko
    
    render :layout => "modal"
    
  end

  def update_kinko
    
    @d_audit_cashbox = params[:d_audit_cashbox]
    
  end

  # GET /d_audit_chashboxes/1
  # GET /d_audit_chashboxes/1.json
  def show

    render :layout => "modal"

  end

  # GET /d_audit_chashboxes/new
  # GET /d_audit_chashboxes/new.json
  def new
    @d_audit_chashbox = DAuditChashbox.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_audit_chashbox }
    end
  end

  # GET /d_audit_chashboxes/1/edit
  def edit
    @d_audit_chashbox = DAuditChashbox.find(params[:id])
  end

  # POST /d_audit_chashboxes
  # POST /d_audit_chashboxes.json
  def create
    @d_audit_chashbox = DAuditChashbox.new(params[:d_audit_chashbox])

    respond_to do |format|
      if @d_audit_chashbox.save
        format.html { redirect_to @d_audit_chashbox, notice: 'D audit chashbox was successfully created.' }
        format.json { render json: @d_audit_chashbox, status: :created, location: @d_audit_chashbox }
      else
        format.html { render action: "new" }
        format.json { render json: @d_audit_chashbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_audit_chashboxes/1
  # PUT /d_audit_chashboxes/1.json
  def update
    @d_audit_chashbox = DAuditChashbox.find(params[:id])

    respond_to do |format|
      if @d_audit_chashbox.update_attributes(params[:d_audit_chashbox])
        format.html { redirect_to @d_audit_chashbox, notice: 'D audit chashbox was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_audit_chashbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_audit_chashboxes/1
  # DELETE /d_audit_chashboxes/1.json
  def destroy
    @d_audit_chashbox = DAuditChashbox.find(params[:id])
    @d_audit_chashbox.destroy

    respond_to do |format|
      format.html { redirect_to d_audit_chashboxes_url }
      format.json { head :ok }
    end
  end
end
