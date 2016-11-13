class IntegrityConstraintForSubscriptions < ActiveRecord::Migration
  def change
    change_column_null :subscriptions, :max_price, false
    change_column_null :subscriptions, :min_year, false
    change_column_null :subscriptions, :model_id, false
    change_column_null :subscriptions, :user_id, false
  end
end
