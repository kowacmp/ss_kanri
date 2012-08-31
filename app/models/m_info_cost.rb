# -*- coding:utf-8 -*-
class MInfoCost < ActiveRecord::Base
  
  validates :user_id, :presence => {:message => 'ユーザは必須です。'}
  
  validates :user_id, :uniqueness => {:message => 'ユーザが重複しています。'}
  
end
