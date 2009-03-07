class SitesController < ApplicationController
  include Geokit::Geocoders

  def index
    @origin = params['origin'] || 'N1 7NB'
    origin_query =  @origin + "London, UK"
    @location = MultiGeocoder.geocode(origin_query)
    @sites = Site.find(:all, :include => "facilities", :origin => origin_query)
  end
  
end