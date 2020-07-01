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

    post "order_items/:id/add_to_cart", to: "order_items#add_to_cart", as: "add_to_cart_order_item"

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
        get :receipt, action: :receipt
        post :add_to_cart, action: :add_to_cart
      end
    end
    #

    namespace :stripe do
      # stripe_event gem Engine
      mount StripeEvent::Engine, at: '/webhook', as: :event
      #

      get "payment_intents/:id/confirm", to: "payment_intents#confirm", as: :payment_intents_confirm
    end

    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :orders, only: [:show] do
          collection do
            post "breakdown"
          end
        end

        post "users/:id/update_driver_coordinates", to: "users#update_driver_coordinates", as: :update_driver_coordinates

        resources :deliveries, only: [:update]
        resources :cart_items, only: [:update, :destroy]
      end
    end
  end
end
