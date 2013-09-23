LoadmasterLogger::Application.routes.draw do
  
  # You can have the root of your site routed with "root"
  root :to => 'home#index'

  get "users/index"
  
  get "trips/search" => 'trips#search'
  delete "/trips/destroy_multiple" => 'trips#destroy_multiple'
  resources :trips
  
  devise_for :users
  resources :users
  
  resources :homes
  
  get "invoices/search" => 'invoices#search'
  get "invoices/render_pdf" => 'invoices#render_pdf'
  get "invoices/render_pdfs" =>  "invoices#render_pdfs"
  resources :invoices
  
  get "mobile_devices/search" => 'mobile_devices#search'
  resources :mobile_devices

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
