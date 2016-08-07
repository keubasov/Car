class Brand < ActiveRecord::Base

  validates :name, uniqueness: true
end
