require 'hpricot'

module ActivePlacesHelper
  
  USER_AGENT = 'http://chrisroos.co.uk (chris@seagul.co.uk)'
  ACTIVE_PLACES_COOKIE_FILE = File.join(Rails.root, 'tmp', 'activeplaces.cookie')
  
  SEARCH_FORM_HTML_FILE     = File.join(Rails.root, 'data', 'search-form.html')
  SEARCH_RESULTS_DIRECTORY  = File.join(Rails.root, 'data', 'search-results')
  SITE_DETAILS_DIRECTORY    = File.join(Rails.root, 'data', 'site-details')
  
  def curl(url)
    unless File.exists?(ACTIVE_PLACES_COOKIE_FILE) # Get the cookie if we don't have it yet
      `curl "http://activeplaces.com/Index_lowgraphic.asp" -c"#{ACTIVE_PLACES_COOKIE_FILE}" -A"#{USER_AGENT}" -s`
    end
# puts url
    `curl "#{url}" -b"#{ACTIVE_PLACES_COOKIE_FILE}" -A"#{USER_AGENT}" -s`
  end
  
  def create_file_with_metadata(filename, data)
    datetime = Time.now.strftime("%Y%d%m%H%M%S")
    File.open(filename, 'w') { |f| f.puts(data) }
    File.open("#{filename}.updated_at", 'w') { |f| f.puts(datetime) }
  end
  
end