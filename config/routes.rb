Hmluther::Application.routes.draw do

  match 'remote_sign_up', to: 'remote_content#remote_sign_up', via: [:get]
  match 'remote_login', to: 'remote_content#remote_login', via: [:get]
  get 'category/:category', to: 'items#category', as: :category

  # get 'contact', to: 'contact#index'
  # get 'maker/:maker', to: 'items#maker', as: :maker
  # get 'features', to: 'features#index'
  # get 'terms-of-service', to: 'terms_of_service#index'

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  resources "contacts", only: [:new, :create]
  resources :designers
  resources :images
  resources :items
  resources :pages
  resources :users
  
  resources :collections do
    get 'slideshow', on: :member
    resources :collection_items
  end

  root :to => "home#index"

end