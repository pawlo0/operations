class Plant < ActiveRecord::Base
  
  has_many :users
  has_many :equipment, dependent: :destroy
  
  has_many :interventions, through: :equipment
  has_many :maintasks, through: :equipment
  
end
