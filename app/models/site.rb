class Site < ActiveRecord::Base
  acts_as_mappable

  has_many :facilities  
  validates_presence_of :name, :telephone, :address, :ward_id, :postcode
end
