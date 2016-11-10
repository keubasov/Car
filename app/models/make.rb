class Make < ActiveRecord::Base
  def self.find_by_model_id(model_id)
    Make.find(Model.find(model_id).make_id).id || 0
  end
end
