# -*- coding:utf-8 -*-
class AddColumnUsers2 < ActiveRecord::Migration
  def up
    
    # 入社日,生年月日の型変更 timestamp → varchar
    
    add_column :users, :tmp_nyusya_date, :string, :limit => 8
    add_column :users, :tmp_birthday,    :string, :limit => 8
    
    execute "update users set  tmp_nyusya_date = TO_CHAR(nyusya_date, 'YYYYMMDD')
                              ,tmp_birthday    = TO_CHAR(birthday, 'YYYYMMDD'); "
    
    execute "update users set  nyusya_date = null
                              ,birthday    = null; "
    
    change_column :users, :nyusya_date, :string, :limit => 8
    change_column :users, :birthday,    :string, :limit => 8

    execute "update users set  nyusya_date = tmp_nyusya_date 
                              ,birthday    = tmp_birthday; "
    
    remove_column :users, :tmp_nyusya_date
    remove_column :users, :tmp_birthday
    
    # 新規項目追加
    add_column :users, :duty_sort,     :integer, :default => 0
    add_column :users, :org_shop_id,   :integer
    add_column :users, :taisyoku_date, :string, :limit => 8
    add_column :users, :return_date,   :string, :limit => 8
    
    execute "update users set org_shop_id = m_shop_id;"
    
    execute "COMMENT ON COLUMN users.duty_sort     IS '人件費出力区分';
             COMMENT ON COLUMN users.org_shop_id   IS '主店舗id';
             COMMENT ON COLUMN users.taisyoku_date IS '退職日';
             COMMENT ON COLUMN users.return_date   IS '返却日';
            "
    
  end

  def down
    
    # 入社日,生年月日の型変更 verchar → timestamp
    add_column :users, :tmp_nyusya_date, :timestamp
    add_column :users, :tmp_birthday,    :timestamp
    
    execute "update users set  tmp_nyusya_date = TO_DATE(nyusya_date, 'YYYYMMDD')
                              ,tmp_birthday    = TO_DATE(birthday, 'YYYYMMDD'); "
    
    # 値がnullでもvarchar→timestampが出来ないため、削除して追加
    remove_column :users, :nyusya_date
    remove_column :users, :birthday
    add_column :users, :nyusya_date, :timestamp
    add_column :users, :birthday,    :timestamp
    
    execute "update users set  nyusya_date = tmp_nyusya_date 
                              ,birthday    = tmp_birthday; "
    
    remove_column :users, :tmp_nyusya_date
    remove_column :users, :tmp_birthday
    
    # 新規項目削除
    remove_column :users, :duty_sort
    remove_column :users, :org_shop_id
    remove_column :users, :taisyoku_date
    remove_column :users, :return_date
    
  end
end
