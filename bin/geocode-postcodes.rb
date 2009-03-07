require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper
require 'graticule'

geocoder = Graticule.service(:multimap).new('OA09030617838922551')

Site.find(:all, :conditions => 'latitude is null').each_with_index do |site, index|
  # p index if (index % 100) == 0 # crappy progress indicator
  
  begin
    location = geocoder.locate(site.postcode)
    lat, lng = location.coordinates
    site.update_attributes!(:latitude => lat, :longitude => lng)
  rescue Graticule::Error => e
    puts "*** ERROR"
  rescue Exception => e
    puts "*** PROPER ERROR"
  end
  
  p [index, site.postcode, lat, lng]
  # sleep 0.5
end