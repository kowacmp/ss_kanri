class HomesController < ApplicationController
  def index
    @today = Time.now
    @end_day = @today + 6.days
    
    
    
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

end
