class RemoveBrokenFromAds < ActiveRecord::Migration
  def change
    remove_column :ads, :broken, :boolean
  end
end
