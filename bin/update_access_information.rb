#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require File.join(File.dirname(__FILE__), *%w[.. config environment.rb])

if ARGV.empty?
  puts "Usage: update_access_information <directory of files> [<number to start at>]"
  exit(-1)
end

files = Dir[File.join(ARGV[0], "site-*-*.html")]
files = files.select { |f| File.basename(f) > "site-#{ARGV[1]}" } if ARGV[1]

puts "Parsing #{files.length} files"

files.each do |file|
  id, type = File.basename(file).scan(/site-(\d+)-(.+).html/).first

  html = File.read(file)
  doc = Hpricot(html)
  
  access = ((doc/"#siteInformation a").select { |e| e.innerHTML =~ /Access Policy/ }.first.following_siblings/".site").first.innerHTML
  is_public = access == "Pay and Play"
   
  site = Site.find(id)
  site.facilities.kind(type.titleize).each { |f| f.update_attributes(:public => is_public) }

  puts "#{id} [#{type}] - #{access}"
end