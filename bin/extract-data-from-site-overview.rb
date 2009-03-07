require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

html = File.read(File.join(SITE_DETAILS_DIRECTORY, 'site-1004549.html'))
doc = Hpricot(html)

site_id = html[/Site ID: (\d+)/, 1]
date_last_checked = html[/Date last checked: (.*)/, 1].gsub(/&nbsp;/, '').strip
site_id_and_updated_date = {'site_id' => site_id, 'date_last_checked' => date_last_checked}
p site_id_and_updated_date

# Address
address = {'address' => (doc/'table:nth(0) tr:nth(1) td:nth(0) table:nth(0) tr td:nth(0) span.site').inner_text}
address = {'address' => (doc/'table:nth(0) span.site').inner_text}
p address
exit
# Contact details
contact_details = (doc/'table:nth(0) tr:nth(1) td:nth(0) table:nth(0) tr td:nth(2) span.site').inject({}) do |hash, contact_data|
  contact_method = contact_data.previous_sibling.inner_text.sub(/:/, '') # It'd be nice to be able to limit this to anchor tags but maybe it's not important
  hash[contact_method] = contact_data.inner_text
  hash
end
p contact_details

# Amenities
# This is really really really bad
# The span.site contains anchors that represent amenity types, followed by text that is the value of that type.
# There doesn't appear to be any nice way (in hpricot) to extract this data so...
# I get the types from the inner_text of the anchors
# I get all the inner text combined (which contains the types and values)
# I then reverse through the types looking for them in the combined text and use the match from the end of the type to the end of the string as the value
# I remove that type to the end of string and continue
amenity_data = (doc/'table:nth(0) tr:nth(1) td:nth(0) table:nth(0) tr td:nth(4) span.site').inner_text
amenity_types = (doc/'table:nth(0) tr:nth(1) td:nth(0) table:nth(0) tr td:nth(4) span.site a').collect do |amenity_type|
  amenity_type.inner_text.sub(/:/, '').strip
end

h = {}
amenity_types.reverse.each do |amenity_type|
  amenity = amenity_data[/#{amenity_type}(.*)/, 1].sub(/^:/, '').strip
  amenity_data.sub!(/#{amenity_type}.*/, '')
  h[amenity_type] = amenity
end
p h

# Owner and management type
owner_and_management_type = (doc/'table:nth(0) tr:nth(1) td:nth(0) table:nth(1) span.site a').inject({}) do |hash, site_info_label|
  hash[site_info_label.inner_text.sub(/:/, '').strip] = site_info_label.next_node.inner_text
  hash
end
p owner_and_management_type

# Additional details
additional_details = (doc/'table:nth(0) tr:nth(1) td:nth(1) div:nth(1) span.site a').inject({}) do |hash, additional_detail_label|
  label = additional_detail_label.inner_text.sub(/:/, '')
  value = additional_detail_label.parent.next_node.inner_text.strip.squeeze(' ')
  hash[label] = value
  hash
end
p additional_details

raise "site_id_and_updated_date don't match" unless {"site_id"=>"1004549", "date_last_checked"=>"28 March 2008"} == site_id_and_updated_date
raise "address doesn't match" unless {"address"=>"Newington Road,Ramsgate-CT11 0QX"} == address
raise "contact details don't match" unless {"Tel"=>"01843 593754", "Website"=>"http://www.leisureforce.co.uk"} == contact_details
raise "amenities don't match" unless {"Car Park"=>"Yes, 100 spaces", "Disability Standard"=>"Parking, Finding and reaching the entrance, Reception area, Doorways, Changing facilities, Activity areas, Toilets, Social areas, Spectator areas, Emergency exits", "Disability Access"=>"Yes"} == h
raise "owner_and_management_type don't match" unless {"Management Type"=>"Trust", "Owner Type"=>"Local Authority"} == owner_and_management_type
raise "additional_details don't match" unless {"Region"=>"South East Region", "Ward"=>"Central Harbour Ward", "Local Authority"=>"Thanet District"} == additional_details