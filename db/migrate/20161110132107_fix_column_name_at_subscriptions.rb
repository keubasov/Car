class FixColumnNameAtSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :type_id, :model_id
  end
end
