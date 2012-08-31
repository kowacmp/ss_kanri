# -*- coding:utf-8 -*-
class MApproval < ActiveRecord::Base
  #validates :menu_id,
  #  :uniqueness => true
   
  validates :menu_id, :presence   => {:message => 'メニュー名は必須です。'}
  
  validates :menu_id, :uniqueness => {:message => 'メニュー名が重複しています。'}
    
end
