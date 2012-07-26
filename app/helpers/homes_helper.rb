# -*- coding:utf-8 -*-
module HomesHelper
  def home_date_format(today, i)
    day = today + i.days
    
    return_day = day.strftime("%d日")
    wday = day_of_the_week(day.wday)
    return return_day, wday
  end
end
