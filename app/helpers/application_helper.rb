# -*- coding:utf-8 -*-
module ApplicationHelper
  def get_parent_menu(m_authority_id)
    sql = <<-SQL
      select m.* from authority_menus a, menus m
        where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.display_order = 0
      order by parent_menu_id       
    SQL

    session[:parent_menus] = AuthorityMenu.find_by_sql(sql)
  end
  
  def get_menus(m_authority_id, parent_menu_id)
    sql = <<-SQL
      select m.* from authority_menus a, menus m
       where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.display_order <> 0
         and parent_menu_id = #{parent_menu_id}
      order by display_order
    SQL

    session[:menus] = AuthorityMenu.find_by_sql(sql) 
  end
  
  def mnt_select_nendo_list
      AuthorityMenu.find(:all).map do |u|
                      [u.id, u.id]
      end                
  end
  
  def day_of_the_week(i)
    if i == 0
      wday = "日"
    elsif i == 1
      wday = "月"      
    elsif i == 2
      wday = "火"      
    elsif i == 3
      wday = "水"      
    elsif i == 4
      wday = "木"      
    elsif i == 5
      wday = "金"      
    elsif i == 6
      wday = "土"           
    end
    
    return wday
  end  
end
