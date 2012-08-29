# -*- coding:utf-8 -*-
class MFixItem < ActiveRecord::Base
  
  validates :fix_item_cd, :presence => {:message => '固定額内訳コードは必須です。'}
  validates :fix_item_name, :presence => {:message => '固定額内訳名は必須です。'}
  validates :fix_item_class, :presence => {:message => '固定額内訳種別は必須です。'}
  
end
