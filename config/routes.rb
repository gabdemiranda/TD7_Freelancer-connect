Rails.application.routes.draw do
  devise_for :regular_users
  root to: 'home#index'
  resources :projects, only: [:show, :new, :create]
end
