# -*- coding:utf-8 -*-
module ApplicationHelper
  def get_menus(m_authority_id)
    sql1 = "select m.menu_cd1, m.display_name from authority_menus a, menus m"
    sql1 << " where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd2 = 0"
    sql1 << " order by menu_cd1"

    session[:menu1] = AuthorityMenu.find_by_sql(sql1)
    session[:menu2] = Array::new
    session[:menu3] = Array::new
    
    session[:menu1].each do |menu1|
      sql2 = "select m.id, m.menu_cd2, m.uri, m.display_name"
      sql2 << " from authority_menus a, menus m"
      sql2 << " where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd2 <> 0"
      sql2 << " and m.menu_cd3 = 0 and menu_cd1 = #{menu1.menu_cd1} order by menu_cd2"

      session[:menu2][menu1.menu_cd1.to_i] = Hash::new
      session[:menu2][menu1.menu_cd1.to_i] = AuthorityMenu.find_by_sql(sql2)

      session[:menu2][menu1.menu_cd1.to_i].each do |menu2|
        sql3 = "select m.* from authority_menus a, menus m"
        sql3 << " where a.m_authority_id = #{m_authority_id} and a.menu_id = m.id and m.menu_cd3 <> 0"
        sql3 << " and menu_cd1 = #{menu1.menu_cd1} and menu_cd2 = #{menu2.menu_cd2}"
        sql3 << " order by menu_cd3"
        
        session[:menu3][menu1.menu_cd1.to_i] = Hash::new if session[:menu3][menu1.menu_cd1.to_i].blank?
        session[:menu3][menu1.menu_cd1.to_i][menu2.menu_cd2.to_i] = AuthorityMenu.find_by_sql(sql3)   
      end
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
  
  #カンマ編集
  def num_fmt(num, float_flg=false)
    
    if num.blank?
      return 0
    end
    
    if float_flg
      return number_with_delimiter(num.to_f)
    else
      return number_with_delimiter(num.to_f.round)
    end
  end
  
  def format_month(month)
    month = month.to_s
    if month.length == 1
      month = "0" + month
    else
      month = month
    end
    return month
  end
  
  #HTMLでかけない文字の実体参照と改行コードのHTMLへの置換を行う
  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
  
end
