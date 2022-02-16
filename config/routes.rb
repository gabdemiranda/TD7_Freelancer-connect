# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :views
  devise_for :freelancer_users
  devise_for :regular_users
  root to: 'home#index'
  mount Sidekiq::Web => '/sidekiq'
  get 'search', to: 'home#search'
  get 'show_profile', to: 'profiles#show_profile'
  resources :projects, only: %i[show new create] do
    post 'close', on: :member
    get 'my_projects', on: :collection
    resources :proposals, only: %i[show new create], shallow: true do
      resources :freelancer_feedbacks, only: %i[create show], shallow: true
      post 'accept', on: :member
      post 'reject', on: :member
    end
  end
  resources :proposals, only: [:index]
  resources :profiles, only: %i[show new create]

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index]
      resources :api_users, only: %i[create]
      post '/login', to: "api_users#login"
      get '/auto_login', to: "api_users#auto_login"
    end
  end
end
