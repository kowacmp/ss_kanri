# -*- coding:utf-8 -*-
class AddColumnDResultYumepoints < ActiveRecord::Migration
  def up
    add_column :d_result_yumepoints, :pay_money, :integer
    execute "COMMENT ON COLUMN d_result_yumepoints.pay_money IS '支払額'"    
  end

  def down
    remove_column :d_result_yumepoints, :pay_money
  end
end
