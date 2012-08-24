class MApproval < ActiveRecord::Base
  validates :menu_id,
    :uniqueness => true
end
