class Equipment < ActiveRecord::Base
  has_many :interventions

  validates_uniqueness_of :id, message: "Já existe um equipamento com esse número!"
  validates_presence_of :id, message: "O equipamento tem mesmo de ter um número."

end
