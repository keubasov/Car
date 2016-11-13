class IntegrityConstraintForMakes < ActiveRecord::Migration
  def change
    change_column_null :makes, :name, false
  end
end
