class GeoLocator
  def self.find(query)
    Geokit::Geocoders::MultiGeocoder.geocode(query + ", UK")
  end

  def self.default
    DummyLocation.new(51.51497,-0.14373)
  end
  
  class DummyLocation
    attr_reader :lat, :lng
    def initialize(latitude, longitude)
      @lat, @lng = latitude, longitude
    end
  end
end