class DSaleReportsController < ApplicationController
  # GET /d_sale_reports
  # GET /d_sale_reports.json
  def index
    @head = DSale.new

    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
    params[:input_shop_kbn] = params[:head][:input_shop_kbn] if params[:input_shop_kbn] == nil and params[:head] != nil
      
    if params[:input_day].blank?
      @head[:input_day] = Time.now.localtime.strftime("%Y%m")
      @head[:input_shop_kbn] = nil
    else
      @head[:input_day] = params[:input_day].to_s.gsub("/", "")
      @head[:input_day] = @head[:input_day][0,6]
      @head[:input_shop_kbn] = params[:input_shop_kbn]
    end

    @start_year = DSaleReport.minimum("sale_date").to_s
    if @start_year.blank?
      @start_year = @head[:input_day].to_s[0,4].to_i
    else
      @start_year = @start_year.to_s[0,4].to_i
    end
    
    #対象データを取得
    @result_datas = result_datas_get(@head[:input_day], @head[:input_shop_kbn])
    
    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @d_sale }
    end
  end


  def update
    
    params[:data_rec_cnt].to_i.times {|i|
      #p params["data_sale_date_#{i}"]
      #p params["data_m_shop_id_#{i}"]
      #p params["data_id_#{i}"]
      p params["data_kakutei_flg_#{i}"]
      
      #data_sale_dateがNILは、売上がないのでスキップ
      unless params["data_sale_date_#{i}"].blank?
        #idがある場合はUPDATE、以外はINSERT
        if params["data_id_#{i}"].blank?
          d_sale_report = DSaleReport.new
          d_sale_report.sale_date = params["data_sale_date_#{i}"]
          d_sale_report.m_shop_id = params["data_m_shop_id_#{i}"]
        else
          d_sale_report = DSaleReport.find(params["data_id_#{i}"])
        end
        
        if params["data_kakutei_flg_#{i}"].blank?
          d_sale_report.kakutei_flg = 0
        else
          d_sale_report.kakutei_flg = params["data_kakutei_flg_#{i}"]
        end
        d_sale_report.confirm_id = current_user.id
        d_sale_report.confirm_date = Time.now
        d_sale_report.save
      end
    }

    respond_to do |format|
      input_day = params[:input_day]
      input_shop_kbn = params[:input_shop_kbn]
      format.html { redirect_to :controller => "d_sale_reports", :action => "index", :input_day => input_day, :input_shop_kbn => input_shop_kbn }
    end    
  end
  
  def show
    
    @d_sale_report = DSaleReport.find(params[:id])
    
    @approve_names = Array.new
    
    5.times {|i|
      @approve_names[i] = ""
      p @d_sale_report["approve_id#{i+1}"]
      unless @d_sale_report["approve_id#{i+1}"].blank?
        user = User.find(@d_sale_report["approve_id#{i+1}"])
        m_authoritie = MAuthority.find(user.m_authority_id)
        @approve_names[i] = m_authoritie.authority_name
      end
      
    }
    
    
    
    render :layout => 'modal'
      
  end
  
private
  #売上・現金管理表一覧の表示対象データを取得
  def result_datas_get(input_day, input_shop_kbn)
    select_sql = "select b.id m_shop_id, b.shop_cd, b.shop_name, b.shop_kbn "
    select_sql << " , a.d_sale_id, a.sale_date, a.exist_money, a.over_short "
    select_sql << " , e.id, e.kakutei_flg " 
    select_sql << " , d.code_name shop_kbn_name " 
    select_sql << " from m_shops b "
    select_sql << " left join ( "
    select_sql << "   select m_shop_id, min(id) d_sale_id, min(sale_date) sale_date, sum(exist_money) exist_money, sum(over_short) over_short "
    select_sql << " from d_sales where sale_date between '#{input_day.to_s.gsub("/", "")}01' and '#{input_day.to_s.gsub("/", "")}99' "
    select_sql << " group by m_shop_id) a on a.m_shop_id = b.id " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') d on b.shop_kbn = cast(d.code as integer) "
    select_sql << " Left join d_sale_reports e on e.m_shop_id = a.m_shop_id and e.sale_date = '#{input_day.to_s.gsub("/", "")}' "

    condition_sql = " where b.deleted_flg = 0 "
    if input_shop_kbn.blank?
    else
      condition_sql << " and b.shop_kbn = " + input_shop_kbn
    end    
         
    
    return DSaleReport.find_by_sql("#{select_sql} #{condition_sql} order by shop_cd")    
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
