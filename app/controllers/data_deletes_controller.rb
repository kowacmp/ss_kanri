# -*- coding:utf-8 -*-
class DataDeletesController < ApplicationController
  include DataDeletesHelper
  
   def index

    sql_sel = "SELECT id, display_order, display_name, keep_month, "
    sql_sel << " '' AS del_ymd ,'' AS input_ymd "
    sql_sel << " FROM m_keep_months "
    sql_sel << " ORDER BY display_order"

    @m_keep_months = MKeepMonth.find_by_sql(sql_sel)
    @m_keep_months.each do |m_keep|
      m_keep.del_ymd = get_del_date(Date.today,m_keep.keep_month)

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_keep_months }
    end
  end

  def edit

    sql_sel = "SELECT id, display_order, display_name, keep_month "
    sql_sel << " FROM m_keep_months "
    sql_sel << " where id = " + params[:id]

    @m_keep_months = MKeepMonth.find_by_sql(sql_sel)
    
    @m_keep_months = @m_keep_months[0]
    
    @m_keep_months[:del_ymd] = get_del_date(Date.today,@m_keep_months.keep_month)
    
    @m_keep_months[:input_ymd] = get_del_date(Date.today,@m_keep_months.keep_month)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_keep_months }
    end
  end

  def delete

    sql_sel = "SELECT id, display_order, display_name, keep_month "
    sql_sel << " FROM m_keep_months "
    sql_sel << " where display_order = " + params[:m_keep_months][:display_order]

    @m_keep_months = MKeepMonth.find_by_sql(sql_sel)
    
    @m_keep_months = @m_keep_months[0]
    
    @m_keep_months[:del_ymd] = get_del_date(Date.today,@m_keep_months.keep_month)
 
    if params[:m_keep_months][:input_ymd] > @m_keep_months[:del_ymd]
      respond_to do |format|
        format.js { render :text => "alert('削除可能日より後の日付です。');" }
        end 
        return 
     end

     if params[:m_keep_months][:display_order].to_i == 1
        #実績データ存在チェック
        @d_result = DResult.count(:all, :conditions => ["result_date < ? ",params[:m_keep_months][:input_ymd].delete("/")])
        if @d_result != 0 
          #実績表データ削除
          delete_sql = "delete from d_result_reports "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_reports.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
          
          delete_sql =nil
          #セルフ実績表データ削除
          delete_sql = "delete from d_result_self_reports "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_self_reports.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #地下タンク過不足データ削除
          delete_sql = "delete from d_tank_decrease_reports "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_tank_decrease_reports.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #地下タンク計算データ削除
          delete_sql = "delete from d_tank_compute_reports "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_tank_compute_reports.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #夢ポイントデータ削除
          delete_sql = "delete from d_result_yumepoints "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_yumepoints.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #POS回収実績データ削除
          delete_sql = "delete from d_result_collects "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_collects.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #車検予約実績データ削除
          delete_sql = "delete from d_result_reserves "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_reserves.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #車検予約実績データ削除
          delete_sql = "delete from d_result_reserves "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_reserves.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #他商品実績データ削除
          delete_sql = "delete from d_result_etcs "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_etcs.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #油外実績データ削除
          delete_sql = "delete from d_result_oiletcs "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_oiletcs.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #タンクメーターデータ削除
          delete_sql = "delete from d_result_tanks "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_tanks.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #油種メーターデータ削除
          delete_sql = "delete from d_result_meters "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_meters.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          delete_sql =nil
          #油種実績データ削除
          delete_sql = "delete from d_result_oils "
          delete_sql << " using d_results "
          delete_sql << " where d_results.id = d_result_oils.d_result_id "
          delete_sql << " and d_results.result_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
  
          #実績データ削除
           DResult.delete_all(['result_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
        #勤怠データ存在チェック
        @d_dutie = DDuty.count(:all, :conditions=>["duty_nengetu < ? ", params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        if @d_dutie != 0 
          #勤怠データ削除
          DDuty.delete_all(['duty_nengetu < ? ',params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        end
        #目標値データ存在チェック
        @d_aims = DAim.count(:all, :conditions => ["date < ? ",params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        if @d_aims != 0 
            # 目標値データ削除
            DAim.delete_all(['date < ? ',params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        end

     elsif params[:m_keep_months][:display_order].to_i == 2
        #売上データ存在チェック
        delete_sql =nil
        @d_sale = DSale.count(:all, :conditions => ["sale_date < ? ",params[:m_keep_months][:input_ymd].delete("/")])
        if @d_sale != 0 
          #売上内訳データ削除
          delete_sql = "delete from d_sale_items "
          delete_sql << " using d_sales "
          delete_sql << " where d_sales.id = d_sale_items.d_sale_id "
          delete_sql << " and d_sales.sale_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
          #売上データ削除
          DSale.delete_all(['sale_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
        #洗車売上データ存在チェック
        delete_sql =nil
        @d_wash_sale = DWashSale.count(:all, :conditions => ["sale_date < ? ",params[:m_keep_months][:input_ymd].delete("/")])
        if @d_wash_sale != 0 
          #洗車売上内訳データ削除
          delete_sql = "delete from d_washsale_items "
          delete_sql << " using d_wash_sales "
          delete_sql << " where d_wash_sales.id = d_washsale_items.d_wash_sale_id "
          delete_sql << " and d_wash_sales.sale_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
          
          #洗車売上データ削除
          DWashSale.delete_all(['sale_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        #他売上データ存在チェック
        delete_sql =nil
        @d_sale_etc = DSaleEtc.count(:all, :conditions => ["sale_date < ? ",params[:m_keep_months][:input_ymd].delete("/")])
        if @d_sale_etc  != 0 
          #他売上内訳データ削除
          delete_sql = "delete from d_sale_etc_details "
          delete_sql << " using d_sale_etcs "
          delete_sql << " where d_sale_etcs.id = d_sale_etc_details.d_sale_etc_id "
          delete_sql << " and d_sale_etcs.sale_date < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)
          
          #他売上データ削除
          DSaleEtc.delete_all(['sale_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        #売上現金管理表データ存在チェック
        @d_sale_report = DSaleReport.count(:all, :conditions=>["sale_date < ? ", params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        if @d_sale_report != 0 
          #売上現金管理表データ削除
          DSaleReport.delete_all(['sale_date < ? ',params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        end
        #洗車売上報告データ存在チェック
        delete_sql =nil
        @d_washsale_report = DWashsaleReport.count(:all, :conditions => ["sale_date < ?", params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        if @d_washsale_report  != 0 
          #洗車売上報告内訳データ削除
          delete_sql = "delete from d_washsale_detail_reports "
          delete_sql << " using d_washsale_reports "
          delete_sql << " where d_washsale_reports.id = d_washsale_detail_reports.d_washsale_report_id "
          delete_sql << " and d_washsale_reports.sale_date < '#{params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s}' "
          ActiveRecord::Base::connection.execute(delete_sql)

          #洗車売上報告データ削除
          DWashsaleReport.delete_all(['sale_date < ? ',params[:m_keep_months][:input_ymd].delete("/")[0,6].to_s])
        end
        #金庫釣銭監査データ存在チェック
        @d_audit_cashbox = DAuditCashbox.count(:all, :conditions => ["audit_date < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_audit_cashbox  != 0 
          #金庫釣銭監査データ削除
          DAuditCashbox.delete_all(['audit_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        #釣銭機内監査データ存在チェック
        @d_audit_changemachine = DAuditChangemachine.count(:all, :conditions => ["audit_date < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_audit_changemachine  != 0 
          #釣銭機内監査データ削除
          DAuditChangemachine.delete_all(['audit_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
        #洗車機監査データ存在チェック
        delete_sql =nil
        @d_audit_wash = DAuditWash.count(:all, :conditions => ["audit_date_to < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_audit_wash != 0 
          #洗車機監査詳細データ削除
          delete_sql = "delete from d_audit_wash_details "
          delete_sql << " using d_audit_washes "
          delete_sql << " where d_audit_washes.id = d_audit_wash_details.d_audit_wash_id "
          delete_sql << " and d_audit_washes.audit_date_to < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)

          #洗車機監査データ削除
          DAuditWash.delete_all(['audit_date_to < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
        #他売上監査データ存在チェック
        delete_sql =nil
        @d_audit_etc = DAuditEtc.count(:all, :conditions => ["audit_date_to < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_audit_etc != 0 
          #他売上監査詳細データ削除
          delete_sql = "delete from d_audit_etc_details "
          delete_sql << " using d_audit_etcs "
          delete_sql << " where d_audit_etcs.id = d_audit_etc_details.d_audit_etc_id "
          delete_sql << " and d_audit_etcs.audit_date_to < '#{params[:m_keep_months][:input_ymd].delete("/")}' "
          ActiveRecord::Base::connection.execute(delete_sql)

          #他売上監査データ削除
          DAuditEtc.delete_all(['audit_date_to < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
        #監査チェックデータ存在チェック
        @d_audit_check = DAuditCheck.count(:all, :conditions => ["audit_date < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_audit_check  != 0 
          #監査チェックデータ削除
          DAuditCheck.delete_all(['audit_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
        
     elsif params[:m_keep_months][:display_order].to_i == 3
        #備品購入申請データ存在チェック
        @fixture = DFixture.count(:all, :conditions => ["application_date < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @fixture  != 0 
          #備品購入申請データ削除
          DFixture.delete_all(['application_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end

     elsif params[:m_keep_months][:display_order].to_i == 4
        #アクセスログ存在チェック
        @access_logs = AccessLog.count(:all, :conditions => ["access_date < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @access_logs  != 0 
          #アクセスログ削除
          AccessLog.delete_all(['access_date < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
     elsif params[:m_keep_months][:display_order].to_i == 5
        #ユーザーマスタ存在チェック
        @user = User.find(:all, :conditions => ["taisyoku_date <> '' and taisyoku_date < ? ",params[:m_keep_months][:input_ymd].delete("/")])
        if @user != nil 
          @user.each do |user|
            @cnt =get_del_user(user.id)
            if @cnt == 0
              #人件費情報マスタ削除
               MInfoCost.delete(['user_id = ? ',user.id])
               #ユーザーマスタ削除
               User.delete(user.id)
            end
          end
        end
     elsif params[:m_keep_months][:display_order].to_i == 6
     
        #価格データ存在チェック
        @d_price_check = DPriceCheck.count(:all, :conditions => ["research_day < ?", params[:m_keep_months][:input_ymd].delete("/")])
        if @d_price_check  != 0 
          #価格データ削除
          DPriceCheck.delete_all(['research_day < ? ',params[:m_keep_months][:input_ymd].delete("/")])
        end
    else
        
    end

    respond_to do |format|
       format.html { redirect_to :controller => "data_deletes", :action => "index" }
       format.json { head :ok }
    end
  end
end
