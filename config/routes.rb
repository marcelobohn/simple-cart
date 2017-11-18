Rails.application.routes.draw do
  get 'cart', to: 'cart#index'
  get 'cart/new'

  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
