class Intervention < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :intervention_type
  
  validates_presence_of :equipment_id, message: "A intervenção tem de estar associada a um equipamento."
  validates_presence_of :description, message: "Tem de escrever uma descrição."
  validates_presence_of :day, message: "Tem de escrever uma data."
  validates_presence_of :intervention_type_id, message: "Tem de escolher um tipo de intervenção."
  
  scope :without_hour_registers, -> { where("intervention_type_id <> ?", InterventionType.where("name LIKE ?", "%regist%ho%").first.id) }
  
  def previous
    Intervention.where('equipment_id == ?', self.equipment_id).where('day <?', self.day).sort_by(&:day).last
   
  end

  def next
    Intervention.where('equipment_id == ?', self.equipment_id).where('day > ?', self.day).sort_by(&:day).first
  end
  
  def self.hour_register(equipment, hours)
    intervention = new
    intervention.attributes = {equipment_id: equipment, eq_hours: hours, description: "Registo de horas", day: Date.today, intervention_type_id: InterventionType.where("name LIKE ?", "%regist%ho%").first.id}
    intervention.save!
  end
  
end

