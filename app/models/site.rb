class Site < ActiveRecord::Base
  validates_presence_of :name, :telephone, :address, :ward_id
  has_and_belongs_to_many :facility_types
end
