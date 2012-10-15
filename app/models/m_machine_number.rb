# -*- coding:utf-8 -*-
class MMachineNumber < ActiveRecord::Base
  
  validates :m_shop_id, :presence   => {:message => '店舗は必須です。'}
  
  validates :m_shop_id, :uniqueness => {:message => '店舗が重複しています。'}
  
end
