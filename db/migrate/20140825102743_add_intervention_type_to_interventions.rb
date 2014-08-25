class AddInterventionTypeToInterventions < ActiveRecord::Migration
  def change
    add_reference :interventions, :intervention_type, index: true
  end
end
