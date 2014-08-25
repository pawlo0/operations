class RemoveRepairAndPreventiveFromInterventions < ActiveRecord::Migration
  def self.up
    remove_column :interventions, :repair, :boolean
    remove_column :interventions, :preventive, :boolean
  end
  
  def self.down
    add_column :interventions, :repair, :boolean
    add_column :interventions, :preventive, :boolean    
  end
end
