class Subscription < ActiveRecord::Base
  validates :type_id, presence: true
end
