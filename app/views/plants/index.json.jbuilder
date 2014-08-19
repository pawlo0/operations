json.array!(@plants) do |plant|
  json.extract! plant, :id, :name, :address
  json.url plant_url(plant, format: :json)
end
