class ImportFacilitiesData < ActiveRecord::Migration
  def self.up
    execute "truncate table facilities"
    File.open(File.join(Rails.root, 'bin', 'facilities.csv')) do |file|
      file.each do |line|
        id, site_id, facility_type_id, is_public = line.chomp.split(',')
        insert "INSERT INTO facilities(id, site_id, facility_type_id, public) VALUES (#{id}, #{site_id}, #{facility_type_id}, #{is_public})"
      end
    end
  end

  def self.down
  end
end
