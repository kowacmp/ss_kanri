# -*- coding:utf-8 -*-
class DAuditCashbox < ActiveRecord::Base
  validates :audit_class, :uniqueness => {:scope => [:audit_date, :m_shop_id],
                                   :message => '重複しています。'}
end
