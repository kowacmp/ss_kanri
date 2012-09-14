# -*- coding:utf-8 -*-
class MItemAccount < ActiveRecord::Base
  
  validates :item_account_class, :presence => {:message => '勘定種別は必須です。'}
  validates :item_account_code, :presence => {:message => '勘定科目コードは必須です。'}
  validates :item_account_name, :presence => {:message => '勘定科目名称は必須です。'}
  
  validates :item_account_code, :uniqueness => {:message => '勘定科目コードが重複しています。'}
  
  validates :item_account_code, :numericality => {:greater_than_or_equal_to => 0,
                                       :less_than_or_equal_to => 9999,
                                       :message => '勘定科目コードは数値で入力してください。'}
  
end
