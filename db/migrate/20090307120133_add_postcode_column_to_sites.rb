class AddPostcodeColumnToSites < ActiveRecord::Migration
  
  def self.up
    add_column :sites, :postcode, :string
  end

  def self.down
    remove_column :sites, :postcode
  end
  
end