class IntegrityConstraintForTowns < ActiveRecord::Migration
  def change
    change_column_null :towns, :name, false
    change_column_null :towns, :region_id, false
  end
end
