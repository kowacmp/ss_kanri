# -*- coding:utf-8 -*-
class MAuditCheck < ActiveRecord::Base
  
  validates :check_code, :presence => {:message => 'チェックコードは必須です。'}
  validates :m_class_check_id, :presence => {:message => '分類は必須です。'}
  validates :content, :presence => {:message => '内容は必須です。'}
  
end
