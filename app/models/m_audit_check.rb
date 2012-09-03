# -*- coding:utf-8 -*-
class MAuditCheck < ActiveRecord::Base
  
  validates :check_code, :presence => {:message => 'チェックコードは必須です。'}
  validates :m_class_check_id, :presence => {:message => '分類は必須です。'}
  validates :content, :presence => {:message => '内容は必須です。'}
  
  validates :check_code, :uniqueness => {:message => 'チェックコードが重複しています。'}
  
  validates :check_code, :numericality => {:greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 99,
                                           :message => 'チェックコードは数値で入力してください。'}
  
end
