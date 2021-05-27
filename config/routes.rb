require 'sidekiq/web'

Rails.application.routes.draw do
  
  # get '/', to: 'system/static_pages#index'

  # namespace system
  namespace :system, path: '' do
    
    root to: 'static_pages#index'
    get '/', to: 'static_pages#index'

    resources :customers, only: [:index, :show] 
  end # namespace system

  # namespace Api::V1
  namespace :api do
    namespace :v1 do

    # Customers
      resource :customers, only: [:index, :show] do
        # Customers signup and login
        post '/signup', to: 'customers#create'
        post '/login', to: 'customers#login'
        post '/forgot_password', to: 'customers#forgot'
        post '/reset_password', to: 'customers#reset'
        get '/auto_login', to: 'customers#auto_login'

        # Customers show and edit
        get '/customer', to: 'customers#show'
        patch '/customer/edit', to: 'customers#update'

#         # Points movement
#         resource :points_movements, only: [:index] do
#           get '/', to: 'points_movement#index'
#         end
#         # Points movement
      end # customers
    end # v1
  end # api

# namespace :api do
#     namespace  :v1 do
      
#       resource :customers, only: [:index, :show] do
#         # Customers signup and login
#         post '/signup', to: 'customers#create'
#         post '/login', to: 'customers#login'
#         post '/forgot_password', to: 'customers#forgot'
#         post '/reset_password', to: 'customers#reset'
#         get '/auto_login', to: 'customers#auto_login'

#         # Customers show and edit
#         get '/customer', to: 'customers#show'
#         patch '/customer/edit', to: 'customers#update'

#         # Points movement
#         resource :points_movements, only: [:index] do
#           get '/', to: 'points_movement#index'
#         end
#         # Points movement
#       end
#       # customers

#           # Brands      
#       resource :brands, only: [:index, :show, :latest] do
#         get '/', to: 'brands#index'

#         # Categories
#         get '/:brand_id/categories', to: 'categories#index'

#         # Items
#         get '/:brand_id/categories/:category_id/items', to: 'items#index'
#         get '/:brand_id/categories/items/latest', to: 'items#latest'
#         get '/:brand_id/categories/:category_id/items/:item_id', to: 'items#show'
#       end
#       # Brands

#       # Settings
#       resource :settings do
#         get '/about_us', to: 'settings#about_us'
#         get '/contact_us', to: 'settings#contact_us'
#       end
#       # Settings

#       # Offers
#       resource :offers do
#         get '/', to: 'offers#index'
#         get '/:id', to: 'offers#show'
#       end
#       get '/offers_carosel', to: 'offers#offers_carosel'
#       # Offers

#       # Cities
#       resource :cities do
#         get '/', to: "cities#index"
#         # Branches
#         get '/branches', to: 'branches#index'
#         get '/:city_id/branches/:branch_id', to: 'branches#show'
#         # Branches
#       end
#       # Cities
      

#       # Notifications
#       get '/notifications', to: 'notifications#index'
#       get '/notifications/:id', to: 'notifications#show'
#       # Notifications
#     end
#   end
  
#   namespace :system do

#     root to: 'home#index'
#     devise_for :users
    
#     # Customers System Admin Page
#     resources :customers, only: [:index, :show] 
#     # do
#       # get '/', to: 'customers#index'
#       # get "/:customer_id", to: 'customers#show'
#     # end

#     #     # Brands      
#   #     resource :brands, only: [:index, :show, :latest] do
#   #       get '/', to: 'brands#index'

#   #       # Categories
#   #       get '/:brand_id/categories', to: 'categories#index'

#   #       # Items
#   #       get '/:brand_id/categories/:category_id/items', to: 'items#index'
#   #       get '/:brand_id/categories/items/latest', to: 'items#latest'
#   #       get '/:brand_id/categories/:category_id/items/:item_id', to: 'items#show'
#   #     end
#   #     # Brands

#   #     # Settings
#   #     resource :settings do
#   #       get '/about_us', to: 'settings#about_us'
#   #       get '/contact_us', to: 'settings#contact_us'
#   #     end
#   #     #Settings

#   #     # Offers
#   #     resource :offers do
#   #       get '/', to: 'offers#index'
#   #       get '/:id', to: 'offers#show'
#   #     end
#   #     get '/offers_carosel', to: 'offers#offers_carosel'
#   #     # Offers

      
#   #     resource :cities do
#   #       # Branches
#   #       get '/branches', to: 'branches#index'
#   #       get '/', to: "cities#index"
#   #       get '/:city_id/branches/:branch_id', to: 'branches#show'
#   #       # Branches
#   #     end
      

#   #     # Notifications
#   #     get '/notifications', to: 'notifications#index'
#   #     get '/notifications/:id', to: 'notifications#show'
#   #     # Notifications
        
#   #   end
#   # end

#   # # Brands      
#   # resource :brands do
#   #   get '/', to: 'brands#index'

#   #   # Categories
#   #   get '/:brand_id/categories', to: 'categories#index'

#   #   # Items
#   #   get '/:brand_id/categories/:category_id/items', to: 'items#index'
#   #   get '/:brand_id/categories/items/latest', to: 'items#latest'
#   #   get '/:brand_id/categories/:category_id/items/:item_id', to: 'items#show'
#   # end
#   # # Brands

#   # # Settings
#   # resource :settings do
#   #   get '/about_us', to: 'settings#about_us'
#   #   get '/contact_us', to: 'settings#contact_us'
#   # end
#   # #Settings

#   # # Offers
#   # resource :offers do
#   #   get '/', to: 'offers#index'
#   #   get '/:id', to: 'offers#show'
#   # end
#   # get '/offers_carosel', to: 'offers#offers_carosel'
#   # # Offers

  
#   # resources :cities do
#   #   get '/', to: "cities#index"
#   #   get '/:city_id/branches/:branch_id', to: 'branches#show'
    
#   #   # Branches
#   #   resource :branches do
#   #     get '/branches', to: 'branches#index'
#   #   end
#   #   # Branches
#   # end
  

#   # # Notifications
#   # get '/notifications', to: 'notifications#index'
#   # get '/notifications/:id', to: 'notifications#show'
#   # # Notifications
#   mount Sidekiq::Web => '/sidekiq'
#   end
end