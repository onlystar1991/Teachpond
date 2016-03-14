Rails.application.routes.draw do

  # Devise
  devise_for :users, controllers: { registrations: "registrations" }

  # Root
  root 'static_pages#home'

  # Statuc pages
  get '/about' => "static_pages#about"
  get '/contact' => "static_pages#contact"
  get '/how-it-works' => "static_pages#how_it_works"
  get '/add-new' => "static_pages#add_new"
  get '/browse' => "browse#index"
  get '/browse/requests' => "browse#requests"
  get '/locations' => "browse#index"
  get '/location/:location' => "locations#index"
  get '/posts' => "browse#index"
  get '/requests' => "browse#requests"
  get '/locations/:location_id/requests' => "browse#requests"
  get '/categories/:category_id/requests' => "browse#requests"
  # Users
  resources :users do
    resources :profiles, only: [:edit, :update]
  end

  # Categories
  resources :categories, only: [:show] do
    resources :posts, only: [:index]
    resources :requests, only: [:index]
    resources :browse, only: [:index, :requests]
  end

  resources :locations, only: [:show] do
    resources :posts, only: [:index]
    resources :requests, only: [:index]
    resources :browse, only: [:index, :requests]
  end
  
  # Posts
  resources :posts

  # Requests
  resources :requests



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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
