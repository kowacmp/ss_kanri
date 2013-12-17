# -*- coding:utf-8 -*-
class AddColumnDResults2 < ActiveRecord::Migration
  def up
    add_column :d_results, :double_check,:smallint, :default => 0
    add_column :d_results, :double_check_user_id, :integer
    add_column :d_results, :double_check_date,    :timestamp
    execute "COMMENT ON COLUMN d_results.double_check IS '２重チェック  0:チェック無し　1:チェック有り';"
    execute "COMMENT ON COLUMN d_results.double_check_user_id IS '２重チェック登録者';"
    execute "COMMENT ON COLUMN d_results.double_check_date IS '２重チェック登録日';"
  end

  def down
    remove_column :d_results, :double_check
    remove_column :d_results, :double_check_user_id
    remove_column :d_results, :double_check_date
  end
end
