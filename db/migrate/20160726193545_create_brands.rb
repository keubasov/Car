class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.string :synonym

      t.timestamps null: false
    end
  end
end
