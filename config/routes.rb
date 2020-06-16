Rails.application.routes.draw do
  scope "(:locale)", locale: /en|de/ do
    root to: 'items#index'

    # ActiveAdmin routes
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    #

    # Sidekiq
    require "sidekiq/web"

    authenticate :admin_user do
      mount Sidekiq::Web => '/sidekiq'
    end
    #

    devise_for :users, controllers: {
      registrations: "users/registrations"
    }

    # Simple resources
    resources :cart_items, only: [:create]
    resources :carts, only: [:edit, :update]
    resources :orders, only: [:index, :new, :create, :show]
    #

    # Complex resources
    resources :recipes, only: [:index, :show, :new, :create] do
      collection do
        post ":id/toggle_like", to: "recipes#toggle_like", as: :toggle_like
        post ":id/add_to_cart", to: "recipes#add_to_cart", as: :add_to_cart
      end
    end

    resources :items, only: [:index, :show] do
      collection do
        get "autocomplete"
      end
    end

    resources :deliveries, only: [:edit, :update] do
      get "tracker", action: :tracker, as: :tracker
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

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :orders, only: [:create] do
          collection do
            post "check_validity"
            post ":id/pay", action: :pay, as: :pay
          end
        end

        resources :deliveries, only: [:update]

        namespace :stripe do
          resources :setup_intents, only: [:create]
        end
      end
    end
  end
end
