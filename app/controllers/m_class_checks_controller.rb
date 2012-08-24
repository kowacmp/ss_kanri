class MClassChecksController < ApplicationController
  # GET /m_class_checks
  # GET /m_class_checks.json
  def index
    @m_class_checks = MClassCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_class_checks }
    end
  end

  # GET /m_class_checks/1
  # GET /m_class_checks/1.json
  def show
    @m_class_check = MClassCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_class_check }
    end
  end

  # GET /m_class_checks/new
  # GET /m_class_checks/new.json
  def new
    @m_class_check = MClassCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_class_check }
    end
  end

  # GET /m_class_checks/1/edit
  def edit
    @m_class_check = MClassCheck.find(params[:id])
  end

  # POST /m_class_checks
  # POST /m_class_checks.json
  def create
    @m_class_check = MClassCheck.new(params[:m_class_check])

    respond_to do |format|
      if @m_class_check.save
        format.html { redirect_to @m_class_check, notice: 'M class check was successfully created.' }
        format.json { render json: @m_class_check, status: :created, location: @m_class_check }
      else
        format.html { render action: "new" }
        format.json { render json: @m_class_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_class_checks/1
  # PUT /m_class_checks/1.json
  def update
    @m_class_check = MClassCheck.find(params[:id])

    respond_to do |format|
      if @m_class_check.update_attributes(params[:m_class_check])
        format.html { redirect_to @m_class_check, notice: 'M class check was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_class_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_class_checks/1
  # DELETE /m_class_checks/1.json
  def destroy
    @m_class_check = MClassCheck.find(params[:id])
    @m_class_check.destroy

    respond_to do |format|
      format.html { redirect_to m_class_checks_url }
      format.json { head :ok }
    end
  end
end
