class CreateMaintasks < ActiveRecord::Migration
  def change
    create_table :maintasks do |t|
      t.references :equipment, index: true
      t.string :task
      t.integer :period
      t.string :unit

      t.timestamps
    end
  end
end
