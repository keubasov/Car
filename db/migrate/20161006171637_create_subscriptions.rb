class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :max_price
      t.integer :min_year
      t.boolean :broken

      t.timestamps null: false
    end
    add_reference :subscriptions, :type, index: true
  end
end
