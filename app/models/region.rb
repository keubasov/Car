class Region < ActiveRecord::Base

  has_many :towns, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  def self.find_by_town_name(town_name)
    Region.where(id: Town.where(name: town_name).pluck(:region_id).first).first
  end
end
