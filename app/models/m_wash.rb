# -*- coding:utf-8 -*-
class MWash < ActiveRecord::Base
  
  validates :wash_cd, :presence => {:message => '洗車機コードは必須です。'}
  validates :wash_name, :presence => {:message => '洗車機名は必須です。'}
  validates :wash_ryaku, :presence => {:message => '洗車機略称は必須です。'}
  validates :wash_group, :presence => {:message => 'グループ種類は必須です。'}
  validates :max_num, :presence => {:message => '最大数は必須です。'}
  
end
