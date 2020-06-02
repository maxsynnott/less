Rails.application.routes.draw do
  root to: 'stores#index'

  # ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # Simple resources
  resources :cart_items, only: [:create]
  resources :deliveries, only: [:edit, :update]
  resources :carts, only: [:edit, :update]
  resources :orders, only: [:index]
  resources :stores, only: [:show, :index]
  #

  # Complex resources
  # resources :recipes, only: [:index, :show, :new, :create] do
  #   collection do
  #     post ":id/toggle_like", to: "recipes#toggle_like", as: :toggle_like
  #     post ":id/add_to_cart", to: "recipes#add_to_cart", as: :add_to_cart
  #   end
  # end
  
  resources :products, only: [:index, :show] do
    collection do
      get "autocomplete"
    end
  end
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

    resources :payments, only: [:new]
  end
end
