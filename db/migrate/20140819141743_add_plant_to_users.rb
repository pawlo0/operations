class AddPlantToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :plant, index: true
  end
end
