# -*- coding:utf-8 -*-
class MGetPoint < ActiveRecord::Base
  
  validates :rank, :presence => {:message => '順位は必須です。'}
  validates :league_rank, :presence => {:message => 'リーグ順位は必須です。'}
  
  validates :league_rank, :uniqueness => {:scope => :rank,
                                   :message => 'リーグ順位が重複しています。'}
  
  #validates :league_rank, :numericality => {:greater_than_or_equal_to => 1,
  #                                   :less_than_or_equal_to => 5,
  #                                   :message => 'リーグ順位は１以上５以内で入力してください。'}
                                     
  validates :pt, :numericality => {:greater_than_or_equal_to => 0,
                                     :less_than_or_equal_to => 999,
                                     :message => '獲得ポイントは数値で入力してください。'}
  
end
