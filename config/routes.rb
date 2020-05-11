Rails.application.routes.draw do
  root to: 'products#index'

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #

  # Overriding devise controllers
  devise_for :users, controllers: { 
  	# registrations: 'users/registrations'
  }
  #

  # Simple resources
  resources :cart_items, only: [:create, :update, :destroy]
  resources :deliveries, only: [:index, :edit, :update]
  resources :products, only: [:index]
  resources :orders, only: [:index]
  #

  # Complex resources
  resources :recipes, only: [:index, :show, :new, :create] do
    collection do
      post ":id/like", to: "recipes#like", as: :like
      post ":id/add_to_cart", to: "recipes#add_to_cart", as: :add_to_cart
    end
  end
  #

  # Other routes
  get "cart", to: "carts#show", as: :cart
  #

  namespace :stripe do
    # stripe_event gem Engine
    mount StripeEvent::Engine, at: '/webhook', as: :event
    #

    resources :checkouts, only: [:new] do
      collection do
        get "success"
      end
    end
  end
end
