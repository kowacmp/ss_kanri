# -*- coding:utf-8 -*-
class AddColumnUsers < ActiveRecord::Migration
  def up
    add_column :users, :salary_kbn,:smallint, :default => 0
    
    execute "COMMENT ON COLUMN users.salary_kbn IS '給与区分  0:月給　1:年棒　2:時給　3:時給(福利)';"
  end

  def down
    remove_column :users, :salary_kbn
  end
end
