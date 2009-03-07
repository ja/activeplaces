require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

File.open('facilities.csv', 'w') do |file|
  Facility.all.each do |facility|
    file.puts [facility.id, facility.site_id, facility.facility_type_id, facility.public?].join(',')
  end
end