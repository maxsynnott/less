Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'cart/:id/checkout', to: 'carts#checkout', as: 'cart_checkout'
end
