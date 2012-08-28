# -*- coding:utf-8 -*-
class MInfoCost < ActiveRecord::Base
  
  validates :user_id, :presence => {:message => 'ユーザは必須です。'}
  
end
