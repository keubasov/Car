class RemoveBrokenFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :broken, :boolean
  end
end
