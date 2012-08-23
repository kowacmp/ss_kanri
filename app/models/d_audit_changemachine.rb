class DAuditChangemachine < ActiveRecord::Base

  #数値フィールドにカンマ付き数字でも保存できるようにする
  def id=(value)
      self[:id] = value.to_s.gsub(/,/, '')
  end
  def audit_class=(value)
      self[:audit_class] = value.to_s.gsub(/,/, '')
  end
  def m_shop_id=(value)
      self[:m_shop_id] = value.to_s.gsub(/,/, '')
  end
  def kakutei_flg=(value)
      self[:kakutei_flg] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money1=(value)
      self[:pos1_before_money1] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money2=(value)
      self[:pos1_before_money2] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money3=(value)
      self[:pos1_before_money3] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money4=(value)
      self[:pos1_before_money4] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money5=(value)
      self[:pos1_before_money5] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money6=(value)
      self[:pos1_before_money6] = value.to_s.gsub(/,/, '')
  end
  def pos1_before_money7=(value)
      self[:pos1_before_money7] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money1=(value)
      self[:pos1_after_money1] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money2=(value)
      self[:pos1_after_money2] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money3=(value)
      self[:pos1_after_money3] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money4=(value)
      self[:pos1_after_money4] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money5=(value)
      self[:pos1_after_money5] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money6=(value)
      self[:pos1_after_money6] = value.to_s.gsub(/,/, '')
  end
  def pos1_after_money7=(value)
      self[:pos1_after_money7] = value.to_s.gsub(/,/, '')
  end
  def pos1_supplement_money=(value)
      self[:pos1_supplement_money] = value.to_s.gsub(/,/, '')
  end
  def pos1_collectt_money=(value)
      self[:pos1_collectt_money] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money1=(value)
      self[:pos2_before_money1] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money2=(value)
      self[:pos2_before_money2] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money3=(value)
      self[:pos2_before_money3] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money4=(value)
      self[:pos2_before_money4] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money5=(value)
      self[:pos2_before_money5] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money6=(value)
      self[:pos2_before_money6] = value.to_s.gsub(/,/, '')
  end
  def pos2_before_money7=(value)
      self[:pos2_before_money7] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money1=(value)
      self[:pos2_after_money1] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money2=(value)
      self[:pos2_after_money2] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money3=(value)
      self[:pos2_after_money3] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money4=(value)
      self[:pos2_after_money4] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money5=(value)
      self[:pos2_after_money5] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money6=(value)
      self[:pos2_after_money6] = value.to_s.gsub(/,/, '')
  end
  def pos2_after_money7=(value)
      self[:pos2_after_money7] = value.to_s.gsub(/,/, '')
  end
  def pos2_supplement_money=(value)
      self[:pos2_supplement_money] = value.to_s.gsub(/,/, '')
  end
  def pos2_collectt_money=(value)
      self[:pos2_collectt_money] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money1=(value)
      self[:pos3_before_money1] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money2=(value)
      self[:pos3_before_money2] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money3=(value)
      self[:pos3_before_money3] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money4=(value)
      self[:pos3_before_money4] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money5=(value)
      self[:pos3_before_money5] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money6=(value)
      self[:pos3_before_money6] = value.to_s.gsub(/,/, '')
  end
  def pos3_before_money7=(value)
      self[:pos3_before_money7] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money1=(value)
      self[:pos3_after_money1] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money2=(value)
      self[:pos3_after_money2] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money3=(value)
      self[:pos3_after_money3] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money4=(value)
      self[:pos3_after_money4] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money5=(value)
      self[:pos3_after_money5] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money6=(value)
      self[:pos3_after_money6] = value.to_s.gsub(/,/, '')
  end
  def pos3_after_money7=(value)
      self[:pos3_after_money7] = value.to_s.gsub(/,/, '')
  end
  def pos3_supplement_money=(value)
      self[:pos3_supplement_money] = value.to_s.gsub(/,/, '')
  end
  def pos3_collectt_money=(value)
      self[:pos3_collectt_money] = value.to_s.gsub(/,/, '')
  end
  def before_cashbox=(value)
      self[:before_cashbox] = value.to_s.gsub(/,/, '')
  end
  def before_changemachine=(value)
      self[:before_changemachine] = value.to_s.gsub(/,/, '')
  end
  def ass=(value)
      self[:ass] = value.to_s.gsub(/,/, '')
  end
  def sale_pos1=(value)
      self[:sale_pos1] = value.to_s.gsub(/,/, '')
  end
  def sale_pos2=(value)
      self[:sale_pos2] = value.to_s.gsub(/,/, '')
  end
  def sale_pos3=(value)
      self[:sale_pos3] = value.to_s.gsub(/,/, '')
  end
  def sale_waiwai=(value)
      self[:sale_waiwai] = value.to_s.gsub(/,/, '')
  end
  def sale_receive=(value)
      self[:sale_receive] = value.to_s.gsub(/,/, '')
  end
  def sale_pay=(value)
      self[:sale_pay] = value.to_s.gsub(/,/, '')
  end
  def cashbox_money=(value)
      self[:cashbox_money] = value.to_s.gsub(/,/, '')
  end
  def changemachine_pos1=(value)
      self[:changemachine_pos1] = value.to_s.gsub(/,/, '')
  end
  def changemachine_pos2=(value)
      self[:changemachine_pos2] = value.to_s.gsub(/,/, '')
  end
  def changemachine_pos3=(value)
      self[:changemachine_pos3] = value.to_s.gsub(/,/, '')
  end
  def changemachine_after=(value)
      self[:changemachine_after] = value.to_s.gsub(/,/, '')
  end
  def receive_money=(value)
      self[:receive_money] = value.to_s.gsub(/,/, '')
  end
  def confirm_shop_id=(value)
      self[:confirm_shop_id] = value.to_s.gsub(/,/, '')
  end
  def confirm_user_id=(value)
      self[:confirm_user_id] = value.to_s.gsub(/,/, '')
  end
  def kakunin_flg=(value)
      self[:kakunin_flg] = value.to_s.gsub(/,/, '')
  end
  def kakunin_user_id=(value)
      self[:kakunin_user_id] = value.to_s.gsub(/,/, '')
  end
  def approve_id1=(value)
      self[:approve_id1] = value.to_s.gsub(/,/, '')
  end
  def approve_id2=(value)
      self[:approve_id2] = value.to_s.gsub(/,/, '')
  end
  def approve_id3=(value)
      self[:approve_id3] = value.to_s.gsub(/,/, '')
  end
  def approve_id4=(value)
      self[:approve_id4] = value.to_s.gsub(/,/, '')
  end
  def approve_id5=(value)
      self[:approve_id5] = value.to_s.gsub(/,/, '')
  end
  def created_user_id=(value)
      self[:created_user_id] = value.to_s.gsub(/,/, '')
  end
  def updated_user_id=(value)
      self[:updated_user_id] = value.to_s.gsub(/,/, '')
  end
  
end
