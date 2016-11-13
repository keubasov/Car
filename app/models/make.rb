class Make < ActiveRecord::Base

  has_many :models, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, format: {with: /[\wа-яА-Я\-]+/}
  validates :name, length: {in: 3..20}

  def self.find_by_model_id(model_id)
    model = Model.find(model_id)
    return 0 unless model
    Make.find(model.make_id).id || 0
  end
end
