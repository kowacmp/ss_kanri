class DEventsController < ApplicationController
  # GET /d_events
  # GET /d_events.json
  def index
    sql = "select substr(start_day, 1, 4) || '/' || substr(start_day, 5, 2) || '/' || substr(start_day, 7, 2) as start_day, "
    sql << "      substr(end_day, 1, 4) || '/' || substr(end_day, 5, 2) || '/' || substr(end_day, 7, 2) as end_day,"
    sql << "      substr(action_day, 1, 4) || '/' || substr(action_day, 5, 2) || '/' || substr(action_day, 7, 2) as action_day,"
    sql << "      e.id, e.contents, m.display_name"
    sql << " from d_events e, menus m where e.menu_id = m.id  and e.created_user_id = #{current_user.id}"
    sql << " order by action_day desc"
    @d_events = DEvent.find_by_sql(sql)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_events }
    end
  end

  # GET /d_events/1
  # GET /d_events/1.json
  def show
    @d_event = DEvent.find(params[:id])

    @menu = Menu.find(@d_event.menu_id)

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
    @d_event.start_day = Time.parse(@d_event.start_day).strftime("%Y/%m/%d")
    @d_event.end_day = Time.parse(@d_event.end_day).strftime("%Y/%m/%d")
    @d_event.action_day = Time.parse(@d_event.action_day).strftime("%Y/%m/%d")
  end

  # POST /d_events
  # POST /d_events.json
  def create
    @d_event = DEvent.new(params[:d_event])

    @d_event.start_day = params[:d_event][:start_day].delete("/")
    @d_event.end_day = params[:d_event][:end_day].delete("/")
    @d_event.action_day = params[:d_event][:action_day].delete("/")
    @d_event.created_user_id = current_user.id
    
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
    params[:d_event][:start_day] = params[:d_event][:start_day].delete("/")
    params[:d_event][:end_day] = params[:d_event][:end_day].delete("/")
    params[:d_event][:action_day] = params[:d_event][:action_day].delete("/")

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
