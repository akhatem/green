require 'sidekiq/web'

Rails.application.routes.draw do
  
  namespace :system do
    get 'offers/index'
    get 'offers/show'
    get 'offers/edit'
  end
  # devise_for :users
  
  get "/", to: redirect("/system")
  # get "/system", to: redirect("/system/users/login")
  
  # namespace system
  namespace :system do
    
    
    devise_for :users, path: '/users', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {}
    devise_scope :system_user do
      get '/users/index', to: "users#index"
      get "/users/:id/show", to: "users#show"
      put "/users/:id/edit", to: "users#edit"
      delete '/users/:id/delete', to: "users#destroy"
   end
    
    root to: 'static_pages#index'

    
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
    resources :notifications, except: [:destroy]

    # Offers
    resources :offers, except: [:destroy]

    # mount Ckeditor::Engine => '/ckeditor'
    resources :sms_messages

    resources :settings
    
  end # namespace system

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
      resource :brands, only: [:index, :show, :latest] do
        get '/', to: 'brands#index'

        # Categories
        get '/:brand_id/categories', to: 'categories#index'

        # Items
        get '/:brand_id/categories/:category_id/items', to: 'items#index'
        get '/:brand_id/categories/items/latest', to: 'items#latest'
        get '/:brand_id/categories/:category_id/items/:item_id', to: 'items#show'
      end # Brands

            # Settings
      resource :settings do
        get '/about_us', to: 'settings#about_us'
        get '/contact_us', to: 'settings#contact_us'
      end # Settings


      # Offers
      resource :offers do
        get '/', to: 'offers#index'
        get '/:id', to: 'offers#show'
      end
      get '/offers_carosel', to: 'offers#offers_carosel'
      # Offers

      # Notifications
      get '/notifications', to: 'notifications#index'
      get '/notifications/:id', to: 'notifications#show'
      # Notifications

    end # v1
  end # api
end