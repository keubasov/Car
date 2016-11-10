class AddBrandToTypes < ActiveRecord::Migration
  def change
    add_reference :models, :brand, index: true, foreign_key: true
  end
end
