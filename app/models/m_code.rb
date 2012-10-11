# -*- coding:utf-8 -*-
class MCode < ActiveRecord::Base
  
  validates :kbn, :presence => {:message => 'コード区分は必須です。'}
  validates :code, :presence => {:message => 'コードは必須です。'}
  
  validates :code, :uniqueness => {:scope => :kbn,
                                   :message => 'コードが重複しています。'}
  
  validates :code, :numericality => {:greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 99,
                                     :message => 'コードは数値で入力してください。'}
  
end
