class LoadFacilitiesDataAgain < ActiveRecord::Migration
  def self.up
    execute "truncate table facilities"
    File.open(File.join(Rails.root, 'bin', 'facilities.csv')) do |file|
      file.each do |line|
        id, site_id, facility_type_id, facility_sub_type_id, is_public = line.chomp.split(',')
        insert "INSERT INTO facilities(id, site_id, facility_type_id, facility_sub_type_id, public) VALUES (#{id}, #{site_id}, #{facility_type_id}, #{facility_sub_type_id.blank? ? 'NULL' : facility_sub_type_id}, #{is_public})"
      end
    end

    execute "truncate table facility_sub_types"
    File.open(File.join(Rails.root, 'bin', 'facility-sub-types.csv')) do |file|
      file.each do |line|
        id, name, facility_type_id = line.chomp.split(',')
        insert "INSERT INTO facility_sub_types(id, name, facility_type_id) VALUES (#{id}, '#{name}', #{facility_type_id})"
      end
    end

    execute "truncate table facility_types"
    File.open(File.join(Rails.root, 'bin', 'facility-types.csv')) do |file|
      file.each do |line|
        id, name = line.chomp.split(',')
        insert "INSERT INTO facility_types(id, name) VALUES (#{id}, '#{name}')"
      end
    end
  end

  def self.down
  end
end
