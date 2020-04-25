Rails.application.routes.draw do
	root to: 'pages#home'

  devise_for :users, controllers: { 
  	registrations: 'users/registrations'
  }

  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :carts, only: [:show]

  get 'cart/:id/checkout', to: 'carts#checkout', as: 'cart_checkout'
end
