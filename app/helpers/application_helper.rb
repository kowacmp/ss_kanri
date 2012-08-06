# -*- coding:utf-8 -*-
module ApplicationHelper
  def get_menus(m_authority_id)
    sql = <<-SQL
      select m.* from authority_menus a, menus m
        where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd2 = 0
      order by menu_cd1      
    SQL
    $menu1 = AuthorityMenu.find_by_sql(sql)

    $menu2 = Array::new
    $menu3 = Array::new
    $menu1.each do |menu1|
      sql2 = <<-SQL
          select m.* from authority_menus a, menus m
           where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd2 <> 0
             and m.menu_cd3 = 0 and menu_cd1 = #{menu1.menu_cd1} order by menu_cd2  
      SQL
      p "sql2=#{sql2}"
      $menu2[menu1.menu_cd1.to_i] = Hash::new
      $menu2[menu1.menu_cd1.to_i] = AuthorityMenu.find_by_sql(sql2)

      $menu2[menu1.menu_cd1.to_i].each do |menu2|
        sql3 = <<-SQL
            select m.* from authority_menus a, menus m
             where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd3 <> 0
               and menu_cd1 = #{menu1.menu_cd1} and menu_cd2 = #{menu2.menu_cd2}
             order by menu_cd3
        SQL
        p "sql3=#{sql3}"
        p "3333333333333333333333333333333333333333333333333"
        p "menu1.menu_cd1=#{menu1.menu_cd1}"
        p "menu2.menu_cd2=#{menu2.menu_cd2}"        
        $menu3[menu1.menu_cd1.to_i] = Hash::new if $menu3[menu1.menu_cd1.to_i].blank?
        $menu3[menu1.menu_cd1.to_i][menu2.menu_cd2.to_i] = AuthorityMenu.find_by_sql(sql3) 
        p "$menu3[1][1]=#{$menu3[1][1]}"       
      end
    end
    p "$menu3[1][1]=#{$menu3[1][1]}"
    p "$menu3[1][2]=#{$menu3[1][2]}"    
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
