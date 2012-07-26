# encoding: utf-8

class MOilsController < ApplicationController
  # GET /m_oils
  # GET /m_oils.json
  def index
    #@m_oils = MOil.all
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_oils }
    end
  end

  # GET /m_oils/1
  # GET /m_oils/1.json
  def show
    @m_oil = MOil.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_oil }
    end
  end

  # GET /m_oils/new
  # GET /m_oils/new.json
  def new
    @m_oil = MOil.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_oil }
    end
  end

  # GET /m_oils/1/edit
  def edit
    @m_oil = MOil.find(params[:id])
  end

  # POST /m_oils
  # POST /m_oils.json
  def create
    @m_oil = MOil.new(params[:m_oil])

    respond_to do |format|
      if @m_oil.save
        format.html { redirect_to @m_oil, notice: '登録されました。' }
        format.json { render json: @m_oil, status: :created, location: @m_oil }
      else
        format.html { render action: "new" }
        format.json { render json: @m_oil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_oils/1
  # PUT /m_oils/1.json
  def update
    @m_oil = MOil.find(params[:id])

    respond_to do |format|
      if @m_oil.update_attributes(params[:m_oil])
        format.html { redirect_to @m_oil, notice: '更新されました。' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_oil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_oils/1
  # DELETE /m_oils/1.json
  def destroy
    @m_oil = MOil.find(params[:id])
    #@m_oil.destroy
    if @m_oil.deleted_flg == 1
      @m_oil.update_attributes(:deleted_flg => 0)
    else
      @m_oil.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      format.html { redirect_to m_oils_url }
      format.json { head :ok }
    end
  end
  
  def delete_index
    if params[:check][:deleted_flg] == "true"
      @m_oils = MOil.find(:all, :order => 'oil_cd')
    else
      @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')
    end
  end
  
  
end
