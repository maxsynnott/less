Rails.application.routes.draw do
  scope "(:locale)", locale: /en|de/ do
    root to: 'items#index'

    # ActiveAdmin routes
    ActiveAdmin.routes(self)
    #

    # Sidekiq
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
    #

    devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    }

    # Simple resources
    resources :cart_items, only: [:create]
    resources :carts, only: [:edit, :update]
    resources :deliveries, only: [:edit, :update, :index, :show]
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

    resources :orders, only: [:index, :new, :create, :show] do
      member do
        get :track, action: :track
      end
    end
    #

    namespace :stripe do
      # stripe_event gem Engine
      mount StripeEvent::Engine, at: '/webhook', as: :event
      #

      resources :payment_methods, only: [:new]
    end

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :orders, only: [:create] do
          collection do
            post "check_validity"
            post ":id/pay", action: :pay, as: :pay
          end
        end

        post "users/:id/update_driver_coordinates", to: "users#update_driver_coordinates", as: :update_driver_coordinates

        resources :deliveries, only: [:update]
        resources :cart_items, only: [:update, :destroy]

        namespace :stripe do
          resources :setup_intents, only: [:create]
        end
      end
    end
  end
end
