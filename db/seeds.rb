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
Maintask.destroy_all
InterventionType.destroy_all
Plant.destroy_all
User.destroy_all

InterventionType.create([{ name: 'Reparacao' }, { name: 'Manutenção Preventiva' }, { name: 'Registo de horas' }])
p "Created #{InterventionType.count} interventions types."

Plant.create([{ id: '1', name: 'Maia' }])
p "Created #{Plant.count} plants."

user = User.new.tap do |u|
  u.username = 'porepxs1'
  u.password = '1111'
  u.password_confirmation = '1111'
  u.role = 'administrador'
  u.plant_id = Plant.first.id
  u.save!
end
p "Created #{User.count} users."