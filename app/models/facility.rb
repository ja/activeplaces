class Facility < ActiveRecord::Base
  belongs_to :facility_type
  belongs_to :site
end