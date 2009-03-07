require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

search_form_html = File.read(SEARCH_FORM_HTML_FILE)

require 'hpricot'

doc = Hpricot(search_form_html)
(doc/'#lstFacType option').each do |facility_type_option|
  facility_type_id = facility_type_option['value']
  next if facility_type_id =~ /all/i
  
  facility_type_id   = Integer(facility_type_id)
  facility_type_name = facility_type_option.inner_text.gsub(/\t|\r|\n/, '').strip
  
  facility_type = FacilityType.new(:name => facility_type_name) { |ft| ft.id = facility_type_id }
  facility_type.save!
end