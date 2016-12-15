class Region < ActiveRecord::Base

  has_many :towns, dependent: :destroy
  has_many :users
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  def self.collection
    order(:name).map{|r| [r.name, r.id]}
  end
end
