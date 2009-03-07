ActionController::Routing::Routes.draw do |map|
  map.resources :sites, :member => ["summary"], :collection => [:near]
  map.root :controller => "sites"
end
