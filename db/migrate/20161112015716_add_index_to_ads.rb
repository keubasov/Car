class AddIndexToAds < ActiveRecord::Migration
  def change
    add_index :ads, :site_id, unique: true
  end
end
