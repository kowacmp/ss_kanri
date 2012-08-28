class MClassChecksController < ApplicationController
  # GET /m_class_checks
  # GET /m_class_checks.json
  def index
    @m_class_checks = MClassCheck.all

    if params[:input_check] == nil
        @check_del_flg = 0
        @m_class_checks = MClassCheck.find(:all,:conditions=>"deleted_flg = 0",:order=>"class_code")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          @m_class_checks = MClassCheck.find(:all,:conditions=>"deleted_flg = 0",:order=>"class_code")
        else
          @m_class_checks = MClassCheck.find(:all,:order=>"class_code")
        end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_class_checks }
    end
  end

  # GET /m_class_checks/1
  # GET /m_class_checks/1.json
  def show
    @m_class_check = MClassCheck.find(params[:id])

    @check_del_flg = params[:input_check].to_i

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
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_class_checks
  # POST /m_class_checks.json
  def create
    @m_class_check = MClassCheck.new(params[:m_class_check])

    respond_to do |format|
      if @m_class_check.save
        #format.html { redirect_to @m_class_check, notice: 'M class check was successfully created.' }
        format.html { redirect_to @m_class_check }
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
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_class_checks", :action => "show",:id=>@m_class_check.id,:input_check => input_check }
        #format.html { redirect_to @m_class_check, notice: 'M class check was successfully updated.' }
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
    #@m_class_check.destroy
    
    if @m_class_check.deleted_flg == 1
      @m_class_check.update_attributes(:deleted_flg => 0)
    else
      @m_class_check.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_class_checks", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_class_checks_url }
      format.json { head :ok }
    end
  end
  
  
  def search
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_class_checks = MClassCheck.find(:all,:order=>"class_code")
    else
      @check_del_flg = 0
      @m_class_checks = MClassCheck.find(:all,:conditions=>"deleted_flg = 0",:order=>"class_code")
    end
  end
  
end
