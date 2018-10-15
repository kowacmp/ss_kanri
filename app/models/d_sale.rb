# -*- coding:utf-8 -*-
class DSale < ActiveRecord::Base
  
  validates :m_shop_id, :uniqueness => {:scope => :sale_date,
                                   :message => '重複しています。'}
  
  validate :set_default
  
  #DB更新時に初期値をセットする
  def set_default
    self.sale_money1 = 0 if read_attribute(:sale_money1).blank?
    self.sale_money2 = 0 if read_attribute(:sale_money2).blank?
    self.sale_money3 = 0 if read_attribute(:sale_money3).blank?
    self.sale_purika = 0 if read_attribute(:sale_purika).blank?
    self.sale_today_out = 0 if read_attribute(:sale_today_out).blank?
    self.sale_change1 = 0 if read_attribute(:sale_change1).blank?
    self.sale_change2 = 0 if read_attribute(:sale_change2).blank?
    self.sale_change3 = 0 if read_attribute(:sale_change3).blank?
    self.sale_ass = 0 if read_attribute(:sale_ass).blank?
    #2018.10.15 チャージ項目追加 oda add
    self.sale_charge = 0 if read_attribute(:sale_charge).blank?
    self.recive_money = 0 if read_attribute(:recive_money).blank?
    self.pay_money = 0 if read_attribute(:pay_money).blank?
    self.sale_cashbox = 0 if read_attribute(:sale_cashbox).blank?
    self.sale_changebox = 0 if read_attribute(:sale_changebox).blank?
    self.sale_am_out = 0 if read_attribute(:sale_am_out).blank?
    self.sale_pm_out = 0 if read_attribute(:sale_pm_out).blank?
    self.exist_money = 0 if read_attribute(:exist_money).blank?
    self.over_short = 0 if read_attribute(:over_short).blank?
    self.balance_money = 0 if read_attribute(:balance_money).blank?
    self.sale_etc = 0 if read_attribute(:sale_etc).blank?
    
  end
  
end
