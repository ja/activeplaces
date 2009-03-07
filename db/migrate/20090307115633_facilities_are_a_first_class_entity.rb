class FacilitiesAreAFirstClassEntity < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.column :site_id, :integer
      t.column :facility_type_id, :integer
      t.column :public, :boolean
    end
    
    execute(%{
      INSERT INTO facilities (site_id, facility_type_id) 
      SELECT * FROM facility_types_sites
    })
    
    drop_table :facility_types_sites
  end

  def self.down
    create_table "facility_types_sites", :id => false, :force => true do |t|
      t.integer "site_id"
      t.integer "facility_type_id"
    end

    execute(%{
      INSERT INTO facility_types_sites (site_id, facility_type_id) 
      SELECT * FROM facilities
    })
    
    drop_table :facilities    
  end
end
