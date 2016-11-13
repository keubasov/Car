class IntegrityConstraintForModels < ActiveRecord::Migration
  def change
    change_column_null :models, :name, false
  end
end
