# -*- coding:utf-8 -*-
class MEtc < ActiveRecord::Base
  
  validates :etc_cd, :presence => {:message => '他商品コードは必須です。'}
  validates :etc_name, :presence => {:message => '他商品名は必須です。'}
  validates :etc_ryaku, :presence => {:message => '他商品略称は必須です。'}
  validates :etc_tani, :presence => {:message => '単位は必須です。'}
  validates :etc_group, :presence => {:message => 'グループ種類は必須です。'}
  validates :max_num, :presence => {:message => '最大数は必須です。'}
  validates :kansa_flg, :presence => {:message => '監査フラグは必須です。'}
  validates :tax_flg, :presence => {:message => '課税フラグは必須です。'}
  
  validates :etc_cd, :uniqueness => {:message => '他商品コードが重複しています。'}
  
  validates :etc_cd, :numericality => {:greater_than_or_equal_to => 0,
                                       :less_than_or_equal_to => 999,
                                       :message => '他商品コードは数値で入力してください。'}
                                       
  validates :max_num, :numericality => {:greater_than_or_equal_to => 0,
                                        :less_than_or_equal_to => 99,
                                        :message => '最大数は数値で入力してください。'}                                     

end
