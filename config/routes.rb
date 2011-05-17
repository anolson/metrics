Metrics::Application.routes.draw do

  resource :session, :only => [:new, :create, :destroy], :controller => :session 
  resource :users, :only => [:new, :create] 
  resources :rides, :only => [:index, :show]
      
  match "get_started" => 'users#new', :constraints => { :protocol => Rails.env.production? ? 'https' : 'http'}
  match "login" => 'session#new', :constraints => { :protocol => Rails.env.production? ? 'https' : 'http'}
  match "logout" => 'session#destroy'
  
  root :to => "rides#index"
  
end
