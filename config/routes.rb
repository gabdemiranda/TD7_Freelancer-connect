Rails.application.routes.draw do
  devise_for :views
  devise_for :freelancer_users
  devise_for :regular_users
  root to: 'home#index'
  get 'search', to: "home#search"
  get 'show_profile', to: 'profiles#show_profile'
  resources :projects, only: [:show, :new, :create] do 
    post 'close', on: :member
    get 'my_projects', on: :collection
    resources :proposals, only: [:show, :new, :create], shallow: true do
      resources :freelancer_feedbacks, only: %i[create show], shallow: true
      post 'accept', on: :member
      post 'reject', on: :member
    end
  end
  resources :proposals, only: [:index]
  resources :profiles, only: [:show, :new, :create]
  
  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index]
    end
  end
end
