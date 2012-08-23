class MEtcsController < ApplicationController
  # GET /m_etcs
  # GET /m_etcs.json
  def index
    #@m_etcs = MEtc.all
    p "index----"
    if params[:input_check] == nil
        @check_del_flg = 0
        @m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          @m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
        else
          @m_etcs = MEtc.find(:all, :order => 'etc_cd')
        end
    end
    
    #@m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_etcs }
    end
  end

  # GET /m_etcs/1
  # GET /m_etcs/1.json
  def show
    @m_etc = MEtc.find(params[:id])

    @check_del_flg = params[:input_check].to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_etc }
    end
  end

  # GET /m_etcs/new
  # GET /m_etcs/new.json
  def new
    @m_etc = MEtc.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_etc }
    end
  end

  # GET /m_etcs/1/edit
  def edit
    p "edit----"
    
    @m_etc = MEtc.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
    
  end

  # POST /m_etcs
  # POST /m_etcs.json
  def create
    
    p "update----"
    p params[:input_check]
    
    @m_etc = MEtc.new(params[:m_etc])

    respond_to do |format|
      if @m_etc.save
        format.html { redirect_to @m_etc, notice: 'M etc was successfully created.' }
        format.json { render json: @m_etc, status: :created, location: @m_etc }
      else
        format.html { render action: "new" }
        format.json { render json: @m_etc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_etcs/1
  # PUT /m_etcs/1.json
  def update
    p "update----"
    p params[:input_check]
    
    @m_etc = MEtc.find(params[:id])

    respond_to do |format|
      if @m_etc.update_attributes(params[:m_etc])
        format.html { redirect_to @m_etc, notice: 'M etc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_etc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_etcs/1
  # DELETE /m_etcs/1.json
  def destroy
    
    p "delete-----------------"
    
    @m_etc = MEtc.find(params[:id])
    #@m_etc.destroy
    if @m_etc.deleted_flg == 1
      @m_etc.update_attributes(:deleted_flg => 0)
    else
      @m_etc.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check]
      format.html { redirect_to :controller => "m_etcs", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_etcs_url }
      format.json { head :ok }
    end
  end
  
  def search
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_etcs = MEtc.find(:all, :order => 'etc_cd')
    else
      @check_del_flg = 0
      @m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
    end
  end
  
end
