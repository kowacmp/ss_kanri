# -*- coding:utf-8 -*-
class MShopGroup < ActiveRecord::Base
  
  validates :group_cd, :presence => {:message => '所属コードは必須です。'}
  validates :group_name, :presence => {:message => '所属会社名は必須です。'}
  
  validates :group_cd, :uniqueness => {:message => '所属コードが重複しています。'}
  
  validates :group_cd, :numericality => {:greater_than_or_equal_to => 0,
                                         :less_than_or_equal_to => 99,
                                         :message => '所属コードは数値で入力してください。'}
  
end
