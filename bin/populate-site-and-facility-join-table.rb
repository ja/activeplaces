require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

facility_types = FacilityType.find(:all).inject({}) { |hash, facility_type| hash[facility_type.id] = facility_type; hash }

Site.find(:all).each_with_index do |site, index|
  p index if (index % 100) == 0

  site_id = site.id
  
  site_overview_html_file = File.join(SITE_DETAILS_DIRECTORY, "site-#{site_id}.html")
  next unless File.exists?(site_overview_html_file) # DEAL WITH THE NEWLY CREATED SITES THAT WE DON'T HAVE DATA FOR
  site_overview_html = File.read(site_overview_html_file)

  doc = Hpricot(site_overview_html)

  (doc/'div.tabArea a').each do |link_to_facilities|
    url = link_to_facilities.attributes['href']
    facility_type_id = Integer(url[/FacilityTypeId=(\d+)/, 1])
    facility_type = facility_types[facility_type_id]
    raise "Facility type with Id: #{facility_type_id} was not found" unless facility_type
    filename = File.join(SITE_DETAILS_DIRECTORY, "site-#{site_id}-#{facility_type}.html")
    site.facility_types << facility_type
  end
  
end