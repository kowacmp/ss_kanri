# -*- coding:utf-8 -*-
class DEvent < ActiveRecord::Base

    
    validates :start_day,   :presence => {:message => '開始日は入力必須です。'}
    validates :end_day, :presence => {:message => '終了日は入力必須です。'} 
    validates :action_day,   :presence => {:message => '実施日は入力必須です。'}
    validates :contents,   :presence => {:message => '内容は入力必須です。'}
    validates :title,   :presence => {:message => 'タイトルは入力必須です。'}
   
    validates :contents, :length => {:maximum => 40, :message => "内容は40文字以内で入力してください．" }
    validates :title, :length => {:maximum => 20, :message => "タイトルは20文字以内で入力してください．" }
end
