class SitesController < ApplicationController
  def index
    @search = params['search'] || 'London'
    @public = params['public'] == 'true' || false
    @origin = GeoLocator.find(@search + ", UK")

    if @origin.lat == nil
      @origin = GeoLocator.default
    end
    
    @sites = Site.find(:all, 
      :include => "facilities", 
      :origin => [@origin.lat, @origin.lng], 
      :within => 25, 
      :order=>'distance asc',
      :limit => 100
    )
    
    @sites.delete_if { |s| s.facilities.public.empty? } if params[:public]
  end
  
  def show
    @site = Site.find(params[:id])
  end
  
  def summary
    @site = Site.find(params[:id])
    render :partial => 'summary'
  end
  
  def near
    @sites = Site.find_near(params[:latitude].to_f, params[:longitude].to_f)
    respond_to do |wants|
      wants.js { render :json => @sites }
    end
  end
  
end