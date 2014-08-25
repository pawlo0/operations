json.array!(@intervention_types) do |intervention_type|
  json.extract! intervention_type, :id, :name, :obs
  json.url intervention_type_url(intervention_type, format: :json)
end
