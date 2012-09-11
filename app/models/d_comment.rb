# -*- coding:utf-8 -*-
class DComment < ActiveRecord::Base
    validates :send_day,   :presence => {:message => '入力日は入力必須です。'}
    validates :title,    :presence => {:message => 'タイトルは入力必須です。'}
    validates :contents,   :presence => {:message => '内容は入力必須です。'}
    validates :receive_id, :presence => {:message => '表示先は入力必須です。'}
    
    validates :contents, :length => {:maximum => 40, :message => "内容は40文字以内で入力してください．" }
    validates :title, :length => {:maximum => 20, :message => "タイトルは20文字以内で入力してください．" }
end
