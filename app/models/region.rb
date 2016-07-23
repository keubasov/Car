class Region < ActiveRecord::Base

  has_many :towns, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
end
