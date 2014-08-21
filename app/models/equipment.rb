class Equipment < ActiveRecord::Base
  
  belongs_to :plant
  
  has_many :interventions
  has_many :maintasks

  validates :num_id, 
    presence: {message: "O equipamento tem mesmo de ter um número único."}, 
    uniqueness: { scope: :plant_id, message: "Já existe um equipamento com esse número!" }
  
  validates :name, presence: {message: "O equipamento tem de ter um nome."}
  
  def previous(plant, filter)
    if filter == 'true'
      Equipment.where(plant_id: plant).where('equipment.num_id < ?', self.num_id).last
    else
      Equipment.where('equipment.num_id < ?', self.num_id).last
    end
  end

  def next(plant, filter)
    if filter == 'true'
      Equipment.where(plant_id: plant).where('equipment.num_id > ?', self.num_id).first
    else
      Equipment.where('equipment.num_id > ?', self.num_id).first
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
  

end
