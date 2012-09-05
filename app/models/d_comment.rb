# -*- coding:utf-8 -*-
class DComment < ActiveRecord::Base
    validates :send_day,   :presence => {:message => '入力日は必須です。'}
    validates :menu_id,    :presence => {:message => 'タイトルは必須です。'}
    validates :contents,   :presence => {:message => '内容は必須です。'}
    validates :receive_id, :presence => {:message => '表示先は必須です。'}
end
