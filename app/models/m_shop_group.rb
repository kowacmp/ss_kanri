# -*- coding:utf-8 -*-
class MShopGroup < ActiveRecord::Base
  
  validates :group_cd, :presence => {:message => '所属コードは必須です。'}
  validates :group_name, :presence => {:message => '所属会社名は必須です。'}
  
end
