class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.date :date
      t.integer :price
      t.integer :year
      t.boolean :broken
      t.string :make
      t.string :model
      t.string :region
      t.integer :site_id
      t.string :link
      t.timestamps null: false
    end
  end
end
