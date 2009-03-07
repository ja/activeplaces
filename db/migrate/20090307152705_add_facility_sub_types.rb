class AddFacilitySubTypes < ActiveRecord::Migration
  def self.up
    create_table :facility_sub_types do |t|
      t.column :name, :string
      t.column :facility_type_id, :integer
    end
    
    add_column :facilities, :facility_sub_type_id, :integer
  end

  def self.down
    drop_table :facility_sub_types
    remove_column :facilities, :facility_sub_type_id
  end
end
