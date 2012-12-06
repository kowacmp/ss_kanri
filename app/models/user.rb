# -*- coding:utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :m_shop
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :account,:password, :password_confirmation, :remember_me
  attr_accessible :email, :account,:password, :password_confirmation, :remember_me,
                  :user_name,:user_name_kana,:m_shop_id,:m_authority_id,:user_class,:salary_kbn,
                  :nyusya_date,:birthday, :duty_sort, :org_shop_id, :taisyoku_date, :return_date
                  # ADD 2012.12.06 人件費出力区分,主店舗id,退職日,返却日
                  
  validates :account,         :presence => {:message => '社員コードは必須です。'}
  validates :user_name,       :presence => {:message => '氏名は必須です。'}
  validates :user_name_kana,  :presence => {:message => '氏名カナは必須です。'}
  validates :m_shop_id,       :presence => {:message => '所属店舗は必須です。'}
  validates :user_class,      :presence => {:message => '社員種別は必須です。'}
  validates :m_authority_id,  :presence => {:message => '権限は必須です。'}
  validates :salary_kbn,      :presence => {:message => '給与区分は必須です。'}
  
  validates :account,         :uniqueness => {:message => '社員コードが重複しています。'}
  
  validates :password,        :confirmation => {:message => 'パスワードが一致していません。'}
  
  validates :account,        :length => {:minimum => 4, :maximum => 10,
                                          :message => '社員コードは４文字以上１０文字以内で入力してください。'}

  def email_required?
    false
  end
  
  
end
