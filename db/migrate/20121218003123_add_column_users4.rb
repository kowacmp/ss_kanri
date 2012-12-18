# -*- coding:utf-8 -*-
class AddColumnUsers4 < ActiveRecord::Migration
  def up
    add_column :users, :pay_kbn, :integer
    
    execute "COMMENT ON COLUMN users.pay_kbn IS '支払区分';"
    
    execute "insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('pay_kbn', '1', '現金', '現金', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
             
             insert into m_codes(kbn, code, code_name, code_name1, created_at, updated_at) 
             values 
             ('pay_kbn', '2', '振込', '振込', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
            "
  end

  def down
    remove_column :users, :pay_kbn
    
    execute "delete from m_codes where kbn = 'pay_kbn' 
                                   and code in ( '1'
                                                ,'2' )"
    
  end
end
