class MShopGroupsController < ApplicationController
  # GET /m_shop_groups
  # GET /m_shop_groups.json
  def index
    @m_shop_groups = MShopGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_shop_groups }
    end
  end

  # GET /m_shop_groups/1
  # GET /m_shop_groups/1.json
  def show
    @m_shop_group = MShopGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_shop_group }
    end
  end

  # GET /m_shop_groups/new
  # GET /m_shop_groups/new.json
  def new
    @m_shop_group = MShopGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_shop_group }
    end
  end

  # GET /m_shop_groups/1/edit
  def edit
    @m_shop_group = MShopGroup.find(params[:id])
  end

  # POST /m_shop_groups
  # POST /m_shop_groups.json
  def create
    @m_shop_group = MShopGroup.new(params[:m_shop_group])

    respond_to do |format|
      if @m_shop_group.save
        format.html { redirect_to @m_shop_group, notice: 'M shop group was successfully created.' }
        format.json { render json: @m_shop_group, status: :created, location: @m_shop_group }
      else
        format.html { render action: "new" }
        format.json { render json: @m_shop_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_shop_groups/1
  # PUT /m_shop_groups/1.json
  def update
    @m_shop_group = MShopGroup.find(params[:id])

    respond_to do |format|
      if @m_shop_group.update_attributes(params[:m_shop_group])
        format.html { redirect_to @m_shop_group, notice: 'M shop group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_shop_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_shop_groups/1
  # DELETE /m_shop_groups/1.json
  def destroy
    @m_shop_group = MShopGroup.find(params[:id])
    @m_shop_group.destroy

    respond_to do |format|
      format.html { redirect_to m_shop_groups_url }
      format.json { head :ok }
    end
  end
end
