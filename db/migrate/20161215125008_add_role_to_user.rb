class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'subscriber', null: false
  end
end
