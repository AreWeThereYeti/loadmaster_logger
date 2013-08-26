LoadmasterLogger::Application.routes.draw do
  resources :invoices

  resources :mobile_devices

  get "users/index"
  devise_for :users, :skip => [:registrations] 
    
  resources :trips
  resources :homes
  resources :users
  resources :user

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'
  
  namespace :admin do
  	get '/' => 'users#index'
  	get '/new_mobile' => 'users#new_mobile'
  	post '/form_mobile' => 'users#create_mobile'
  	resources :users
  end
  
  # api routes
  namespace :api, defaults: {format: 'json'} do
    # /api
    namespace :v1 do
      resources :trips
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
