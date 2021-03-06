class FacilityType < ActiveRecord::Base
  
  validates_presence_of :name
  has_many :facilities
  has_many :facility_sub_types
  
  def filename_friendly_name
    name.downcase.gsub(/ /, '-')
  end
  
end
