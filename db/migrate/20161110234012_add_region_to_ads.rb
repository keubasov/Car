class AddRegionToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :region, index: true, foreign_key: true
  end
end
