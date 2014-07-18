class CreateInterventions < ActiveRecord::Migration
  def change
    create_table :interventions do |t|
      t.date :day
      t.references :equipment, index: true
      t.integer :eq_hours
      t.boolean :repair
      t.boolean :preventive
      t.text :description
      t.text :changed_parts
      t.string :maintainer
      t.string :task_num
      t.string :estimate_num
      t.string :purchase_num
      t.decimal :parts_cost
      t.decimal :labor_cost

      t.timestamps
    end
  end
end
