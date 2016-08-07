class Type < ActiveRecord::Base

validates :name, uniqueness: true
end
