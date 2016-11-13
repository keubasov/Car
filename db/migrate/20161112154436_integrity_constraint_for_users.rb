class IntegrityConstraintForUsers < ActiveRecord::Migration
  def change
    change_column_null :regions, :name, false
  end
end
