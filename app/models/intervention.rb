class Intervention < ActiveRecord::Base
  belongs_to :equipment
  
  validates_presence_of :equipment_id, message: "A intervenção tem de estar associada a um equipamento."
  validates_presence_of :description, message: "Tem de escrever uma descrição."
  validates_presence_of :day, message: "Tem de escrever uma data."
  
  def previous
    Intervention.where('equipment_id == ?', self.equipment_id).where('day <?', self.day).sort_by(&:day).last
   
  end

  def next
    Intervention.where('equipment_id == ?', self.equipment_id).where('day > ?', self.day).sort_by(&:day).first
  end

end

