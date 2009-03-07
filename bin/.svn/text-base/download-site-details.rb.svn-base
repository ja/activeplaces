require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

facility_types = FacilityType.find(:all).inject({}) { |hash, facility_type| hash[facility_type.id] = facility_type.filename_friendly_name; hash }

site_id = '1004525' # hartsdown
site_id = '1004549' # ramsgate

site_overview_html_file = File.join(SITE_DETAILS_DIRECTORY, "site-#{site_id}.html")
puts "#{Time.now}. Getting site: #{site_id} (overview)"
site_overview_html = curl("http://activeplaces.com/SiteInfo/moreInfo_lowgraphic.asp?SiteId=#{site_id}")
create_file_with_metadata(site_overview_html_file, site_overview_html)
# site_overview_html = File.read(site_overview_html_file)

doc = Hpricot(site_overview_html)

(doc/'div.tabArea a').each do |link_to_facilities|
  url = link_to_facilities.attributes['href']
  if url =~ /^FacilityType/
    url = "http://activeplaces.com/SiteInfo/#{url}"
  end
  facility_type_id = Integer(url[/FacilityTypeId=(\d+)/, 1])
  facility_type = facility_types[facility_type_id]
  raise "Facility type with Id: #{facility_type_id} was not found" unless facility_type
  filename = File.join(SITE_DETAILS_DIRECTORY, "site-#{site_id}-#{facility_type}.html")
  puts "#{Time.now}. Getting site: #{site_id} (#{facility_type})"
  html = curl(url)
  create_file_with_metadata(filename, html)
end