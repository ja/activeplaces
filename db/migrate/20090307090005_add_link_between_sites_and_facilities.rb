class AddLinkBetweenSitesAndFacilities < ActiveRecord::Migration
  
  def self.up
    create_table :facility_types_sites, :force => true, :id => false do |t|
      t.integer :site_id, :facility_type_id
    end
  end

  def self.down
    drop_table :facility_types_sites
  end
  
end