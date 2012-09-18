# -*- coding:utf-8 -*-
class Establish < ActiveRecord::Base
  
  validates :tax_rate, :presence => {:message => '消費税率は必須です。'}
  validates :light_oil, :presence => {:message => '軽油税は必須です。'}
  validates :limit, :presence => {:message => '制限範囲は必須です。'}
  
  validates :tax_rate, :numericality => {:greater_than_or_equal_to => 0,
                                          :less_than => 10,
                                          :message => '消費税率は10未満で入力してください。'}
  validates :light_oil, :numericality => {:greater_than_or_equal_to => 0,
                                          :less_than => 1000,
                                          :message => '軽油税は1,000未満で入力してください。'}
  validates :limit, :numericality => {:greater_than_or_equal_to => 0,
                                          :less_than => 1000,
                                          :message => '制限範囲は1,000未満で入力してください。'}
  
end
