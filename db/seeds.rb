# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Rather start by cleaning the database
Equipment.destroy_all
Intervention.destroy_all

# Open Elementos.xml
f = File.open(File.join(Rails.root, "db", "Elementos.xml"))
doc = Nokogiri::XML(f)
f.close

doc.css("ELEMENTOS").each do |node|
  children = node.children

  # Some data needs to be converted
  manuf = (children.css('AnoFabrico').inner_text).to_i
  purchase = (children.css('AnoCompra').inner_text).to_i
  
  # Some dates are non existent or have value of 0
  # So to avoid problems when saving to da DB it's best to give them a value
  manuf = 1900 if manuf < 1900 
  purchase = 1900 if purchase < 1900

  Equipment.create(
    :num_id => children.css("NIdentifica").inner_text,
    :name => children.css("Equipamento").inner_text,
    :manufacturer => children.css("Marca").inner_text,
    :model => children.css("Modelo").inner_text,
    :assigned_to => children.css("AssignadoA").inner_text,
    :serial => children.css("NSerie").inner_text,
    :manuf_date => Date.new(manuf,1,1),
    :buy_date => Date.new(purchase,1,1),
    :function => children.css("Funcao").inner_text,
    :obs => children.css("Obs").inner_text,
    :maintenance_period => children.css("PeriodManut").inner_text,
    :maintenance_contact => children.css("Contacto").inner_text
  )
end

p "Created #{Equipment.count} equipments."


f = File.open(File.join(Rails.root, "db", "Intervencoes.xml"))
doc = Nokogiri::XML(f)
f.close

doc.css("Intervencoes").each do |node|
    children = node.children

    # Some data needs to be converted
    day = Date.parse(children.css('Data').inner_text)
    equip = (children.css('Nid').inner_text).to_i
    hours = (children.css('HorActual').inner_text).to_i
    preven = (children.css('Manutencao').inner_text == 1 ? true : false)
    repair = (children.css('Reparacao').inner_text == 1 ? true : false)
    parts = (children.css('Material').inner_text).to_i
    labor = (children.css('MaObra').inner_text).to_i

    Intervention.create(
      :day => day,
      :equipment_id => equip,
      :eq_hours => hours,
      :preventive => preven,
      :repair => repair,
      :description => children.css('Descricao').inner_text,
      :changed_parts => children.css('Pecas').inner_text,
      :parts_cost => parts,
      :labor_cost => labor
    )

end

p "Created #{Intervention.count} interventions."

