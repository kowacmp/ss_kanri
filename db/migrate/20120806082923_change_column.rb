class ChangeColumn < ActiveRecord::Migration
  def up
    rename_column :d_result_collects, :create_user_id, :created_user_id  
    rename_column :d_result_collects, :update_user_id, :updated_user_id
    
    rename_column :d_result_etcs, :create_user_id, :created_user_id  
    rename_column :d_result_etcs, :update_user_id, :updated_user_id
    
    rename_column :d_result_meters, :create_user_id, :created_user_id  
    rename_column :d_result_meters, :update_user_id, :updated_user_id

    rename_column :d_result_oiletcs, :create_user_id, :created_user_id  
    rename_column :d_result_oiletcs, :update_user_id, :updated_user_id
   
    rename_column :d_result_oils, :create_user_id, :created_user_id  
    rename_column :d_result_oils, :update_user_id, :updated_user_id 

    rename_column :d_results, :create_user_id, :created_user_id  
    rename_column :d_results, :update_user_id, :updated_user_id                    
  end

  def down
  end
end
