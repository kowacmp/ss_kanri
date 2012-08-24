class DSaleItemsController < ApplicationController
  # GET /d_sale_items
  # GET /d_sale_items.json
  def index
    @d_sale_items = DSaleItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_sale_items }
    end
  end

  # GET /d_sale_items/1
  # GET /d_sale_items/1.json
  def show
    @d_sale_item = DSaleItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_sale_item }
    end
  end

  # GET /d_sale_items/new
  # GET /d_sale_items/new.json
  def new
    @d_sale_item = DSaleItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_sale_item }
    end
  end

  # GET /d_sale_items/1/edit
  def edit
    @d_sale_item = DSaleItem.find(params[:id])
  end

  # POST /d_sale_items
  # POST /d_sale_items.json
  def create
    @d_sale_item = DSaleItem.new(params[:d_sale_item])

    respond_to do |format|
      if @d_sale_item.save
        format.html { redirect_to @d_sale_item, notice: 'D sale item was successfully created.' }
        format.json { render json: @d_sale_item, status: :created, location: @d_sale_item }
      else
        format.html { render action: "new" }
        format.json { render json: @d_sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_sale_items/1
  # PUT /d_sale_items/1.json
  def update
    @d_sale_item = DSaleItem.find(params[:id])

    respond_to do |format|
      if @d_sale_item.update_attributes(params[:d_sale_item])
        format.html { redirect_to @d_sale_item, notice: 'D sale item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_sale_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_sale_items/1
  # DELETE /d_sale_items/1.json
  def destroy
    @d_sale_item = DSaleItem.find(params[:id])
    #@d_sale_item.destroy

    respond_to do |format|
      format.html { redirect_to d_sale_items_url }
      format.json { head :ok }
    end
  end
end
