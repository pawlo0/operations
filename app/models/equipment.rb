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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*column_names)
      product.save!
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
