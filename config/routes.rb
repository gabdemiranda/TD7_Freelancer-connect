Rails.application.routes.draw do
  devise_for :views
  devise_for :freelancer_users
  devise_for :regular_users
  root to: 'home#index'
  get 'search', to: "home#search"
  get 'show_profile', to: 'profiles#show_profile'
  resources :projects, only: [:show, :new, :create] do 
    resources :proposals, only: [:show, :new, :create], shallow: true
  end
  resources :profiles, only: [:show, :new, :create]
  
end
