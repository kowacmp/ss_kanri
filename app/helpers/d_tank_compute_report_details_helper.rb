module DTankComputeReportDetailsHelper
  
  def get_tank_ids_tank(tank_id,shop_id,mode) #tank選択時のタンクNo表示
    sql = <<-SQL
      select * from m_tanks
      where tank_union_no in (
      select tank_union_no from m_tanks
      where id = ?)
      and m_shop_id = ?
      order by id
    SQL
    volume = 0
    tank_data = Hash.new
    tank_no = Array.new
    tanks = MTank.find_by_sql([sql,tank_id,shop_id])
    tanks.each do |tank|
      tank_no << tank.tank_no
      volume = volume + tank.volume
    end
    if mode == 1
      tank_data = tank_no.join(",")
    else
      tank_data = volume
    end
    return tank_data
    #p "***** tank_data = #{tank_data} *****"
  end

  def get_select_oil(result_id,oil_id,m_shop_id)
    tank_id = Array.new

    tanks = MTank.find(:all,:conditions => ['m_oil_id = ? and m_shop_id = ?',oil_id,m_shop_id])
    tanks.each do |tank|
      tank_id << tank.tank_no
    end
    tank_ids = tank_id.join(",")
    #p "***** tank_ids = #{tank_ids} *****"


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
  
  def get_select_tank(d_result_id,m_tank_id,shop_id)
     sql = <<-SQL
       select sum(inspect_flg) inspect_flg, sum(before_stock) before_stock,
       sum(receive) receive,sum(sale) sale,sum(compute_stock) compute_stock,
       sum(after_stock) after_stock,sum(sale_total) sale_total,
       sum(decrease_total) decrease_total,sum(decrease) decrease
       from 
       (select * from m_tanks
       where tank_union_no in (
       select tank_union_no from m_tanks
       where id = ?)
       and m_shop_id = ?
       order by id) a,
       d_tank_compute_reports b
       where a.id = b.m_tank_id
       and b.d_result_id = ?
     SQL
     
     DTankComputeReport.find_by_sql([sql,m_tank_id,shop_id,d_result_id]).first
  end
end
