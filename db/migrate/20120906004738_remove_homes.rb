class RemoveHomes < ActiveRecord::Migration
  def up
    execute "DROP TABLE userdata;"
    execute "DROP TABLE d_messages;"
    
    remove_column :d_comments, :send_id
    remove_column :d_events, :receive_group1
    remove_column :d_events, :receive_group2 
  end

  def down
  end
end
