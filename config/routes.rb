Metrics::Application.routes.draw do

  resource :session, :only => [:new, :create, :destroy], :controller => :session 
  resource :users, :only => [:new, :create] 
  resources :rides, :only => [:index, :show]
      
  match "get_started" => 'users#new'
  match "login" => 'session#new'
  match "logout" => 'session#destroy'
  
  root :to => "rides#index"
  
end
