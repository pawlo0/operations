# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Rather start by cleaning the database
case Rails.env
when "development"
  Equipment.destroy_all
  Intervention.destroy_all
  Maintask.destroy_all
  Plant.destroy_all
  InterventionType.destroy_all
  
  Plant.create([{id: 1, name: 'Maia'},{id: 2, name: 'V.F.Xira'}])
  p "Created #{Plant.count} plants."
  
  InterventionType.create([
    {id: 1, name: 'Reparação'},
    {id: 2, name: 'Manutenção Preventiva'},
    {id: 3, name: 'Registo de horas'}])
  p "Created #{InterventionType.count} Intervention types."
  
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
      :id => (children.css("NIdentifica").inner_text).to_i,
      :num_id => children.css("NIdentifica").inner_text,
      :name => (children.css("Equipamento").inner_text).mb_chars.capitalize,
      :manufacturer => children.css("Marca").inner_text,
      :model => children.css("Modelo").inner_text,
      :serial => children.css("NSerie").inner_text,
      :manuf_date => Date.new(manuf,1,1),
      :buy_date => Date.new(purchase,1,1),
      :function => children.css("Funcao").inner_text,
      :obs => children.css("Obs").inner_text,
      :maintenance_contact => children.css("Contacto").inner_text,
      :plant_id => 1
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
      parts = (children.css('Material').inner_text).to_i
      labor = (children.css('MaObra').inner_text).to_i
      preven = (children.css('Manutencao').inner_text == 1 ? true : false)
      repair = (children.css('Reparacao').inner_text == 1 ? true : false)
      type = (preven == true) ? 2 : 1
  
      Intervention.create(
        :day => day,
        :equipment_id => equip,
        :eq_hours => hours,
        :description => children.css('Descricao').inner_text,
        :changed_parts => children.css('Pecas').inner_text,
        :parts_cost => parts,
        :labor_cost => labor,
        :intervention_type_id => type
      )
  
  end
  
  p "Created #{Intervention.count} interventions."
  
  [9, 10, 11, 12, 59, 69].each do |f|
  Maintask.create!([{
      equipment_id: f,
      task: "Lubrificar. Verificar correia e parafusos.",
      period: 250,
      unit: "Horas"
  },
  {
      equipment_id: f,
      task: "Inverter rotação do motor.",
      period: 500,
      unit: "Horas"
  },
  {
      equipment_id: f,
      task: "Efectuar manutenção total à parte quente.",
      period: 1000,
      unit: "Horas"
  },
  {
      equipment_id: f,
      task: "Efectuar manutenção total à parte fria.",
      period: 2000,
      unit: "Horas"  
  }])
  end
  
  p "Created #{Maintask.count} maintenance tasks."

when "production"
  Equipment.destroy_all
  Intervention.destroy_all
  Maintask.destroy_all
  InterventionType.destroy_all
  Plant.destroy_all
  User.destroy_all
  
  Plant.create([{id: 1, name: 'Maia'},{id: 2, name: 'V.F.Xira'}])
  p "Created #{Plant.count} plants."
  
  InterventionType.create([
    {id: 1, name: 'Reparação'},
    {id: 2, name: 'Manutenção Preventiva'},
    {id: 3, name: 'Registo de horas'}])
  p "Created #{InterventionType.count} Intervention types."
  
  user = User.new.tap do |u|
    u.username = 'porepxs1'
    u.password = '1111'
    u.password_confirmation = '1111'
    u.role = 'administrador'
    u.plant_id = 1
    u.save!
  end
  p "Created #{User.count} users."
  
  
end