class MCodesController < ApplicationController
  # GET /m_codes
  # GET /m_codes.json
  def index
    #@m_codes = MCode.all
    @m_codes = MCode.find(:all, :order => 'kbn,code')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_codes }
    end
  end

  # GET /m_codes/1
  # GET /m_codes/1.json
  def show
    @m_code = MCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_code }
    end
  end

  # GET /m_codes/new
  # GET /m_codes/new.json
  def new
    @m_code = MCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_code }
    end
  end

  # GET /m_codes/1/edit
  def edit
    @m_code = MCode.find(params[:id])
  end

  # POST /m_codes
  # POST /m_codes.json
  def create
    @m_code = MCode.new(params[:m_code])

    respond_to do |format|
      if @m_code.save
        format.html { redirect_to @m_code }
        format.json { render json: @m_code, status: :created, location: @m_code }
      else
        format.html { render action: "new" }
        format.json { render json: @m_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_codes/1
  # PUT /m_codes/1.json
  def update
    @m_code = MCode.find(params[:id])

    respond_to do |format|
      if @m_code.update_attributes(params[:m_code])
        format.html { redirect_to @m_code }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_codes/1
  # DELETE /m_codes/1.json
  def destroy
    @m_code = MCode.find(params[:id])
    @m_code.destroy

    respond_to do |format|
      format.html { redirect_to m_codes_url }
      format.json { head :ok }
    end
  end
end
