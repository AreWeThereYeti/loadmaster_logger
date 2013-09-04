LoadmasterLogger::Application.routes.draw do
  
  # You can have the root of your site routed with "root"
  root :to => 'home#index'
  
  resources :mobile_devices

  get "users/index"
  
  get "trips/search" => 'trips#search'
  resources :trips
  
  devise_for :users
  resources :users
  
  resources :homes
  
  get "invoices/search" => 'invoices#search'
  resources :invoices

  namespace :admin do
  	get '/' => 'users#index'
  	get '/new_mobile' => 'users#new_mobile'
  	post '/form_mobile' => 'users#create_mobile'
  	get '/users/search' => 'users#search'
  	resources :users
  end
  
  # api routes
  namespace :api, defaults: {format: 'json'} do
    # /api
    namespace :v1 do
      resources :trips
    end
  end

end
