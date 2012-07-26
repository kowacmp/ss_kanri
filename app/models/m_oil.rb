# encoding: utf-8

class MOil < ActiveRecord::Base
  
  #HUMANIZED_KEY_NAMES = {
  #  "oil_cd" => "油種コード", "oil_name" => "油種名"
  #}
  
  validates :oil_cd, :presence => {:message => 'は必須です。'}
  validates :oil_name, :presence => {:message => 'は必須です。'}
  
  
  #class << self
  #  def human_attribute_name(attribute_key_name)
  #    HUMANIZED_KEY_NAMES[attribute_key_name] || super
  #  end
  #end
  
end
