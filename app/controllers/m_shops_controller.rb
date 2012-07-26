class MShopsController < ApplicationController
  helper :application
  include ApplicationHelper
  
  # GET /m_shops
  # GET /m_shops.json
  def index
    #@m_shops = MShop.all
    @m_shops = MShop.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'shop_cd')
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_shops }
    end
  end

  # GET /m_shops/1
  # GET /m_shops/1.json
  def show
    @m_shop = MShop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_shop }
    end
  end

  # GET /m_shops/new
  # GET /m_shops/new.json
  def new
    @m_shop = MShop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_shop }
    end
  end

  # GET /m_shops/1/edit
  def edit
    @m_shop = MShop.find(params[:id])
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oil_cd')
  end

  # POST /m_shops
  # POST /m_shops.json
  def create
    @m_shop = MShop.new(params[:m_shop])

    respond_to do |format|
      if @m_shop.save
        format.html { redirect_to @m_shop, notice: 'M shop was successfully created.' }
        format.json { render json: @m_shop, status: :created, location: @m_shop }
      else
        format.html { render action: "new" }
        format.json { render json: @m_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_shops/1
  # PUT /m_shops/1.json
  def update
    @m_shop = MShop.find(params[:id])

    respond_to do |format|
      if @m_shop.update_attributes(params[:m_shop])
        format.html { redirect_to @m_shop, notice: 'M shop was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_shops/1
  # DELETE /m_shops/1.json
  def destroy
    @m_shop = MShop.find(params[:id])
    @m_shop.destroy

    respond_to do |format|
      format.html { redirect_to m_shops_url }
      format.json { head :ok }
    end
  end
  
  # モーダルを開く
  def modal_open
    render :partial => 'modal'
  end
  
end
