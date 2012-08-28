# -*- coding:utf-8 -*-
class MItemAccount < ActiveRecord::Base
  
  validates :item_account_code, :presence => {:message => '勘定科目コードは必須です。'}
  validates :item_account_name, :presence => {:message => '勘定科目名称は必須です。'}
  
end
