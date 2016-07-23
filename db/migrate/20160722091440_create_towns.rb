class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.belongs_to :region

      t.timestamps null: false
    end
  end
end
