require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper

search_form_html = `curl "http://activeplaces.com/FindNearest/FindNearest_LowGraphic.asp"`
create_file_with_metadata(SEARCH_FORM_HTML_FILE, search_form_html)