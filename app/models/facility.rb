class Facility < ActiveRecord::Base
  belongs_to :facility_type
  belongs_to :facility_sub_type
  belongs_to :site
  
  named_scope :kind, lambda { |type_name| { :joins => :facility_type, :conditions => ["facility_types.name = ?", type_name] } }
  
  named_scope :public, { :conditions => 'public = true' }
  named_scope :private, { :conditions => 'public <> true' }
end