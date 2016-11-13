class Ad < ActiveRecord::Base

  belongs_to :region

  validates :date, :price, :year, :make, :model, :site_id, :link, :region_id, presence: true
  validates :site_id, uniqueness: true
  validates :date, inclusion: {in: (Date.today - 3) .. Date.today}
  validates :price, inclusion: {in: 10000 .. 5000000}
  validates :year, inclusion: {in: 1980 .. 2016}
  validates :make, length: {in: 3 .. 20}
  validates :model, length: {in: 3 .. 20}
  validates :link, format: {with: /\Ahttp[\w\/.-:]*.html\Z/}
  validates :link, length: {in: 25 .. 100}
end