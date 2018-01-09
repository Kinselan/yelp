Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  # resources :businesses

  root to: "pages#front"

  resources :users
  # resources :businesses
  # resources :reviews




  resources :businesses do
    resources :reviews
  end



  get  '/register', to: 'users#new'
  post '/users/new', to: 'users#create' # todo - use resources.. why doesn't below work?
  # resources :users, only: [:create]
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  get  '/logout',   to: 'sessions#destroy'






end
