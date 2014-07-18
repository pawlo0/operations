class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :num_id
      t.string :name
      t.string :manufacturer
      t.string :model
      t.string :serial
      t.string :assigned_to
      t.string :location
      t.string :function
      t.date :manuf_date
      t.date :buy_date
      t.text :obs
      t.integer :maintenance_period
      t.string :maintenance_contact

      t.timestamps
    end
  end
end
