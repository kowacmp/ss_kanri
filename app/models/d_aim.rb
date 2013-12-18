# -*- coding:utf-8 -*-
class DAim < ActiveRecord::Base
  belongs_to :m_aim
  
  validates :m_aim_id, :uniqueness => {:scope => [:date, :m_shop_id],
                                   :message => '重複しています。'}
end
