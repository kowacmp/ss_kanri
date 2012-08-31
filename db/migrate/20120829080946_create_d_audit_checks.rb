class CreateDAuditChecks < ActiveRecord::Migration
  def change
    create_table :d_audit_checks do |t|
      
      t.integer    :m_shop_id, :null => false
      t.string     :audit_date, :limit => 8, :null => false
      t.integer    :m_audit_check_id, :null => false
      t.integer    :check_flg
      t.string     :comment, :limit => 100
      t.integer    :created_user_id, :null => false
      t.timestamp  :created_at, :null => false
      t.integer    :updated_user_id, :null => false
      t.timestamp  :updated_at, :null => false
      
    end
  end
end
