class Maintask < ActiveRecord::Base
  belongs_to :equipment, dependent: :destroy
  
  def previous
    Maintask.where('equipment_id == ?', self.equipment_id).where('period <?', self.period).sort_by(&:period).last
  end

  def next
    Maintask.where('equipment_id == ?', self.equipment_id).where('period > ?', self.period).sort_by(&:period).first
  end
  
  def find_more_freq_tasks(period)
    Maintask.where('equipment_id == ?', self.equipment_id).each do |t|
      descrip = []
      descrip << t.task if t.period < period && t.period % period == 0
    end
  end
  
    def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |element|
        csv << element.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.with_equipments
    joins(:equipment_id).merge( Equipment.id )
  end
  
end
