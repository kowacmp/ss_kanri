# -*- coding:utf-8 -*-
class MClassCheck < ActiveRecord::Base
  
  validates :class_code, :presence => {:message => '分類コードは必須です。'}
  validates :item, :presence => {:message => '分類名は必須です。'}
  
  validates :class_code, :uniqueness => {:message => '分類コードが重複しています。'}
  
  validates :class_code, :numericality => {:greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 99,
                                           :message => '分類コードは数値で入力してください。'}
  
end
