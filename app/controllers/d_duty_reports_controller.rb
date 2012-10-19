class DDutyReportsController < ApplicationController
  
  helper :d_duties
  
  def index
  end

  def show
    @head = DDuty.new

    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
      
    if params[:input_day].blank?
      @head[:input_day] = Time.now.localtime.strftime("%Y%m")
    else
      @head[:input_day] = params[:input_day].to_s.gsub("/", "")
      @head[:input_day] = @head[:input_day][0,6]
    end

    if params[:head_input_m_shop_id] == nil
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:head_input_m_shop_id]
    end
    
    if params[:head_output_kbn] == nil
      @head_output_kbn = 1 #金額を表示
    else
      @head_output_kbn = params[:head_output_kbn].to_i
    end
    
    #selectboxの選択年度を設定

    @start_year = Time.now.localtime.strftime("%Y").to_i - 1
   
    @m_shop = MShop.find(@m_shop_id)
   
    respond_to do |format|
      if params[:remote]
        format.html { render :partial => 'form'  }
      else
        format.html 
      end
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
