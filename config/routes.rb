Rails.application.routes.draw do
  devise_for :views
  devise_for :freelancer_users
  devise_for :regular_users
  root to: 'home#index'
  get 'my_profile', to: 'users#my_profile'
  resources :projects, only: [:show, :new, :create]
  resources :profiles, only: [:show, :new, :create]
end
