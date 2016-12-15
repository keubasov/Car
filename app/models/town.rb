class Town < ActiveRecord::Base
  belongs_to :region
  validates :region_id, presence: true
  validates :name, presence: true
  validates :name, uniqueness: {scope: :region_id, message: 'should be unique in a region'}

  def self.find_region_by_name(town_name)
    find_by_name(town_name).region_id
  end
end
