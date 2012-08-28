# -*- coding:utf-8 -*-
class MAim < ActiveRecord::Base
  
  validates :aim_code, :presence => {:message => '目標値コードは必須です。'}
  validates :shop_kbn, :presence => {:message => '店舗種別は必須です。'}
  validates :input_kbn, :presence => {:message => '入力区分は必須です。'}
  
end
