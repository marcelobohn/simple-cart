Rails.application.routes.draw do
  root to: 'cart#index'
  get 'cart', to: 'cart#index'
  get 'cart/new'
  post 'cart/add', to: 'cart#add'
  post 'cart/update', to: 'cart#update'
  post 'cart/remove', to: 'cart#remove'

  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
