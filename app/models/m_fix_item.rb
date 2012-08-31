# -*- coding:utf-8 -*-
class MFixItem < ActiveRecord::Base
  
  validates :fix_item_cd, :presence => {:message => '固定額内訳コードは必須です。'}
  validates :fix_item_name, :presence => {:message => '固定額内訳名は必須です。'}
  validates :fix_item_class, :presence => {:message => '固定額内訳種別は必須です。'}
  
  validates :fix_item_cd, :uniqueness => {:message => '固定額内訳コードが重複しています。'}
  
  validates :fix_item_cd, :numericality => {:greater_than_or_equal_to => 0,
                                            :less_than_or_equal_to => 99,
                                            :message => '固定額内訳コードは数値で入力してください。'}
  
end
