json.array!(@maintasks) do |maintask|
  json.extract! maintask, :id, :equipment_id, :task, :period, :unit
  json.url maintask_url(maintask, format: :json)
end
