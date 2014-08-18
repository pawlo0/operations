class AddNameAndPlantToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :plant, :string
  end
end
