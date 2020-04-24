Rails.application.routes.draw do
	root to: 'pages#home'

  devise_for :users

  resources :products, only: [:index, :show]
  resources :orders, only: [:create, :update, :destroy]
  resources :carts, only: [:show]

  get 'cart/:id/checkout', to: 'carts#checkout', as: 'cart_checkout'
end
