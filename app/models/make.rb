class Make < ActiveRecord::Base
  def self.find_by_model_id(model_id)
    model = Model.find(model_id)
    return 0 unless model
    Make.find(model.make_id).id || 0
  end
end
