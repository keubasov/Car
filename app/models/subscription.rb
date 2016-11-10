class Subscription < ActiveRecord::Base
  belongs_to  :user
  validates :model_id, presence: true
  def model
    Model.find(self.model_id).name || ''
  end
  def make
    Make.find(Model.find(self.model_id).make_id).name || ''
  end

  def self.overlap (model_id, price, year)
    Subscription.where( "model_id IN (?, ?) AND max_price >= ? AND min_year <= ?", model_id, 0, price, year)
  end

end
