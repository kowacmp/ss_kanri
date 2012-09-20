class DDutiesController < ApplicationController
  
  include ApplicationHelper
  include DDutiesHelper
  
  # GET /d_duties
  # GET /d_duties.json
  def index
    @head = DSale.new

    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
    params[:input_shop_kbn] = params[:head][:input_shop_kbn] if params[:input_shop_kbn] == nil and params[:head] != nil
      
    if params[:input_day].blank?
      @head[:input_day] = Time.now.localtime.strftime("%Y%m")
    else
      @head[:input_day] = params[:input_day].to_s.gsub("/", "")
      @head[:input_day] = @head[:input_day][0,6]
    end

    if params[:m_shop_id] == nil
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:m_shop_id]
    end
    
    @start_year = DSaleReport.minimum("sale_date").to_s
    if @start_year.blank?
      @start_year = @head[:input_day].to_s[0,4].to_i
    else
      @start_year = @start_year.to_s[0,4].to_i
    end

    @d_duties = DDuty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_duties }
    end
  end

  #社員の出勤入力ポップアップ
  def syain_input
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    @syain_users = get_user_dutry(0, @m_shop_id, @input_day.to_s[0,4], @input_day.to_s[4,2], @input_day.to_s[6,2], @input_day.to_s[6,2])

    render :layout => 'modal'
  end
  
  #社員の出勤データ更新
  def syain_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    p params[:datas]
    params[:datas].each{|key, data|
      d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, data[:user_id], @input_day[6,2]])
      if d_dutie.blank?
        d_dutie = DDuty.new
        d_dutie.duty_nengetu = @input_day[0,6].to_s
        d_dutie.user_id = data[:user_id]
        d_dutie.day =  @input_day[6,2]
        d_dutie.created_user_id = current_user.id
      end
      
      d_dutie.m_shop_id = @m_shop_id
      d_dutie.day_work_time = data[:syukin] if data[:syukin]
      d_dutie.updated_user_id = current_user.id
      d_dutie.save
    }
    @d_duties = params[:datas]
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
  end

  #バイトの出勤入力ポップアップ
  def baito_input
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    @baito_users = get_user_dutry(1, @m_shop_id, @input_day.to_s[0,4], @input_day.to_s[4,2], @input_day.to_s[6,2], @input_day.to_s[6,2])

    render :layout => 'modal'
  end

  #バイトの出勤データ更新
  def baito_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    p params[:datas]
    params[:datas].each{|key, data|
      d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, data[:user_id], @input_day[6,2]])
      if d_dutie.blank?
        d_dutie = DDuty.new
        d_dutie.duty_nengetu = @input_day[0,6].to_s
        d_dutie.user_id = data[:user_id]
        d_dutie.day =  @input_day[6,2]
        d_dutie.created_user_id = current_user.id
      end
      
      d_dutie.m_shop_id = @m_shop_id
      d_dutie.day_work_time = data[:day_work_time] if data[:day_work_time]
      d_dutie.night_work_time = data[:night_work_time] if data[:night_work_time]      
      d_dutie.all_work_time = data[:day_work_time].to_f + data[:night_work_time].to_f  
      
      d_dutie.updated_user_id = current_user.id
      d_dutie.save
    }
    @d_duties = params[:datas]
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
  end
    
  # GET /d_duties/1
  # GET /d_duties/1.json
  def show
    @d_duty = DDuty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_duty }
    end
  end

  # GET /d_duties/new
  # GET /d_duties/new.json
  def new
    @d_duty = DDuty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_duty }
    end
  end

  # GET /d_duties/1/edit
  def edit
    @d_duty = DDuty.find(params[:id])
  end

  # POST /d_duties
  # POST /d_duties.json
  def create
    @d_duty = DDuty.new(params[:d_duty])

    respond_to do |format|
      if @d_duty.save
        format.html { redirect_to @d_duty, notice: 'D duty was successfully created.' }
        format.json { render json: @d_duty, status: :created, location: @d_duty }
      else
        format.html { render action: "new" }
        format.json { render json: @d_duty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_duties/1
  # PUT /d_duties/1.json
  def update
    @d_duty = DDuty.find(params[:id])

    respond_to do |format|
      if @d_duty.update_attributes(params[:d_duty])
        format.html { redirect_to @d_duty, notice: 'D duty was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_duty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_duties/1
  # DELETE /d_duties/1.json
  def destroy
    @d_duty = DDuty.find(params[:id])
    @d_duty.destroy

    respond_to do |format|
      format.html { redirect_to d_duties_url }
      format.json { head :ok }
    end
  end
  
  private
  
  #分割した日付を１つにする
  def input_day_set(day)
    
    
    if params["#{day}(1i)"].blank?
      return ""
    else
      if params["#{day}(2i)"].blank?
        return params["#{search_day}(1i)"] + "0101"
      else
        if params["#{day}(3i)"].blank?
          return params["#{day}(1i)"] + 
                                 sprintf("%02d",params["#{day}(2i)"].to_i) + "01"
        else
          return params["#{day}(1i)"] + 
                                 sprintf("%02d",params["#{day}(2i)"].to_i) + 
                                 sprintf("%02d",params["#{day}(3i)"].to_i)
        end
      end
    end    
  end
    
end
