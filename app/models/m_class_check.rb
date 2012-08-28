# -*- coding:utf-8 -*-
class MClassCheck < ActiveRecord::Base
  
  validates :class_code, :presence => {:message => '分類コードは必須です。'}
  validates :item, :presence => {:message => '分類名は必須です。'}
  
end
