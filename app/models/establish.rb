# -*- coding:utf-8 -*-
class Establish < ActiveRecord::Base
  
  validates :tax_rate, :presence => {:message => '消費税率は必須です。'}
  validates :light_oil, :presence => {:message => '軽油税は必須です。'}
  validates :limit, :presence => {:message => '制限範囲は必須です。'}
  
end
