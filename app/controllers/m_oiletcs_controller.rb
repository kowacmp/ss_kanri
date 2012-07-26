# encoding: utf-8

class MOiletcsController < ApplicationController
  # GET /m_oiletcs
  # GET /m_oiletcs.json
  def index
    #@m_oiletcs = MOiletc.all
    @m_oiletcs = MOiletc.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oiletc_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_oiletcs }
    end
  end

  # GET /m_oiletcs/1
  # GET /m_oiletcs/1.json
  def show
    @m_oiletc = MOiletc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_oiletc }
    end
  end

  # GET /m_oiletcs/new
  # GET /m_oiletcs/new.json
  def new
    @m_oiletc = MOiletc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_oiletc }
    end
  end

  # GET /m_oiletcs/1/edit
  def edit
    @m_oiletc = MOiletc.find(params[:id])
  end

  # POST /m_oiletcs
  # POST /m_oiletcs.json
  def create
    @m_oiletc = MOiletc.new(params[:m_oiletc])

    respond_to do |format|
      if @m_oiletc.save
        format.html { redirect_to @m_oiletc, notice: 'M oiletc was successfully created.' }
        format.json { render json: @m_oiletc, status: :created, location: @m_oiletc }
      else
        format.html { render action: "new" }
        format.json { render json: @m_oiletc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_oiletcs/1
  # PUT /m_oiletcs/1.json
  def update
    @m_oiletc = MOiletc.find(params[:id])

    respond_to do |format|
      if @m_oiletc.update_attributes(params[:m_oiletc])
        format.html { redirect_to @m_oiletc, notice: 'M oiletc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_oiletc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_oiletcs/1
  # DELETE /m_oiletcs/1.json
  def destroy
    @m_oiletc = MOiletc.find(params[:id])
    #@m_oiletc.destroy
    if @m_oiletc.deleted_flg == 1
      @m_oiletc.update_attributes(:deleted_flg => 0)
    else
      @m_oiletc.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      format.html { redirect_to m_oiletcs_url }
      format.json { head :ok }
    end
  end
  
  def delete_index
    if params[:check][:deleted_flg] == "true"
      @m_oiletcs = MOiletc.find(:all, :order => 'oiletc_cd')
    else
      @m_oiletcs = MOiletc.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oiletc_cd')
    end
  end
  
end
