# -*- coding:utf-8 -*-
module HomesHelper
  def home_date_format(today, i)
    day = today + i.days
    
    return_day = day.strftime("%d日")
    wday = day_of_the_week(day.wday)
    return return_day, wday
  end
  
  def comment_sql(user_id)
    sql = "select d.id, d.send_day, d.title, u.user_name"
    sql << " from d_comments d, users u"
    sql << " where d.created_user_id = u.id"
    sql << "   and d.receive_id = #{user_id} order by d.send_day desc"

    return sql
  end  
end
