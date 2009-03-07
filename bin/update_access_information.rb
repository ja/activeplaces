#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require File.join(File.dirname(__FILE__), *%w[.. config environment.rb])

if ARGV.empty?
  puts "Usage: update_access_information <directory of files> [<number to start at>]"
  exit(-1)
end

$types = {} # cache to avoid loading FacilityTypes multiple times.

files = Dir[File.join(ARGV[0], "site-*-*.html")]
files = files.select { |f| File.basename(f) > "site-#{ARGV[1]}" } if ARGV[1]

puts "Parsing #{files.length} files"

files.each do |file|
  id, type = File.basename(file).scan(/site-(\d+)-(.+).html/).first

  html = File.read(file)
  doc = Hpricot(html)
  
  facility_id = (doc/".facilityID").first.innerHTML.scan(/\d+$/)[0]
  access = ((doc/"#siteInformation a").select { |e| e.innerHTML =~ /Access Policy/ }.first.following_siblings/".site").first.innerHTML
  sub_type = ((doc/"#siteInformation a").select { |e| e.innerHTML =~ /Sub Type/ }.first.following_siblings/".site").first.innerHTML rescue nil
  is_public = access == "Pay and Play"
  
  facility_type = $types[type] ||= FacilityType.find_by_name(type.titleize)
  facility_sub_type = sub_type ? facility_type.facility_sub_types.find_or_create_by_name(sub_type.titleize) : nil
  
  site = Site.find(id)
  facility = site.facilities.build(:facility_type => facility_type, :public => is_public, :facility_sub_type => facility_sub_type) { |f| f.id = facility_id }
  facility.save!

  puts "#{id} [#{facility_type.name}] - #{access}"
end