class AddMaintaskToInterventions < ActiveRecord::Migration
  def change
    add_reference :interventions, :maintask, index: true
  end
end
