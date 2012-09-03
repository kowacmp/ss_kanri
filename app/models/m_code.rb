# -*- coding:utf-8 -*-
class MCode < ActiveRecord::Base
  
  validates :kbn, :presence => {:message => '権限コードは必須です。'}
  validates :code, :presence => {:message => '権限名は必須です。'}
  
  validates :code, :uniqueness => {:scope => :kbn,
                                   :message => 'コードが重複しています。'}
  
  validates :code, :numericality => {:greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 9,
                                     :message => 'コードは数値で入力してください。'}
  
end
