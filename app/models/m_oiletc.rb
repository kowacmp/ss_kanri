# -*- coding:utf-8 -*-
class MOiletc < ActiveRecord::Base
  
  validates :oiletc_cd, :presence => {:message => '油外コードは必須です。'}
  validates :oiletc_name, :presence => {:message => '油外名は必須です。'}
  validates :oiletc_ryaku, :presence => {:message => '油外略称は必須です。'}
  validates :oiletc_tani, :presence => {:message => '単位は必須です。'}
  validates :oiletc_group, :presence => {:message => 'グループ種類は必須です。'}
  validates :tax_flg, :presence => {:message => '課税フラグは必須です。'}
  validates :oiletc_trade, :presence => {:message => '営業項目は必須です。'}
  
end
