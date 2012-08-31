# -*- coding:utf-8 -*-
class MOil < ActiveRecord::Base
  
  validates :oil_cd, :presence => {:message => '油種コードは必須です。'}
  validates :oil_name, :presence => {:message => '油種名は必須です。'}
  
  validates :oil_cd, :uniqueness => {:message => '油種コードが重複しています。'}
  
  validates :oil_cd, :numericality => {:greater_than_or_equal_to => 0,
                                       :less_than_or_equal_to => 99,
                                       :message => '油種コードは数値で入力してください。'}
  
end
