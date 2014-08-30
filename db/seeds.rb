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

User.create([{username: 'porepxs1', password: '1111', password_confirmation: '1111', role: 'administrador', plant_id: 1}])

InterventionType.create(([{ name: 'Reparacao' }, { name: 'Manutenção Preventiva' }, { name: 'Registo de horas' }])

Plant.create([{ id: 1, name: 'Maia' }])