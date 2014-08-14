class Maintask < ActiveRecord::Base
  belongs_to :equipment
  
  def previous
    Maintask.where('equipment_id == ?', self.equipment_id).where('period <?', self.period).sort_by(&:period).last
   
  end

  def next
    Maintask.where('equipment_id == ?', self.equipment_id).where('period > ?', self.period).sort_by(&:period).first
  end
  
end
