class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
