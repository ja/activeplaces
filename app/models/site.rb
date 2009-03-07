class Site < ActiveRecord::Base
  validates_presence_of :name, :telephone, :address, :ward_id, :postcode
  has_many :facilities
end
