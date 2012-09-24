# -*- coding:utf-8 -*-
class MItem < ActiveRecord::Base
  
  validates :item_class, :presence => {:message => '内訳種別は必須です。'}
  #validates :m_item_account_id, :presence => {:message => '内訳科目は必須です。'}
  
end
