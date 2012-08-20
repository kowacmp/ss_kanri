# -*- coding:utf-8 -*-
#初期値追加　細岡
class CreateMWashsalePlans < ActiveRecord::Migration
  def change
    create_table :m_washsale_plans do |t|
      t.integer :m_shop_id,:null => false
      t.integer :m_wash_id,:null => false
      t.integer :sunday   ,:default => 0,:limit => 1 
      t.integer :monday   ,:default => 0,:limit => 1
      t.integer :tuesday  ,:default => 0,:limit => 1
      t.integer :wednesday,:default => 0,:limit => 1
      t.integer :thursday ,:default => 0,:limit => 1
      t.integer :friday   ,:default => 0,:limit => 1
      t.integer :saturday ,:default => 0,:limit => 1
      t.integer :created_user_id,:default => 0
      t.integer :updated_user_id,:default => 0
      t.integer :deleted_flg ,:default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
