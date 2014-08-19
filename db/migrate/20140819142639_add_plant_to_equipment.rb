class AddPlantToEquipment < ActiveRecord::Migration
  def change
    add_reference :equipment, :plant, index: true
  end
end
