# -*- coding:utf-8 -*-
class MEtcShopsController < ApplicationController
  # GET /m_etc_shops
  # GET /m_etc_shops.json
  def index
    @m_etc_shops = MEtcShop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_etc_shops }
    end
  end

  # GET /m_etc_shops/1
  # GET /m_etc_shops/1.json
  def show
    @m_etc_shop = MEtcShop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_etc_shop }
    end
  end

  # GET /m_etc_shops/new
  # GET /m_etc_shops/new.json
  def new
    @m_etc_shop = MEtcShop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_etc_shop }
    end
  end

  # GET /m_etc_shops/1/edit
  def edit
    @m_etc_shop = MEtcShop.find(params[:id])
  end

  # POST /m_etc_shops
  # POST /m_etc_shops.json
  def create
    @m_etc_shop = MEtcShop.new(params[:m_etc_shop])
    @m_etc_shop.m_shop_id = current_user.m_shop_id
    
    respond_to do |format|
      if @m_etc_shop.save
        format.html { redirect_to @m_etc_shop, notice: '他店舗マスタを作成しました' }
        format.json { render json: @m_etc_shop, status: :created, location: @m_etc_shop }
      else
        format.html { render action: "new" }
        format.json { render json: @m_etc_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_etc_shops/1
  # PUT /m_etc_shops/1.json
  def update
    @m_etc_shop = MEtcShop.find(params[:id])

    respond_to do |format|
      if @m_etc_shop.update_attributes(params[:m_etc_shop])
        format.html { redirect_to @m_etc_shop, notice: '他店舗マスタを更新しました' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_etc_shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_etc_shops/1
  # DELETE /m_etc_shops/1.json
  def destroy
    @m_etc_shop = MEtcShop.find(params[:id])
    @m_etc_shop.destroy

    respond_to do |format|
      format.html { redirect_to m_etc_shops_url }
      format.json { head :ok }
    end
  end
end
