class Equipment < ActiveRecord::Base
  has_many :interventions
end
