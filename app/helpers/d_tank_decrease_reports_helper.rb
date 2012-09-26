module DTankDecreaseReportsHelper
  def get_title(id)
    MOil.find(:all,:conditions => ['deleted_flg = 0 and id = ?',id]).first.oil_name
  end
  
  def get_shops1(group_id)
    MShop.find(:all,:conditions => ['m_shop_group_id = ? and shop_kbn <> 9 ',group_id],:order => 'shop_cd')
  end
  
  def get_d_result(shop_id,result_date)
    DResult.find(:all,:conditions => ['m_shop_id = ? and result_date = ?',shop_id,result_date]).first
  end
end
