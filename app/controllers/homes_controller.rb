class HomesController < ApplicationController
  def index
    @today = Time.now
    @end_day = @today + 6.days
    today = Time.now.strftime("%Y%m%d")
    m_authority_id = current_user.m_authority_id
    user_id = current_user.id

    #イベント取得
    sql = <<-SQL
      select d.*, m.display_name
        from d_events d, menus m
       where d.menu_id = m.id and d.start_day <= '#{today}' and d.end_day >= '#{today}' 
         and (d.receive_group1 = #{m_authority_id} or d.receive_group2 = #{m_authority_id})
      order by d.action_day desc
    SQL

    @d_events = DEvent.find_by_sql(sql)        
    
    #メッセージ取得
    sql = <<-SQL
      select d.*, m.display_name 
        from d_messages d, menus m
       where d.menu_id = m.id and (d.receive_id1 = #{user_id} or d.receive_id2 = #{user_id} 
          or d.receive_id3 = #{user_id} or d.receive_id4 = #{user_id} or d.receive_id5 = #{user_id} 
          or receive_group1 = #{m_authority_id} or receive_group2 = #{m_authority_id})
      order by d.send_day desc
    SQL

    @d_messages = DMessage.find_by_sql(sql)         
    
    #コメント取得
    sql = <<-SQL
      select d.*, m.display_name, u.user_name 
        from d_comments d, menus m, users u
       where d.menu_id = m.id and d.send_id = u.id
         and d.receive_id = #{current_user.id}
      order by d.send_day desc
    SQL

    @d_comments = DComment.find_by_sql(sql)    
    
  end

  def show_d_comment
    p "show_d_comment   show_d_comment   show_d_comment   show_d_comment"
    p "id=#{params[:id]}"
    @d_comment = DComment.find(params[:id])
    @send_user = User.find(@d_comment.send_id)
    @menu = Menu.find(@d_comment.menu_id)
    
    render :layout => 'modal'
  end
end
