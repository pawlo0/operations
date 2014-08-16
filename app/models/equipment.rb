class Equipment < ActiveRecord::Base
  has_many :interventions
  has_many :maintasks

  validates_uniqueness_of :id, message: "Já existe um equipamento com esse número!"
  validates_presence_of :id, message: "O equipamento tem mesmo de ter um número."

  def previous
    Equipment.where('equipment.num_id < ?', self.num_id).last
  end

  def next
    Equipment.where('equipment.num_id > ?', self.num_id).first
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
