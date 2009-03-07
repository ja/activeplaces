class Site < ActiveRecord::Base
  acts_as_mappable :lat_column_name => :latitude, 
                   :lng_column_name => :longitude

  has_many :facilities  
  validates_presence_of :name, :telephone, :address, :ward_id, :postcode

  def title
    name.titleize
  end
  
  def closest_sites
    Site.find(:all,
      :include => "facilities", 
      :origin => [latitude, longitude], 
      :within => 25, 
      :order=>'distance asc',
      :limit => 5
    )
  end
  
  def distance_in_miles(d_latitude, d_longitude)
    Site.distance_in_miles(latitude, longitude, d_latitude, d_longitude)
  end
end
