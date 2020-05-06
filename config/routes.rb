Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
	root to: 'pages#home'

  devise_for :users, controllers: { 
  	registrations: 'users/registrations'
  }

  mount StripeEvent::Engine, at: '/stripe/webhook'

  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :carts, only: [:show]
  resources :orders, only: [:index]
  resources :deliveries, only: [:index, :edit, :update]
  resources :billings, only: [:create]
  resources :recipes, only: [:index, :show]
end
