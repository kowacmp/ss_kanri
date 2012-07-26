class MWashesController < ApplicationController
  # GET /m_washes
  # GET /m_washes.json
  def index
    #@m_washes = MWash.all
    @m_washes = MWash.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'wash_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_washes }
    end
  end

  # GET /m_washes/1
  # GET /m_washes/1.json
  def show
    @m_wash = MWash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_wash }
    end
  end

  # GET /m_washes/new
  # GET /m_washes/new.json
  def new
    @m_wash = MWash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_wash }
    end
  end

  # GET /m_washes/1/edit
  def edit
    @m_wash = MWash.find(params[:id])
  end

  # POST /m_washes
  # POST /m_washes.json
  def create
    @m_wash = MWash.new(params[:m_wash])

    respond_to do |format|
      if @m_wash.save
        format.html { redirect_to @m_wash, notice: 'M wash was successfully created.' }
        format.json { render json: @m_wash, status: :created, location: @m_wash }
      else
        format.html { render action: "new" }
        format.json { render json: @m_wash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_washes/1
  # PUT /m_washes/1.json
  def update
    @m_wash = MWash.find(params[:id])

    respond_to do |format|
      if @m_wash.update_attributes(params[:m_wash])
        format.html { redirect_to @m_wash, notice: 'M wash was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_wash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_washes/1
  # DELETE /m_washes/1.json
  def destroy
    @m_wash = MWash.find(params[:id])
    #@m_wash.destroy
    if @m_wash.deleted_flg == 1
      @m_wash.update_attributes(:deleted_flg => 0)
    else
      @m_wash.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      format.html { redirect_to m_washes_url }
      format.json { head :ok }
    end
  end
  
  def delete_index
    if params[:check][:deleted_flg] == "true"
      @m_washes = MWash.find(:all, :order => 'wash_cd')
    else
      @m_washes = MWash.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'wash_cd')
    end
  end
  
end
