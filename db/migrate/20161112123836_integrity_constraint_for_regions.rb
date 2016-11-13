class IntegrityConstraintForRegions < ActiveRecord::Migration
  def change
    change_column_null :users, :verified, false
    change_column_default :users, :verified, false
    change_column_null :users, :region_id, false
  end
end
