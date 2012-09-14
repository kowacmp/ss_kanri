class MAuditChecksController < ApplicationController
  # GET /m_audit_checks
  # GET /m_audit_checks.json
  def index
    #@m_audit_checks = MAuditCheck.all

    select_sql = "select a.*, b.item "
    select_sql << " from m_audit_checks a " 
    select_sql << " left join (select * from m_class_checks) b on a.m_class_check_id = b.id "
    
    condition_sql = ""

    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where a.deleted_flg = 0 "
        @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql} order by a.check_code")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where a.deleted_flg = 0 "
          @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql} order by a.check_code")
        else
          @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql} order by a.check_code")
        end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_audit_checks }
    end
  end

  # GET /m_audit_checks/1
  # GET /m_audit_checks/1.json
  def show
    #@m_audit_check = MAuditCheck.find(params[:id])
    
    select_sql = "select a.*, b.item "
    select_sql << " from m_audit_checks a " 
    select_sql << " left join (select * from m_class_checks) b on a.m_class_check_id = b.id "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_audit_check = @m_audit_checks[0]

    @check_del_flg = params[:input_check].to_i

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
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_audit_checks
  # POST /m_audit_checks.json
  def create
    @m_audit_check = MAuditCheck.new(params[:m_audit_check])

    respond_to do |format|
      if @m_audit_check.save
        #format.html { redirect_to @m_audit_check, notice: 'M audit check was successfully created.' }
        format.html { redirect_to :controller => "m_audit_checks", :action => "index" }
        #format.html { redirect_to @m_audit_check }
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
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_audit_checks", :action => "index",:input_check => input_check }
        #format.html { redirect_to :controller => "m_audit_checks", :action => "show",:id=>@m_audit_check.id,:input_check => input_check }
        #format.html { redirect_to @m_audit_check, notice: 'M audit check was successfully updated.' }
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
    #@m_audit_check.destroy

    if @m_audit_check.deleted_flg == 1
      @m_audit_check.update_attributes(:deleted_flg => 0)
    else
      @m_audit_check.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_audit_checks", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_audit_checks_url }
      format.json { head :ok }
    end
  end
  
  
  def search
    
    p "search-----------"
    
    select_sql = "select a.*, b.item "
    select_sql << " from m_audit_checks a " 
    select_sql << " left join (select * from m_class_checks) b on a.m_class_check_id = b.id "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql} order by a.check_code")
    else
      @check_del_flg = 0
      condition_sql = " where a.deleted_flg = 0 "
      @m_audit_checks = MAuditCheck.find_by_sql("#{select_sql} #{condition_sql} order by a.check_code")
    end
  end
  
end
