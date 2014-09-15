class Intervention < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :intervention_type
  belongs_to :maintask
  delegate :plant, :to => :equipment
  
  validates_presence_of :equipment_id, message: "A intervenção tem de estar associada a um equipamento."
  validates_presence_of :description, message: "Tem de escrever uma descrição."
  validates_presence_of :day, message: "Tem de escrever uma data."
  validates_presence_of :intervention_type_id, message: "Tem de escolher um tipo de intervenção."
  
  scope :without_hour_registers, -> { where("intervention_type_id <> ?", InterventionType.where("name LIKE ?", "%regist%ho%").first) }
  
  def previous
    Intervention.where(equipment_id: self.equipment_id).where('day <= ?', self.day).where('id < ?', self.id).sort_by(&:day).last
   
  end

  def next
    Intervention.where(equipment_id: self.equipment_id).where('day >= ?', self.day).where('id > ?', self.id).sort_by(&:day).first
  end
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)    
    header = spreadsheet.row(1)             
    (2..spreadsheet.last_row).each do |i|   
      row = Hash[[header, spreadsheet.row(i)].transpose]    # makes hash, sets the key from header array and the value from each cell's content (also an array)
      row = row.reject{|k,v| v.nil?}        # removes keys with nil values. Otherwise if updating an element, nil keys would erase existing info 
      intervention = where(id: row["id"]).first || new    # if exists, sets equipment varible as existing record, otherwise creates new intervention
      intervention.attributes = row
      intervention.save!
    end
  end
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end  
end

