class Model < ActiveRecord::Base
  def self.find_by_make_id (make_id)
    Model.where(make_id: make_id).to_a
  end
end
