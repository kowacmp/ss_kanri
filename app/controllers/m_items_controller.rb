class MItemsController < ApplicationController
  # GET /m_items
  # GET /m_items.json
  def index
    @m_items = MItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_items }
    end
  end

  # GET /m_items/1
  # GET /m_items/1.json
  def show
    @m_item = MItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_item }
    end
  end

  # GET /m_items/new
  # GET /m_items/new.json
  def new
    @m_item = MItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_item }
    end
  end

  # GET /m_items/1/edit
  def edit
    @m_item = MItem.find(params[:id])
  end

  # POST /m_items
  # POST /m_items.json
  def create
    @m_item = MItem.new(params[:m_item])

    respond_to do |format|
      if @m_item.save
        format.html { redirect_to @m_item, notice: 'M item was successfully created.' }
        format.json { render json: @m_item, status: :created, location: @m_item }
      else
        format.html { render action: "new" }
        format.json { render json: @m_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_items/1
  # PUT /m_items/1.json
  def update
    @m_item = MItem.find(params[:id])

    respond_to do |format|
      if @m_item.update_attributes(params[:m_item])
        format.html { redirect_to @m_item, notice: 'M item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_items/1
  # DELETE /m_items/1.json
  def destroy
    @m_item = MItem.find(params[:id])
    @m_item.destroy

    respond_to do |format|
      format.html { redirect_to m_items_url }
      format.json { head :ok }
    end
  end
end
