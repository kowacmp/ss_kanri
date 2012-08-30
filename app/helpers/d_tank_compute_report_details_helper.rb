module DTankComputeReportDetailsHelper
  def get_select_oil(result_id,oil_id,m_shop_id)
    tank_id = Array.new

    tanks = MTank.find(:all,:conditions => ['m_oil_id = ? and m_shop_id = ?',oil_id,m_shop_id])
    tanks.each do |tank|
      tank_id << tank.id
    end
    tank_ids = tank_id.join(",")
    p "***** tank_ids = #{tank_ids} *****"


    sql = "select sum(inspect_flg) inspect_flg,sum(before_stock) before_stock,"
    sql = sql + " sum(receive) receive,sum(sale) sale,sum(compute_stock) compute_stock,"
    sql = sql + " sum(after_stock) after_stock,sum(decrease) decrease,"
    sql = sql + " sum(sale_total) sale_total,sum(decrease_total) decrease_total"
    sql = sql + " from d_tank_compute_reports"
    sql = sql + " where d_result_id = #{result_id}"
    sql = sql + " and m_tank_id in (#{tank_ids})"
    sql = sql + " group by d_result_id"
    

    DTankComputeReport.find_by_sql([sql]).first
  end
end
