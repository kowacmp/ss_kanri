# -*- coding:utf-8 -*-
class MAuthority < ActiveRecord::Base
  
  validates :authority_cd, :presence => {:message => '権限コードは必須です。'}
  validates :authority_name, :presence => {:message => '権限名は必須です。'}
  
  validates :authority_cd, :uniqueness => {:message => '権限コードが重複しています。'}
  
  validates :authority_cd, :numericality => {:greater_than_or_equal_to => 0,
                                             :less_than_or_equal_to => 99,
                                             :message => '権限コードは数値で入力してください。'}
  
end
