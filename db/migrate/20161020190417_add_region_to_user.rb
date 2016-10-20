class AddRegionToUser < ActiveRecord::Migration
  def change
    add_reference :users, :region, index: true, foreign_key: true
  end
end