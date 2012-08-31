# -*- coding:utf-8 -*-
class MAim < ActiveRecord::Base
  
  validates :aim_code, :presence => {:message => '目標値コードは必須です。'}
  validates :shop_kbn, :presence => {:message => '店舗種別は必須です。'}
  validates :input_kbn, :presence => {:message => '入力区分は必須です。'}
  
  validates :aim_code,  :uniqueness => {:message => '目標値コードが重複しています。'}
  
  validates :aim_code, :numericality => {:greater_than_or_equal_to => 0,
                                         :less_than_or_equal_to => 99,
                                         :message => '目標値コードは数値で入力してください。'}
  
end
