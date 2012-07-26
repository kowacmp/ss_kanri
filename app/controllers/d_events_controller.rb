class DEventsController < ApplicationController
  # GET /d_events
  # GET /d_events.json
  def index
    @d_events = DEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_events }
    end
  end

  # GET /d_events/1
  # GET /d_events/1.json
  def show
    @d_event = DEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_event }
    end
  end

  # GET /d_events/new
  # GET /d_events/new.json
  def new
    @d_event = DEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_event }
    end
  end

  # GET /d_events/1/edit
  def edit
    @d_event = DEvent.find(params[:id])
  end

  # POST /d_events
  # POST /d_events.json
  def create
    @d_event = DEvent.new(params[:d_event])

    respond_to do |format|
      if @d_event.save
        format.html { redirect_to @d_event, notice: 'D event was successfully created.' }
        format.json { render json: @d_event, status: :created, location: @d_event }
      else
        format.html { render action: "new" }
        format.json { render json: @d_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_events/1
  # PUT /d_events/1.json
  def update
    @d_event = DEvent.find(params[:id])

    respond_to do |format|
      if @d_event.update_attributes(params[:d_event])
        format.html { redirect_to @d_event, notice: 'D event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_events/1
  # DELETE /d_events/1.json
  def destroy
    @d_event = DEvent.find(params[:id])
    @d_event.destroy

    respond_to do |format|
      format.html { redirect_to d_events_url }
      format.json { head :ok }
    end
  end
end
