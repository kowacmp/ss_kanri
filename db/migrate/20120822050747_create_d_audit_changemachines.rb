class CreateDAuditChangemachines < ActiveRecord::Migration
  def change
    create_table :d_audit_changemachines do |t|

      t.integer    :id, :null => false
      t.string     :audit_date, :limit => 8, :null => false
      t.integer    :audit_class, :null => false
      t.integer    :m_shop_id, :null => false
      t.integer    :kakutei_flg, :null => false
      t.integer    :pos1_before_money1
      t.integer    :pos1_before_money2
      t.integer    :pos1_before_money3
      t.integer    :pos1_before_money4
      t.integer    :pos1_before_money5
      t.integer    :pos1_before_money6
      t.integer    :pos1_before_money7
      t.integer    :pos1_after_money1
      t.integer    :pos1_after_money2
      t.integer    :pos1_after_money3
      t.integer    :pos1_after_money4
      t.integer    :pos1_after_money5
      t.integer    :pos1_after_money6
      t.integer    :pos1_after_money7
      t.integer    :pos1_supplement_money
      t.integer    :pos1_collectt_money
      t.integer    :pos2_before_money1
      t.integer    :pos2_before_money2
      t.integer    :pos2_before_money3
      t.integer    :pos2_before_money4
      t.integer    :pos2_before_money5
      t.integer    :pos2_before_money6
      t.integer    :pos2_before_money7
      t.integer    :pos2_after_money1
      t.integer    :pos2_after_money2
      t.integer    :pos2_after_money3
      t.integer    :pos2_after_money4
      t.integer    :pos2_after_money5
      t.integer    :pos2_after_money6
      t.integer    :pos2_after_money7
      t.integer    :pos2_supplement_money
      t.integer    :pos2_collectt_money
      t.integer    :pos3_before_money1
      t.integer    :pos3_before_money2
      t.integer    :pos3_before_money3
      t.integer    :pos3_before_money4
      t.integer    :pos3_before_money5
      t.integer    :pos3_before_money6
      t.integer    :pos3_before_money7
      t.integer    :pos3_after_money1
      t.integer    :pos3_after_money2
      t.integer    :pos3_after_money3
      t.integer    :pos3_after_money4
      t.integer    :pos3_after_money5
      t.integer    :pos3_after_money6
      t.integer    :pos3_after_money7
      t.integer    :pos3_supplement_money
      t.integer    :pos3_collectt_money
      t.integer    :before_cashbox
      t.integer    :before_changemachine
      t.integer    :ass
      t.integer    :sale_pos1
      t.integer    :sale_pos2
      t.integer    :sale_pos3      
      t.integer    :sale_waiwai
      t.integer    :sale_receive
      t.integer    :sale_pay
      t.integer    :cashbox_money
      t.integer    :changemachine_pos1
      t.integer    :changemachine_pos2
      t.integer    :changemachine_pos3
      t.integer    :changemachine_after
      t.integer    :receive_money
      t.integer    :confirm_shop_id, :null => false
      t.integer    :confirm_user_id, :null => false
      t.string     :comment, :limit => 300      
      t.integer    :kakunin_flg, :null => false
      t.integer    :kakunin_user_id
      t.timestamp  :kakunin_date
      t.integer    :approve_id1
      t.timestamp  :approve_date1
      t.integer    :approve_id2
      t.timestamp  :approve_date2
      t.integer    :approve_id3
      t.timestamp  :approve_date3
      t.integer    :approve_id4
      t.timestamp  :approve_date4
      t.integer    :approve_id5
      t.timestamp  :approve_date5
      t.integer    :created_user_id, :null => false
      t.timestamp  :created_at, :null => false
      t.integer    :updated_user_id, :null => false
      t.timestamp  :updated_at, :null => false
      
    end
  end
end
