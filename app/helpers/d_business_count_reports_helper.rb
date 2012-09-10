module DBusinessCountReportsHelper
  def get_d_aim(ym,shop_id,aim_id)
    DAim.where(:date => ym,:m_shop_id => shop_id,
           :m_aim_id => aim_id).select('id,date,m_shop_id,m_aim_id,aim_total').first
  end  
end
