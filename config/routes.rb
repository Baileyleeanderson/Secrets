Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :secrets
  resources :likes
  post 'secrets/like' => 'secrets#like'
  root 'users#index'
  
end
