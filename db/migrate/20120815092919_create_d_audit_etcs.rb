class CreateDAuditEtcs < ActiveRecord::Migration
  def change
    create_table :d_audit_etcs do |t|

      t.integer    :id, :null => false
      t.string     :audit_date_from, :limit => 8, :null => false
      t.string     :audit_date_to, :limit => 8, :null => false
      t.integer    :audit_class, :null => false
      t.integer    :m_shop_id, :null => false
      t.integer    :kakutei_flg, :null => false
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
      t.integer    :confirm_shop_id, :null => false
      t.integer    :confirm_user_id, :null => false
      t.string     :comment, :limit => 300
      t.integer    :created_user_id, :null => false
      t.timestamp  :created_at, :null => false
      t.integer    :updated_user_id, :null => false
      t.timestamp  :updated_at, :null => false
      
    end
  end
end
