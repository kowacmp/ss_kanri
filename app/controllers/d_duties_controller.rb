class DDutiesController < ApplicationController
  
  include ApplicationHelper
  include DDutiesHelper
  
  # GET /d_duties
  # GET /d_duties.json
  def index
    
    @head = DDuty.new

    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
      
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
    
    #selectboxの選択年度を設定

    @start_year = Time.now.localtime.strftime("%Y").to_i - 1
   
    respond_to do |format|
      if params[:remote]
        format.html { render :partial => 'form'  }
      else
        format.html 
      end
    end
  end

  #社員の出勤入力ポップアップ
  def syain_input
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    @system_date = Time.now.localtime.strftime("%Y%m%d")
    
    @syain_users = get_user_dutry(0, @m_shop_id, @input_day.to_s[0,4], @input_day.to_s[4,2], @input_day.to_s[6,2], @input_day.to_s[6,2])

    render :layout => 'modal'
  end
  
  #社員の出勤データ更新
  def syain_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    params[:datas].each{|key, data|
      d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, data[:user_id], @input_day[6,2]])
      
      #データ更新
      d_duites_syain_edit(data, d_dutie, @input_day, data[:user_id], @input_day[6,2])

    }
    @d_duties = params[:datas]
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
  end

  #社員の出勤データ入力（個人毎）
  def syain_row_input
    
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    @system_date = Time.now.localtime.strftime("%Y%m%d")
    
    @user = User.find(params[:user_id])

    render :layout => 'modal'
    
  end

  #社員の出勤データ更新（個人毎）
  def syain_row_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    @user_id = params[:user_id]
    
    unless params[:datas].blank?
      params[:datas].each{|day, data|
        d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, @user_id, day])
  
        #データ更新
        d_duites_syain_edit(data, d_dutie, @input_day, @user_id, day)
  
      }
      @d_duties = params[:datas]
    end
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
  end
    
  #バイトの出勤入力ポップアップ
  def baito_input
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    @baito_users = get_user_dutry(1, @m_shop_id, @input_day.to_s[0,4], @input_day.to_s[4,2], @input_day.to_s[6,2], @input_day.to_s[6,2])

    @m_cost_name = MCostName.find(:first, :conditions=>["m_shop_id = ? and deleted_flg = 0", @m_shop_id])
    @m_cost_name = MCostName.new if @m_cost_name.blank?
    
    render :layout => 'modal'
  end

  #バイトの出勤データ更新
  def baito_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    
    params[:datas].each{|key, data|
      d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, data[:user_id], @input_day[6,2]])
      
      #データ更新
      d_duites_baito_edit(data, d_dutie, @input_day, data[:user_id], @input_day[6,2])
      
    }
    
    @d_duties = params[:datas]
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
  end
  
  #バイトの出勤入力ポップアップ(個人毎)
  def baito_row_input
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    @m_cost_name = MCostName.find(:first, :conditions=>["m_shop_id = ? and deleted_flg = 0", @m_shop_id])
    @m_cost_name = MCostName.new if @m_cost_name.blank?
        
    @user = User.find(params[:user_id])

    render :layout => 'modal'

  end
  
  #バイトの出勤データ更新(個人毎)
  def baito_row_input_add
    @input_day = params[:input_day]
    @m_shop_id = params[:m_shop_id]
    @user_id = params[:user_id]
    
    unless params[:datas].blank?
      params[:datas].each{|day, data|
        d_dutie = DDuty.find(:first,:conditions=>["duty_nengetu = ? and user_id = ? and day = ?", @input_day[0,6].to_s, @user_id, day])
  
        #データ更新
        d_duites_baito_edit(data, d_dutie, @input_day, @user_id, day)
        
      }
      @d_duties = params[:datas]
    end
    
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
  
  #入力済み登録
  def input_check
    
    if params[:input_flg] == "checked" 
      params[:input_flg] = 1
    else
      params[:input_flg] = 0
    end   

    update_sql = "update d_duties "
    update_sql << " set input_flg = #{params[:input_flg]} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where duty_nengetu = '#{params[:input_day].to_s.gsub("/", "")}' "
    update_sql << " and day = #{params[:day]} "
    update_sql << " and m_shop_id = #{params[:m_shop_id]}"
    ActiveRecord::Base::connection.execute(update_sql)
    
    respond_to do |format|
      format.js { render :layout => false }
    end    
        
  end
  
  #確定済み登録
  def kakutei_check
    if params[:kakutei_flg] == "checked" 
      params[:kakutei_flg] = 1
    else
      params[:kakutei_flg] = 0
    end   

    update_sql = "update d_duties "
    update_sql << " set kakutei_flg = #{params[:kakutei_flg]} "
    update_sql << " , updated_user_id = #{current_user.id} "
    update_sql << " , updated_at = '#{Time.now.to_datetime}' "
    update_sql << " where duty_nengetu = '#{params[:input_day].to_s.gsub("/", "")}' "
    update_sql << " and day = #{params[:day]} "
    update_sql << " and m_shop_id = #{params[:m_shop_id]}"
    ActiveRecord::Base::connection.execute(update_sql)
    
    respond_to do |format|
      format.js { render :layout => false }
    end      
  end
  
  private
  
  #バイト用データ更新
  def d_duites_baito_edit(data, d_dutie, input_day, user_id, day)
    
    if d_dutie.blank?
      d_dutie = DDuty.new
      d_dutie.duty_nengetu = input_day[0,6].to_s
      d_dutie.user_id = user_id
      d_dutie.day =  day
      d_dutie.created_user_id = current_user.id
    end
    
    #時間に変更がない場合は更新しない
    #時間の変こぅに関係なく登録する
#    unless d_dutie.day_work_time.to_f == data[:day_work_time].to_f and
#       d_dutie.day_over_time.to_f == data[:day_over_time].to_f and
#       d_dutie.night_work_time.to_f == data[:night_work_time].to_f and
#       d_dutie.night_over_time.to_f == data[:night_over_time].to_f

      d_dutie.m_shop_id = @m_shop_id
      d_dutie.day_work_time = data[:day_work_time] if data[:day_work_time]
      d_dutie.day_over_time = data[:day_over_time] if data[:day_over_time]
      d_dutie.night_work_time = data[:night_work_time] if data[:night_work_time]    
      d_dutie.night_over_time = data[:night_over_time] if data[:night_over_time]    
      d_dutie.all_work_time = data[:all_work_time] if data[:all_work_time]   
      d_dutie.get_money1 = data[:get_money1] if data[:get_money1] 
      d_dutie.get_money2 = data[:get_money2] if data[:get_money2] 
      d_dutie.get_money3 = data[:get_money3] if data[:get_money3] 
      d_dutie.get_money4 = data[:get_money4] if data[:get_money4] 
      
      #金額計算
      m_info_cost = MInfoCost.find(:first, :conditions=>["user_id=?", user_id])
      
      unless m_info_cost.blank?
        day_work_money = (m_info_cost.general_price.to_i * d_dutie.day_work_time.to_f).ceil #日勤金額（m_info_costs.通常単価×日勤時間）　切り上げ
        day_over_money = (m_info_cost.general_overtime.to_i * d_dutie.day_over_time.to_f).ceil #残業金額（m_info_costs.通常残業×残業時間）　切り上げ
        night_work_money = (m_info_cost.night_price.to_i * d_dutie.night_work_time.to_f).ceil #深夜金額（m_info_costs.深夜単価×深夜時間）　切り上げ
        night_over_money = (m_info_cost.night_overtime.to_i * d_dutie.night_over_time.to_f).ceil #深夜残業（m_info_costs.深夜残業×深夜残業時間）　切り上げ
        #勤務金額合計
        d_dutie.work_money = day_work_money + day_over_money + night_work_money + night_over_money
        #時間単価金額
        time_price = 0
        time_price += (m_info_cost.time_price1.to_i * d_dutie.all_work_time.to_f).ceil 
        time_price += (m_info_cost.time_price2.to_i * d_dutie.all_work_time.to_f).ceil 
        time_price += (m_info_cost.time_price3.to_i * d_dutie.all_work_time.to_f).ceil 
        time_price += (m_info_cost.time_price4.to_i * d_dutie.all_work_time.to_f).ceil 
        time_price += (m_info_cost.time_price5.to_i * d_dutie.all_work_time.to_f).ceil 
        time_price += (m_info_cost.time_price6.to_i * d_dutie.all_work_time.to_f).ceil 
        #日数単価金額
        day_price = 0
        day_price += m_info_cost.day_price1.to_i
        day_price += m_info_cost.day_price1.to_i
      end
      
      #人件費合計
      d_dutie.all_money = d_dutie.work_money.to_i + d_dutie.get_money1.to_i + d_dutie.get_money2.to_i + d_dutie.get_money3.to_i + d_dutie.get_money4.to_i + time_price.to_i + day_price.to_i
      
      d_dutie.updated_user_id = current_user.id
      d_dutie.save

#    end
    
  end
  
  #社員用データ更新
  def d_duites_syain_edit(data, d_dutie, input_day, user_id, day)

    if d_dutie.blank?
      d_dutie = DDuty.new
      d_dutie.duty_nengetu = @input_day[0,6].to_s
      d_dutie.user_id = @user_id
      d_dutie.day =  day
      d_dutie.created_user_id = current_user.id
    end
    
    d_dutie.m_shop_id = @m_shop_id
    unless d_dutie.day_work_time.to_i == data[:syukin].to_i
      d_dutie.day_work_time = data[:syukin] if data[:syukin]
      d_dutie.all_work_time = d_dutie.day_work_time  
      
      #金額計算(出勤に関係なく（金額/月）の日数をセットする)
      m_info_cost = MInfoCost.find(:first, :conditions=>["user_id=?", d_dutie.user_id])
      if m_info_cost.blank?
        d_dutie.all_money = 0
      else
        nisu = (Date.new(@input_day.to_s[0,4].to_i, @input_day.to_s[4,2].to_i, -1)).strftime("%d").to_i
        #truncate切り捨て
        d_dutie.all_money = ((m_info_cost.general_price.to_i + m_info_cost.time_price1.to_i + m_info_cost.time_price2.to_i + m_info_cost.time_price3.to_i + m_info_cost.time_price4.to_i + m_info_cost.time_price5.to_i + m_info_cost.time_price6.to_i) / nisu).truncate
      end
      
      d_dutie.updated_user_id = current_user.id
      d_dutie.save
    end
         
  end
  
  
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
