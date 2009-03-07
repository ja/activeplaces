require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

File.open('site-coordinates.csv', 'w') do |file|
  Site.find(:all, :conditions => 'latitude is not null').each do |site|
    file.puts [site.id, site.latitude, site.longitude].join(',')
  end
end