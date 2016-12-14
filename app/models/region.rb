class Region < ActiveRecord::Base

  has_many :towns, dependent: :destroy
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  def self.find_by_town_name(town_name)
    Region.where(id: Town.where(name: town_name).pluck(:region_id).first).first
  end
  def self.collection
    order(:name).map{|r| [r.name, r.id]}
  end
end
