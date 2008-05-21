# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'example', :action => 'index'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
