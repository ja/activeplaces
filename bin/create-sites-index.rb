# CREATES public/index.html which serves as a directory of all sites

require File.join(File.dirname(__FILE__), '..', 'config', 'environment')
require File.join(File.dirname(__FILE__), 'active_places_helper')
include ActivePlacesHelper
require 'haml'

sites = Site.find(:all)
template = DATA.read

def link_to_site_attrs(site)
  {:href => "#{File.join(Rails.root, 'public', 'site-details', "site-#{site.id}.html")}"}
end

def link_to_site_facility_attrs(site, facility)
  {
    :href => "#{File.join(Rails.root, 'public', 'site-details', "site-#{site.id}-#{facility.filename_friendly_name}.html")}",
    :class => facility.filename_friendly_name
  }
end

engine = Haml::Engine.new(template)
File.open(File.join(Rails.root, 'public', 'index.html'), 'w') do |file|
  file.puts(engine.render(Object.new, :sites => sites))
end

__END__
!!! Strict
%html{:xmlns => "http://www.w3.org/1999/xhtml", "xml:lang" => "en"}
  %head
    %meta{"http-equiv" => "content-type", :content => "text/html; charset=utf-8"}
    %title Sites
  %body
    %h1 Sites
    %table.sites
      %thead
        %tr
          %th Id
          %th Name
          %th Telephone
          %th Address
          %th Ward Id
      %tbody
        - sites.each do |site|
          %tr.site
            %td.id= h(site.id)
            %td.name
              %p
                %a{link_to_site_attrs(site)}= h(site.name)
              %p.facilities
                - site.facility_types.each do |facility_type|
                  %a{link_to_site_facility_attrs(site, facility_type)}= h(facility_type.name)
            %td.telephone= h(site.telephone)
            %td.address= h(site.address)
            %td.ward_id= h(site.ward_id)