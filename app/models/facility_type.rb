class FacilityType < ActiveRecord::Base
  
  validates_presence_of :name
  has_many :facilities
  
  def filename_friendly_name
    name.downcase.gsub(/ /, '-')
  end
  
end
