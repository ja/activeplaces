class SplitPostcodesFromAddress < ActiveRecord::Migration
  
  def self.up
    Site.find(:all).each_with_index do |site, index|
      p index if (index % 100) == 0 # basic progress indicator

      raise "Whoah, where's the column!?" unless site.address.scan(/,/).length == 1
      # next unless site.address.scan(/,/).length == 1

      address, postcode = site.address.split(',')
      address = 'UNKNOWN' if address.blank?
      postcode = 'UNKNOWN' if postcode.blank?

      site.update_attributes!(:address => address.strip, :postcode => postcode.strip)
    end
  end

  def self.down
    Site.find(:all).each_with_index do |site, index|
      p index if (index % 100) == 0 # basic progress indicator
      
      address_and_postcode = [site.address, site.postcode].join(', ')
      
      site.update_attributes!(:address => address_and_postcode)
    end
  end
  
end