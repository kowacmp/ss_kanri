# -*- coding:utf-8 -*-
class MKeepMonth < ActiveRecord::Base
  
  validates :display_name, :presence => {:message => '名称は必須です。'}
  validates :keep_month, :presence => {:message => '保持期間は必須です。'}
  
   validates :keep_month, :numericality => {:greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 99,
                                     :message => '保持期間は数値で入力してください。'}
   validates :keep_month, :numericality => {:greater_than_or_equal_to => 1,
                                     :less_than_or_equal_to => 99,
                                     :message => '保持期間に0は入力不可です。'}
                                     
end
