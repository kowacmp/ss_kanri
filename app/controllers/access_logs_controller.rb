class AccessLogsController < ApplicationController
  
    skip_before_filter :access_log
    
  # GET /access_logs
  # GET /access_logs.json
  def index
    
    @start_year = Time.now.localtime.strftime("%Y").to_i - 2
    
    params[:s_input_day] = input_day_set("s_input_day",true)
    params[:e_input_day] = input_day_set("e_input_day",false)
    
    @head = AccessLog.new
  
    @head[:s_input_day] = params[:s_input_day] == "" ? Time.now.localtime.strftime("%Y%m%d") : params[:s_input_day]
    @head[:e_input_day] = params[:e_input_day] == "" ? Time.now.localtime.strftime("%Y%m%d") : params[:e_input_day]
    @head[:user_id] = params[:head] == nil ? nil : params[:head][:user_id]
    @head[:shop_id] = params[:head] == nil ? nil : params[:head][:shop_id]
    @head[:sql_where] = params[:head] == nil ? nil : params[:head][:sql_where]

    
    select_sql = "select a.id, a.access_date, a.user_id, a.controller, a.action, a.remote_host, c.shop_name "
    select_sql << " from Access_logs a inner join users b on a.user_id = b.id inner join m_shops c on b.m_shop_id = c.id "
    
    where_sql = "a.access_date between '#{@head[:s_input_day].to_s[0,4]}/#{@head[:s_input_day].to_s[4,2]}/#{@head[:s_input_day].to_s[6,2]} 00:00:00' and '#{@head[:e_input_day].to_s[0,4]}/#{@head[:e_input_day].to_s[4,2]}/#{@head[:e_input_day].to_s[6,2]} 23:59:59'"
    where_sql << " and a.user_id=#{@head[:user_id]}" unless @head[:user_id].blank?
    where_sql << " and b.m_shop_id=#{@head[:shop_id]}" unless @head[:shop_id].blank?
    where_sql2 = " where #{@head[:sql_where]}" unless @head[:sql_where].blank?
    
    
    @access_logs = AccessLog.find_by_sql("select * from (#{select_sql} where #{where_sql}) as a #{where_sql2} order by access_date desc")

    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @d_sale }
    end
  end

  # GET /access_logs/1
  # GET /access_logs/1.json
  def show
    @access_log = AccessLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @access_log }
    end
  end

  # GET /access_logs/new
  # GET /access_logs/new.json
  def new
    @access_log = AccessLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @access_log }
    end
  end

  # GET /access_logs/1/edit
  def edit
    @access_log = AccessLog.find(params[:id])
  end

  # POST /access_logs
  # POST /access_logs.json
  def create
    @access_log = AccessLog.new(params[:access_log])

    respond_to do |format|
      if @access_log.save
        format.html { redirect_to @access_log, notice: 'Access log was successfully created.' }
        format.json { render json: @access_log, status: :created, location: @access_log }
      else
        format.html { render action: "new" }
        format.json { render json: @access_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /access_logs/1
  # PUT /access_logs/1.json
  def update
    @access_log = AccessLog.find(params[:id])

    respond_to do |format|
      if @access_log.update_attributes(params[:access_log])
        format.html { redirect_to @access_log, notice: 'Access log was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @access_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_logs/1
  # DELETE /access_logs/1.json
  def destroy
    @access_log = AccessLog.find(params[:id])
    @access_log.destroy

    respond_to do |format|
      format.html { redirect_to access_logs_url }
      format.json { head :ok }
    end
  end
  
  #パラメータをポップアップで表示
  def show_params
    @access_params = AccessLog.find(params[:id]).params
    render :layout => 'modal'
  end
  
private

  #分割した日付を１つにする
  def input_day_set(day,start_day)
    
    
    if params["#{day}(1i)"].blank?
      return ""
    else
      if params["#{day}(2i)"].blank?
        if start_day
          return params["#{day}(1i)"] + "0101"
        else
          return params["#{day}(1i)"] + "1231"
        end
      else
        if params["#{day}(3i)"].blank?
          if start_day
            return params["#{day}(1i)"] + 
                                   sprintf("%02d",params["#{day}(2i)"].to_i) + "01"
          else
             return params["#{day}(1i)"] + 
                                   sprintf("%02d",params["#{day}(2i)"].to_i) + Date.new(params["#{day}(1i)"].to_i, params["#{day}(2i)"].to_i, -1).day
          end
        else
          return params["#{day}(1i)"] + 
                                 sprintf("%02d",params["#{day}(2i)"].to_i) + 
                                 sprintf("%02d",params["#{day}(3i)"].to_i)
        end
      end
    end    
  end


end
