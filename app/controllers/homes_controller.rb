class HomesController < ApplicationController
  
  include HomesHelper
  
  def index
    @today = Time.now
    @end_day = @today + 6.days
    today = Time.now.strftime("%Y%m%d")
    m_authority_id = current_user.m_authority_id
    user_id = current_user.id

    #１週間の予定
    sql = "select wp.*, w.wash_name from m_washsale_plans wp, m_washes w"
    sql << " where wp.m_wash_id = w.id and wp.deleted_flg = 0"
    sql << " and m_shop_id = #{current_user.m_shop_id} and w.deleted_flg = 0 order by w.wash_cd"
    
    @m_washsale_plans = MWashsalePlan.find_by_sql(sql) 


    #イベント取得
    event_sql = "select substr(action_day, 1, 4) || '/' || substr(action_day, 5, 2) || '/' || substr(action_day, 7, 2) as action_day,"
    event_sql << "      d.contents, d.title"
    event_sql << " from d_events d"
    event_sql << " where d.start_day <= '#{today}' and d.end_day >= '#{today}'"
    event_sql << " order by d.action_day desc"

    @d_events = DEvent.find_by_sql(event_sql)        
         
    
    #コメント取得
    @d_comments = DComment.find_by_sql(comment_sql(current_user.id))
  end

  def show_d_comment
    @d_comment = DComment.find(params[:id])
    @send_user = User.find(@d_comment.created_user_id)
    
    render :layout => 'modal'
  end
  
  def delete_d_comment
    @d_comment = DComment.find(params[:id])
    @d_comment.destroy
    
    @d_comments = DComment.find_by_sql(comment_sql(current_user.id))
  end
end
