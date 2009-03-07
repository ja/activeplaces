class AddLatitudeAndLongitudeToSites < ActiveRecord::Migration
  
  def self.up
    add_column :sites, :latitude, :decimal, :precision => 20, :scale => 17
    add_column :sites, :longitude, :decimal, :precision => 20, :scale => 17
  end

  def self.down
    remove_column :sites, :longitude
    remove_column :sites, :latitude
  end
  
end