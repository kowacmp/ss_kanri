# -*- coding:utf-8 -*-
class MWash < ActiveRecord::Base
  
  validates :wash_cd, :presence => {:message => '洗車機コードは必須です。'}
  validates :wash_name, :presence => {:message => '洗車機名は必須です。'}
  validates :wash_ryaku, :presence => {:message => '洗車機略称は必須です。'}
  #validates :wash_group, :presence => {:message => 'グループ種類は必須です。'}
  validates :max_num, :presence => {:message => '最大数は必須です。'}
  
  validates :wash_cd, :uniqueness => {:message => '洗車機コードが重複しています。'}
  
  validates :wash_cd, :numericality => {:greater_than_or_equal_to => 0,
                                        :less_than_or_equal_to => 99,
                                        :message => '洗車機コードは数値で入力してください。'}
                                        
  validates :max_num, :numericality => {:greater_than_or_equal_to => 0,
                                        :less_than_or_equal_to => 99,
                                        :message => '最大数は数値で入力してください。'}                                      
  
end
