class MAuthoritiesController < ApplicationController
  # GET /m_authorities
  # GET /m_authorities.json
  def index
    @m_authorities = MAuthority.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_authorities }
    end
  end

  # GET /m_authorities/1
  # GET /m_authorities/1.json
  def show
    @m_authority = MAuthority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_authority }
    end
  end

  # GET /m_authorities/new
  # GET /m_authorities/new.json
  def new
    @m_authority = MAuthority.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_authority }
    end
  end

  # GET /m_authorities/1/edit
  def edit
    @m_authority = MAuthority.find(params[:id])
  end

  # POST /m_authorities
  # POST /m_authorities.json
  def create
    @m_authority = MAuthority.new(params[:m_authority])

    respond_to do |format|
      if @m_authority.save
        format.html { redirect_to @m_authority, notice: 'M authority was successfully created.' }
        format.json { render json: @m_authority, status: :created, location: @m_authority }
      else
        format.html { render action: "new" }
        format.json { render json: @m_authority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_authorities/1
  # PUT /m_authorities/1.json
  def update
    @m_authority = MAuthority.find(params[:id])

    respond_to do |format|
      if @m_authority.update_attributes(params[:m_authority])
        format.html { redirect_to @m_authority, notice: 'M authority was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_authority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_authorities/1
  # DELETE /m_authorities/1.json
  def destroy
    @m_authority = MAuthority.find(params[:id])
    @m_authority.destroy

    respond_to do |format|
      format.html { redirect_to m_authorities_url }
      format.json { head :ok }
    end
  end
end
