class Model < ActiveRecord::Base

  def self.find_by_make_id (make_id)
    Model.where(make_id: make_id).to_a
  end

  def self.find_id_by_name (name)
    Model.where(name: name).ids.first
  end
end
