class RenameTypesToModels < ActiveRecord::Migration
  def change
    rename_table :types, :models
  end
end
