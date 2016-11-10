class FixColumnNameAtModels < ActiveRecord::Migration
  def change
    rename_column :models, :brand_id, :make_id
  end
end
