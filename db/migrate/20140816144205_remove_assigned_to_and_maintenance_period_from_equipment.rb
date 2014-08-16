class RemoveAssignedToAndMaintenancePeriodFromEquipment < ActiveRecord::Migration
  def self.up
    remove_column :equipment, :assigned_to, :string
    remove_column :equipment, :maintenance_period, :integer
  end
  
  def self.down
    add_column :equipment, :assigned_to, :string
    add_column :equipment, :maintenance_period, :integer
  end
end
