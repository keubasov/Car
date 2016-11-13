class IntegrityConstraintForAds < ActiveRecord::Migration
  def change
    change_column_null :ads, :date, false
    change_column_null :ads, :price, false
    change_column_null :ads, :year, false
    change_column_null :ads, :make, false
    change_column_null :ads, :model, false
    change_column_null :ads, :site_id, false
    change_column_null :ads, :link, false
    change_column_null :ads, :region_id, false
  end
end