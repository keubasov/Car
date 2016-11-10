class RenameBrandsToMakes < ActiveRecord::Migration
  def change
    rename_table :brands, :makes
  end
end
