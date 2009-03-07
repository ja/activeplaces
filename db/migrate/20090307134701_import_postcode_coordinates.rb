class ImportPostcodeCoordinates < ActiveRecord::Migration
  
  def self.up
    File.open(File.join(Rails.root, 'bin', 'site-coordinates.csv')) do |file|
      file.each do |line|
        id, lat, lng = line.chomp.split(',')
        update "UPDATE sites SET latitude = #{lat}, longitude = #{lng} WHERE id = #{id}"
      end
    end
  end

  def self.down
    # Intentionally blank
  end
  
end