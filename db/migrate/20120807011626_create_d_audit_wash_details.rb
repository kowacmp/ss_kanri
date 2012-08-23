class CreateDAuditWashDetails < ActiveRecord::Migration
  def change
    create_table :d_audit_wash_details do |t|

      t.integer    :id, :null => false
      t.integer    :d_audit_wash_id, :null => false
      t.integer    :m_wash_id, :null => false
      t.integer    :wash_no, :null => false
      t.integer    :meter
      t.integer    :error_money
      t.integer    :created_user_id, :null => false
      t.timestamp  :created_at, :null => false
      t.integer    :updated_user_id, :null => false
      t.timestamp  :updated_at, :null => false
      
    end
  end
end