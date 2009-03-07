class SitesController < ApplicationController
  def index
    @search = params['search'] || 'London'
    @origin = GeoLocator.find(@search + ", UK")

    if @origin.lat == nil
      @origin = GeoLocator.default
    end
    
    @sites = Site.find(:all, :include => "facilities", :origin => [@origin.lat, @origin.lng], :within => 5, :limit => 20)
  end
  
end