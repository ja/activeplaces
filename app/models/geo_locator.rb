class GeoLocator
  def self.find(query)
    Geokit::Geocoders::MultiGeocoder.geocode(query + ", UK")
  end

  def self.default
    DummyLocation.new(51.518250335096376, -0.12273788452148438)
  end
  
  class DummyLocation
    attr_reader :lat, :lng
    def initialize(latitude, longitude)
      @lat, @lng = latitude, longitude
    end
  end
end