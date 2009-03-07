class Site < ActiveRecord::Base
  acts_as_mappable :lat_column_name => :latitude, 
                   :lng_column_name => :longitude

  has_many :facilities  
  validates_presence_of :name, :telephone, :address, :ward_id, :postcode

  def title
    name.titleize
  end
end
