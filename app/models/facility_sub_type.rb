class FacilitySubType < ActiveRecord::Base
  belongs_to :facility_type
  has_many :facilities
end