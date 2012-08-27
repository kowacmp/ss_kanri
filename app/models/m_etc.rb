# -*- coding:utf-8 -*-
class MEtc < ActiveRecord::Base
  
  validates :etc_cd, :presence => {:message => '他売上コードは必須です。'}
  validates :etc_name, :presence => {:message => '他売上名は必須です。'}
  validates :etc_ryaku, :presence => {:message => '他売上略称は必須です。'}
  validates :etc_tani, :presence => {:message => '単位は必須です。'}
  validates :etc_group, :presence => {:message => 'グループ種類は必須です。'}
  validates :max_num, :presence => {:message => '最大数は必須です。'}
  validates :kansa_flg, :presence => {:message => '監査フラグは必須です。'}
  validates :tax_flg, :presence => {:message => '課税フラグは必須です。'}

end
