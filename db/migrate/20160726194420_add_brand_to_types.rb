class AddBrandToTypes < ActiveRecord::Migration
  def change
    add_reference :types, :brand, index: true, foreign_key: true
  end
end
