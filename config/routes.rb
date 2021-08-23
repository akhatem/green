require 'sidekiq/web'

Rails.application.routes.draw do
  
  devise_for :users, path: '/users',
  controllers: {registrations: 'users/new_user', sessions: :users} 

  devise_scope :user do
    root to: 'users#login'
    get "/users/sign_out", to: "users#destroy"
    
    get '/users/index', to: "users#index"
    get "/users/:id/show", to: "users#show"
    get '/users/new', to: "users#new_user"
    post '/users/create', to: "users#create_user"
    delete '/users/:id/delete', to: "users#destroy_user"
  end

  
  # namespace system
  namespace :system do

    root to: 'static_pages#index'
    
    # Offer Carosel Images
    resources :offer_carosel_images
    
    
    resources :points_movements, only: [:index, :show, :new, :create]

    # Receipts
    resources :receipts

    # Customers
    resources :customers, only: [:index, :show] 

    # Cities
    resources :cities
    
    # Branches
    resources :branches

    # Brands
    resources :brands

    # Categories
    resources :categories

    # Items
    resources :items

    # Sizes
    resources :sizes

    # Item sizes
    resources :item_sizes, except: [:show]

    # Notifications
    resources :notifications

    # Offers
    resources :offers
    
    # Sms Messages
    resources :sms_messages

    # Settings
    resources :settings
    
    # mount Ckeditor::Engine => '/ckeditor'
    
    # Sidekiq
    mount Sidekiq::Web => "/sidekiq"
    
  end # namespace system

  namespace :cashier do

    # root to: 'cashier_pages#barcode_search'

    # Cashier Pages
    get "/", to: redirect("cashier/barcode_search")
    # get "/", to: redirect("/users/login")
    get "/barcode_search", to: "cashier_pages#barcode_search", as: 'barcode_search'
    get "/customer_info/:decoded_barcode", to: "cashier_pages#customer_info", as: 'customer_info'
    get '/redeem_points/:receipt_number', to: "cashier_pages#redeem_points", as: 'redeem_points'
  end

  # namespace Api::V1
  namespace :api do
    namespace :v1 do

    # Customers
      resource :customers, only: [:index, :show] do
        # Customers signup and login
        post '/signup', to: 'customers#create'
        post '/login', to: 'customers#login'
        post '/verify_account', to: 'customers#verify_account'
        post '/forgot_password_mobile', to: 'customers#forgot_password_mobile'
        post '/forgot_password_verification_code', to: 'customers#forgot_password_verification_code'
        post '/password_reset', to: 'customers#password_reset'
        get '/resend_verification_code', to: 'customers#resend_verification_code'
        
        # get '/auto_login', to: 'customers#auto_login'

        # Customers show and edit
        get '/customer', to: 'customers#show'
        patch '/customer/edit', to: 'customers#update'
        get '/notification_check', to: 'customers#notification_check'

        # Points movement
        resource :points_movements, only: [:index] do
          get '/', to: 'points_movements#index'
        end
        # Points movement
      end # customers

      # Cities
      resource :cities do
        get '/', to: "cities#index"
        # Branches
        get '/branches', to: 'branches#index'
        get '/:city_id/branches/:branch_id', to: 'branches#show'
        # Branches
      end # Cities

      # Brands      
      resource :brands, only: [:index, :show] do
        get '/', to: 'brands#index'

        # Categories
        get '/:brand_id/categories', to: 'categories#index'

        # Items
        get '/:brand_id/categories/:category_id/items', to: 'items#index'
        get '/:brand_id/categories/items/popular_items', to: 'items#popular_items', as: 'popular_items' 
        get '/:brand_id/categories/:category_id/items/:item_id', to: 'items#show'
      end # Brands

            # Settings
      resource :settings do
        get '/about_us', to: 'settings#about_us'
        get '/contact_us', to: 'settings#contact_us'
      end # Settings


      # Offers
      resource :offers, only: [:index, :show] do
        get '/', to: 'offers#index'
        get '/:id', to: 'offers#show'
      end
      get '/offers_carosel', to: 'offers#offers_carosel'
      # Offers

      # Notifications
      get '/notifications', to: 'notifications#index'
      get '/notifications/:id', to: 'notifications#show'
      # Notifications

      # Push notifications
      get '/push_notification', to: 'push_notifications#index'
      # Push notifications

    end # v1
  end # api
end