json.array!(@interventions) do |intervention|
  json.extract! intervention, :id, :day, :equipment_id, :eq_hours, :repair, :preventive, :description, :changed_parts, :maintainer, :task_num, :estimate_num, :purchase_num, :parts_cost, :labor_cost
  json.url intervention_url(intervention, format: :json)
end
