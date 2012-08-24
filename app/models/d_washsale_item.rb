class DWashsaleItem < ActiveRecord::Base
  validates :meter, numericality: {greater_than_or_equal_to: 0}
end
