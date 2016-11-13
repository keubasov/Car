class Model < ActiveRecord::Base

  belongs_to :make
  has_many :subscriptions
  validates :name, :make_id, presence: true
  validates :name, uniqueness: {case_sensitive: false}
  validates :name, format: {with: /[\w\sа-яА-Я\-]+/}
  validates :name, length: {in: 3..20}

  def self.find_by_make_id (make_id)
    Model.where(make_id: make_id).to_a
  end

  def self.find_id_by_name (name)
    Model.where(name: name).ids.first
  end
end
