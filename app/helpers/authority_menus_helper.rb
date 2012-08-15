module AuthorityMenusHelper
  def authority_menu_sql(m_authority_id)
    sql = "select m.id, m.menu_cd2, m.menu_cd3, m.display_name, a.id authority_menu_id"
    sql << " from menus m left join authority_menus a"
    sql << "   on (m.id = a.menu_id and a.m_authority_id = #{m_authority_id})"
    sql << " order by m.menu_cd1, m.menu_cd2, m.menu_cd3"
    p "sql=#{sql}"
    return sql
  end
end
