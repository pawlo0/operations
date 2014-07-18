json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :num_id, :name, :manufacturer, :model, :serial, :assigned_to, :location, :function, :manuf_date, :buy_date, :obs, :maintenance_period, :maintenance_contact
  json.url equipment_url(equipment, format: :json)
end
