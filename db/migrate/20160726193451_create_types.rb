class CreateTypes < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :name
      t.string :synonym

      t.timestamps null: false
    end
  end
end
