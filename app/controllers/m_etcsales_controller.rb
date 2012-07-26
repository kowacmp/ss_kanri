class MEtcsalesController < ApplicationController
  # GET /m_etcsales
  # GET /m_etcsales.json
  def index
    #@m_etcsales = MEtcsale.all
    @m_etcsales = MEtcsale.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'etc_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_etcsales }
    end
  end

  # GET /m_etcsales/1
  # GET /m_etcsales/1.json
  def show
    @m_etcsale = MEtcsale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_etcsale }
    end
  end

  # GET /m_etcsales/new
  # GET /m_etcsales/new.json
  def new
    @m_etcsale = MEtcsale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_etcsale }
    end
  end

  # GET /m_etcsales/1/edit
  def edit
    @m_etcsale = MEtcsale.find(params[:id])
  end

  # POST /m_etcsales
  # POST /m_etcsales.json
  def create
    @m_etcsale = MEtcsale.new(params[:m_etcsale])

    respond_to do |format|
      if @m_etcsale.save
        format.html { redirect_to @m_etcsale, notice: 'M etcsale was successfully created.' }
        format.json { render json: @m_etcsale, status: :created, location: @m_etcsale }
      else
        format.html { render action: "new" }
        format.json { render json: @m_etcsale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_etcsales/1
  # PUT /m_etcsales/1.json
  def update
    @m_etcsale = MEtcsale.find(params[:id])

    respond_to do |format|
      if @m_etcsale.update_attributes(params[:m_etcsale])
        format.html { redirect_to @m_etcsale, notice: 'M etcsale was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_etcsale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_etcsales/1
  # DELETE /m_etcsales/1.json
  def destroy
    @m_etcsale = MEtcsale.find(params[:id])
    #@m_etcsale.destroy
    if @m_etcsale.deleted_flg == 1
      @m_etcsale.update_attributes(:deleted_flg => 0)
    else
      @m_etcsale.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      format.html { redirect_to m_etcsales_url }
      format.json { head :ok }
    end
  end
  
  def delete_index
    if params[:check][:deleted_flg] == "true"
      @m_etcsales = MEtcsale.find(:all, :order => 'etc_cd')
    else
      @m_etcsales = MEtcsale.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'etc_cd')
    end
  end
  
end
