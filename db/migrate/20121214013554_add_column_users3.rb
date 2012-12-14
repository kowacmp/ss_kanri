# -*- coding:utf-8 -*-
class AddColumnUsers3 < ActiveRecord::Migration
  def up
    
    add_column :users, :duty_kbn_sort, :integer, :default => 0
    add_column :users, :user_rank, :integer, :defalut => 0
    
    execute "COMMENT ON COLUMN users.duty_kbn_sort IS '出力区分内順';
             COMMENT ON COLUMN users.user_rank IS 'ユーザーランク';
            "
    
    execute "insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('user_rank', '00', '無', '無', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
             insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('user_rank', '01', 'S', 'S', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
             insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('user_rank', '02', 'A', 'A', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
             insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('user_rank', '03', 'B', 'B', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
             insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('user_rank', '10', '研', '研', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
            "
            
  end

  def down
    
    remove_column :users, :duty_kbn_sort
    remove_column :users, :user_rank
    
    execute "delete from m_codes where kbn = 'user_rank' 
                                   and code in ( '00'
                                                ,'01'
                                                ,'02'
                                                ,'03'
                                                ,'10' )"
    
  end
end
