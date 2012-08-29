# -*- coding:utf-8 -*-
class MOil < ActiveRecord::Base
  
  validates :oil_cd, :presence => {:message => '油種コードは必須です。'}
  validates :oil_name, :presence => {:message => '油種名は必須です。'}
  
end
